import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:all_video_downloader/core/theme/constant/app_icons.dart';
import 'package:all_video_downloader/presentation/pages/progress_tab/provider/video_download_progress/video_download_progress.provider.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class SegmentDownloader {
  Map<String, String> urlToSegmentPathMap;
  Map<String, String> headers;
  String saveDir;
  int lastProgress = 0;
  DateTime lastUpdate = DateTime.now();
  List<String> segmentDownloadIds = [];
  double totalDownloadedSize = 0.0;
  double downloadSpeed = 0.0;
  DateTime previousTime = DateTime.now();
  double previousDownloadedBytes = 0.0;
  String outputFileName;
  String? firstSegmentTaskId;
  String downloadCompleterUUID;
  WidgetRef ref;

  final Map<String, DownloadTaskStatus> _taskStatusMap = {};
  final Map<String, Completer<void>> _taskCompleters = {};

  SegmentDownloader({
    required this.downloadCompleterUUID,
    required this.urlToSegmentPathMap,
    required this.headers,
    required this.saveDir,
    required this.outputFileName,
    required this.ref,
  });

  Future<void> startDownload() async {
    final completer = Completer<void>();
    _taskCompleters[downloadCompleterUUID] = completer;
    Map<String, int> segmentProgressMap = {};
    int totalSegmentsLength = urlToSegmentPathMap.entries.length;

    for (var entry in urlToSegmentPathMap.entries) {
      final taskId = await FlutterDownloader.enqueue(
        url: entry.key,
        savedDir: saveDir,
        fileName: entry.value,
        showNotification: true,
        openFileFromNotification: false,
        headers: headers,
      );
      _taskStatusMap[taskId!] = DownloadTaskStatus.undefined;
      segmentDownloadIds.add(taskId!);
      firstSegmentTaskId ??= taskId;
    }

    final port = IsolateNameServer.lookupPortByName('downloader_send_port') as ReceivePort;
    port.listen((dynamic data) async {
      String id = data[0];
      int status = data[1];
      int progress = data[2];
      final taskStatus = DownloadTaskStatus.values[status];

      segmentProgressMap[id] = progress;
      _taskStatusMap[id] = taskStatus;

      if (id == firstSegmentTaskId && taskStatus == DownloadTaskStatus.complete) {
        final firstSegmentPath = '$saveDir/${urlToSegmentPathMap.entries.firstWhere((e) => e.key == firstSegmentTaskId).value}';
        String thumbnail = await generateThumbnail(firstSegmentPath);
        ref.read(VideoDownloadProgressProvider.notifier).updateDownloadQueue(downloadCompleterUUID, thumbnail, null, null, null, null);
      }

      final filePath = '$saveDir/${urlToSegmentPathMap.entries.firstWhere((e) => e.key == id).value}';
      final file = File(filePath);
      if (file.existsSync()) {
        // 다운로드 된 사이즈
        totalDownloadedSize += await file.length();
      }

      //다운로드 속도
      downloadSpeed = calculateDownloadSpeed(totalDownloadedSize) ?? 0;

      double totalProgress = segmentProgressMap.values.fold(0, (sum, p) => sum + p);
      // 전체 진행도
      double overallProgress = totalProgress / totalSegmentsLength;

      ref.read(VideoDownloadProgressProvider.notifier).updateDownloadQueue(downloadCompleterUUID, null, totalDownloadedSize, downloadSpeed, overallProgress, DownloadTaskStatus.running);

      if (_taskStatusMap.values.every((status) => status == DownloadTaskStatus.complete)) {
        ref.read(VideoDownloadProgressProvider.notifier).updateDownloadQueue(downloadCompleterUUID, null, totalDownloadedSize, 0, 100, DownloadTaskStatus.complete);
        _taskCompleters[id]?.complete();
        _taskCompleters.remove(id);
      } else if (_taskStatusMap.values.any((status) => status == DownloadTaskStatus.failed)) {
        ref.read(VideoDownloadProgressProvider.notifier).updateDownloadQueue(downloadCompleterUUID, null, totalDownloadedSize, 0, overallProgress, DownloadTaskStatus.failed);
        _taskCompleters[id]?.complete();
        _taskCompleters.remove(id);
      } else if (_taskStatusMap.values.any((status) => status == DownloadTaskStatus.canceled)) {
        ref.read(VideoDownloadProgressProvider.notifier).updateDownloadQueue(downloadCompleterUUID, null, totalDownloadedSize, 0, overallProgress, DownloadTaskStatus.canceled);
        _taskCompleters[id]?.complete();
        _taskCompleters.remove(id);
      }
    });
    await completer.future;
  }

  Future<String> generateThumbnail(String segmentPath) async {
    String command = '-i $segmentPath -ss 00:00:01 -vframes 1 $saveDir/thumbnail.jpg';
    try {
      await FFmpegKit.execute(command);
      return '$saveDir/thumbnail.jpg';
    } catch (e) {
      String noThumbnailImage = AppIcons.noThumbnail;
      return noThumbnailImage;
    }
  }

  double? calculateDownloadSpeed(double currentDownloadedBytes) {
    final currentTime = DateTime.now();
    final timeDiff = currentTime.difference(previousTime).inSeconds;
    final bytesDownloaded = currentDownloadedBytes - previousDownloadedBytes;

    if (timeDiff > 0) {
      final downloadSpeedBytes = bytesDownloaded / timeDiff;
      return downloadSpeedBytes;
    }
    previousDownloadedBytes = currentDownloadedBytes;
    previousTime = currentTime;
  }

  // static void updateDownloadStatus(String id, DownloadTaskStatus status) {
  //   _taskStatusMap[id] = status;
  //   if (status == DownloadTaskStatus.complete || status == DownloadTaskStatus.failed || status == DownloadTaskStatus.canceled) {
  //     // 해당 작업의 Completer 완료 처리
  //     _taskCompleters[id]?.complete();
  //     // Completer 맵에서 제거
  //     _taskCompleters.remove(id);
  //   }
  // }

  Future<void> pauseDownload() async {
    for (String taskId in segmentDownloadIds) {
      await FlutterDownloader.pause(taskId: taskId);
    }
  }

  Future<void> resumeDownload() async {
    for (String taskId in segmentDownloadIds) {
    await FlutterDownloader.resume(taskId: taskId);
    }
  }

  Future<void> cancelDownload() async {
    for (String taskId in segmentDownloadIds) {
      await FlutterDownloader.cancel(taskId: taskId);
    }
    segmentDownloadIds.clear();
  }

  void checkProgress() {
    FlutterDownloader.registerCallback((id, status, progress) {
      final now = DateTime.now();
      final timeDiff = now.difference(lastUpdate).inMilliseconds;
      if (progress != lastProgress && (progress - lastProgress).abs() >= 5 && timeDiff > 1000) {
        lastProgress = progress;
        lastUpdate = now;
        print('Download progress: $progress%');
      }
    });
  }
}
