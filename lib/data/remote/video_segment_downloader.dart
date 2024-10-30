// uuid를 이름으로 가지는 폴더를 만들고, 그 안에 다운로드 해야함.
import 'dart:async';
import 'dart:io';

import 'package:all_video_downloader/core/theme/constant/app_icons.dart';
import 'package:all_video_downloader/data/remote/video_download.dart';
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
  final title = videoDownloadModel.title;
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

  final previousTime = DateTime.now();
  double totalDownloadedSize = 0.0;
  double downloadSpeed = 0.0;
  bool _thumbnailGenerated = false;
  String? firstSegmentTaskId;

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
    taskStatus[taskId!] = TaskInfo(status: DownloadTaskStatus.enqueued, progress: 0);
    firstSegmentTaskId ??= taskId;
  }
  ref.read(progressProvider.notifier).updateDownloadQueue(id, null, null, null, null, null, null, taskStatus);

  ref.listen(progressProvider, (previousState, currentState) async {
    final videoModel = currentState.downloadInformationList.firstWhere((model) => model.id == id);
    if (videoModel != null) {
      double totalProgress = 0.0;
      for (String taskId in videoModel.taskStatus.keys){
        int progress = videoModel.taskStatus[taskId]!.progress;
        totalProgress += progress;
      }

      // 전체 진행도
      double overallProgress = totalProgress / videoModel.taskStatus.length;

      // 전체 다운로드 사이즈
      totalDownloadedSize = await getTotalDownloadedSize(saveDir);

      // 다운로드 속도
      downloadSpeed = calculateDownloadSpeed(totalDownloadedSize, previousTime);

      ref.read(progressProvider.notifier).updateDownloadQueue(id, null, totalDownloadedSize, downloadSpeed, overallProgress, DownloadTaskStatus.running, null, null);

      // 썸네일 생성이 안되어 있고, 첫번째 세그먼트의 다운로드 상태가 Complete일 때 실행됨.
      if (!_thumbnailGenerated && videoModel.taskStatus[firstSegmentTaskId]!.status == DownloadTaskStatus.complete){
        final firstSegmentUrl = urlToSegmentPathMap.entries.firstWhere((entry) => entry.value == firstSegmentTaskId)!.key;
        if (firstSegmentUrl != null) {
          final firstSegment = '${segmentsDir.path}/${urlToSegmentPathMap[firstSegmentUrl]}';
          String thumbnail = await generateThumbnail(saveDir, firstSegment);
          _thumbnailGenerated = true;

          ref.read(progressProvider.notifier).updateDownloadQueue(id, thumbnail, null, null, null, null, null, null);
        }
      }

      final allTaskCompleted = videoModel.taskStatus.values.every((taskInfo) =>
        taskInfo.status == DownloadTaskStatus.complete ||
        taskInfo.status == DownloadTaskStatus.canceled ||
        taskInfo.status == DownloadTaskStatus.failed
      );

      final isAllTaskComplete = videoModel.taskStatus.values.every((taskInfo) =>
      taskInfo.status == DownloadTaskStatus.complete);

      if (allTaskCompleted && !completer.isCompleted){
        if (isAllTaskComplete) {
          await mergeSegmentsFuction(id, segmentPaths, title, ref);
        }
        completer.complete();
      }
    }
  });
  return completer.future;
}

Future<double> getTotalDownloadedSize(String saveDir) async {
  final directory = Directory(saveDir);
  double totalSizeInMB = 0.0;
  if (directory.existsSync()) {
    final files = directory.listSync();
    for (var file in files) {
      if (file is File) {
        int fileSizeInBytes = await file.length();
        double fileSizeInMB = fileSizeInBytes / (1024 * 1024);
        totalSizeInMB += fileSizeInMB;
      }
    }
  }
  return totalSizeInMB;
}

double calculateDownloadSpeed(double downloadedSize, DateTime previousTime) {
  DateTime currentTime = DateTime.now();
  final timeDiff = currentTime.difference(previousTime).inMilliseconds;
  if (timeDiff > 0) {
    final downloadPerSecond = downloadedSize / (timeDiff / 1000);
    return downloadPerSecond;
  }
  return 0.0;
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