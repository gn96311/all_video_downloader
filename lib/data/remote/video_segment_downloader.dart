import 'dart:async';
import 'dart:io';

import 'package:all_video_downloader/core/theme/constant/app_icons.dart';
import 'package:all_video_downloader/domain/model/video_download/video_download_model.dart';
import 'package:all_video_downloader/presentation/pages/progress_tab/provider/progress_provider/progress_provider.provider.dart';
import 'package:all_video_downloader/presentation/pages/progress_tab/provider/progress_provider/task_info.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

Future<void> startSegmentDownload(
    VideoDownloadModel videoDownloadModel, WidgetRef ref
) async {
  final id = videoDownloadModel.id;
  final selectedUrls = videoDownloadModel.selectedUrls;
  final responseMap = videoDownloadModel.responseMap;
  final headers = videoDownloadModel.headers;
  final selectedData = responseMap[selectedUrls['videoUrl']];
  final segmentUrls = RegExp(r'https?://[^\s]+')
      .allMatches(selectedData)
      .map((m) => m.group(0)!)
      .toList();
  final directory = await getApplicationDocumentsDirectory();
  final segmentsDir = Directory('${directory.path}/$id');
  if (!segmentsDir.existsSync()) {
    segmentsDir.createSync(recursive: true);
  }
  List<String> segmentPaths = [];
  Map<String, String> urlToSegmentPathMap = {};
  bool _thumbnailGenerated = false;
  String? firstSegmentTaskId;
  Map<String, String> taskIdToSegmentFileName = {};

  for (var url in segmentUrls) {
    final segmentName = url.split('/').last;
    final segmentNameWithNewExtension = '${segmentName.split('.').first}.ts';
    final segmentPath = '${segmentsDir.path}/$segmentNameWithNewExtension';
    segmentPaths.add(segmentPath);
    urlToSegmentPathMap[url] = segmentNameWithNewExtension;
  }

  final saveDir = segmentsDir.path;

  final completer = Completer<void>();

  Map<String, TaskInfo> taskStatus = {};

  for (var entry in urlToSegmentPathMap.entries){
    final taskId = await FlutterDownloader.enqueue(
      url: entry.key,
      savedDir: saveDir,
      fileName: entry.value,
      showNotification: false,
      openFileFromNotification: false,
      headers: headers,
    );
    taskStatus[taskId!] = TaskInfo(status: DownloadTaskStatus.enqueued, progress: null);
    firstSegmentTaskId ??= taskId;
    taskIdToSegmentFileName[taskId!] = entry.value;
  }
  taskStatus.updateAll((taskId, taskInfo){
    return taskInfo.progress == null ? TaskInfo(status: taskInfo.status, progress: null) : taskInfo;
  });
  await ref.read(progressProvider.notifier).updateDownloadQueue(id, null, null, null, null, DownloadTaskStatus.running, null, taskStatus, saveDir, segmentPaths, null);

  Timer.periodic(Duration(seconds: 1), (timer) async{
    final videoModel = ref.read(progressProvider).downloadInformationList.firstWhere((model) => model.id == id, orElse: () {
      timer.cancel();
      return VideoDownloadModel.empty();
    });
    // 썸네일 생성이 안되어 있고, 첫번째 세그먼트의 다운로드 상태가 Complete일 때 실행됨.
    if (!_thumbnailGenerated && firstSegmentTaskId != null && videoModel.taskStatus[firstSegmentTaskId]!.status == DownloadTaskStatus.complete){
      final firstSegmentFileName = taskIdToSegmentFileName[firstSegmentTaskId];
      if (firstSegmentFileName != null) {
        final firstSegment = '${segmentsDir.path}/$firstSegmentFileName';
        String thumbnail = await generateThumbnail(saveDir, firstSegment);
        _thumbnailGenerated = true;
        await ref.read(progressProvider.notifier).updateDownloadQueue(id, thumbnail, null, null, null, null, null, null, null, null, null);
        timer.cancel();
      }
    }
  });
  return completer.future;
}

Future<String> generateThumbnail(String saveDir, String segmentPath) async {
  String command = '-y -i $segmentPath -ss 00:00:01 -vframes 1 $saveDir/thumbnail.jpg';
  try {
    await FFmpegKit.execute(command);
    final thumbnailFile = File('$saveDir/thumbnail.jpg');
    if (await thumbnailFile.exists()) {
      return thumbnailFile.path;
    } else {
      print('Here Thumbnail file does not exist after generation.');
      String noThumbnailImage = AppIcons.noThumbnail;
      return noThumbnailImage;
    }
  } catch (e) {
    print('Here Error generating thumbnail: $e');
    String noThumbnailImage = AppIcons.noThumbnail;
    return noThumbnailImage;
  }
}