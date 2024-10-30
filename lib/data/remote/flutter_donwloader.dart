import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:all_video_downloader/core/theme/constant/app_icons.dart';
import 'package:all_video_downloader/data/remote/video_download.dart';
import 'package:all_video_downloader/presentation/pages/progress_tab/provider/video_download_progress/download_monitor.dart';
import 'package:all_video_downloader/presentation/pages/progress_tab/provider/video_download_progress/video_download_progress.provider.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SegmentDownloader {
  Map<String, String> urlToSegmentPathMap;
  Map<String, String> headers;
  String saveDir;
  int lastProgress = 0;
  DateTime lastUpdate = DateTime.now();
  List<String> segmentDownloadIds = [];
  double totalDownloadedSize = 0.0;
  double downloadSpeed = 0.0;
  double previousDownloadedBytes = 0.0;
  String outputFileName;
  String? firstSegmentTaskId;
  String downloadCompleterUUID;
  List<String> segmentPaths;
  WidgetRef ref;

  final Map<String, DownloadTaskStatus> _taskStatusMap = {};
  final Map<String, Completer<void>> _taskCompleters = {};
  late final ProviderSubscription _downloadMonitorSubscription;

  SegmentDownloader({
    required this.downloadCompleterUUID,
    required this.urlToSegmentPathMap,
    required this.segmentPaths,
    required this.headers,
    required this.saveDir,
    required this.outputFileName,
    required this.ref,
  });

  Future<void> startDownload() async {
    print('start download Video');
    final completer = Completer<void>();
    _taskCompleters[downloadCompleterUUID] = completer;
    Map<String, int> segmentProgressMap = {};
    Map<String, String> taskIdToUrlMap = {};
    int totalSegmentsLength = urlToSegmentPathMap.entries.length;
    final previousTime = DateTime.now();


    for (var entry in urlToSegmentPathMap.entries) {
      final taskId = await FlutterDownloader.enqueue(
        url: entry.key,
        savedDir: saveDir,
        fileName: entry.value,
        showNotification: false,
        openFileFromNotification: false,
        headers: headers,
      );
      _taskStatusMap[taskId!] = DownloadTaskStatus.undefined;
      segmentDownloadIds.add(taskId!);
      taskIdToUrlMap[taskId] = entry.key;
      firstSegmentTaskId ??= taskId;
    }

    _downloadMonitorSubscription =
        ref.listenManual<Map<String, DownloadMonitorState>>(
            downloadMonitorProvider, (previous, next) async {
          bool allComplete = true;
          bool anyFailed = false;

          for (String taskId in segmentDownloadIds) {
            final downloadState = next[taskId];
            if (downloadState != null) {
              DownloadTaskStatus status = downloadState.status;
              int progress = downloadState.progress;

              _taskStatusMap[taskId] = status;
              segmentProgressMap[taskId] = progress;
              final url = taskIdToUrlMap[taskId];

              if (status != DownloadTaskStatus.complete) {
                allComplete = false;
              }
              if (status == DownloadTaskStatus.failed) {
                anyFailed = true;
              }
            }
          }

          totalDownloadedSize = await getTotalDownloadedSize(saveDir);

          // 다운로드 속도 계산
          downloadSpeed = calculateDownloadSpeed(totalDownloadedSize, previousTime);

          // 전체 진행도 계산
          double totalProgress = segmentProgressMap.values.fold(
              0, (sum, p) => sum + p);
          double overallProgress = totalProgress / totalSegmentsLength;

          // 상태 업데이트
          ref.read(VideoDownloadProgressProvider.notifier).updateDownloadQueue(
            downloadCompleterUUID,
            null,
            totalDownloadedSize,
            downloadSpeed,
            overallProgress,
            DownloadTaskStatus.running,
          );

          // 첫 번째 세그먼트 완료 시 썸네일 생성
          if (!_thumbnailGenerated && _taskStatusMap[firstSegmentTaskId] ==
              DownloadTaskStatus.complete) {
            final firstSegmentPath = '$saveDir/${urlToSegmentPathMap[firstSegmentTaskId]}';
            String thumbnail = await generateThumbnail(firstSegmentPath);
            ref.read(VideoDownloadProgressProvider.notifier)
                .updateDownloadQueue(
                downloadCompleterUUID, thumbnail, null, null, null, null);
            _thumbnailGenerated = true;
          }

          if (allComplete) {
            // 모든 세그먼트 다운로드 완료 시 병합 시작
            await mergeSegmentsFuction(
                downloadCompleterUUID, segmentPaths, outputFileName, ref);
            // 구독 해제
            _downloadMonitorSubscription.close();
            completer.complete();
          } else if (anyFailed) {
            // 실패 처리
            ref.read(VideoDownloadProgressProvider.notifier)
                .updateDownloadQueue(
              downloadCompleterUUID, null, totalDownloadedSize, 0,
              overallProgress, DownloadTaskStatus.failed,);
            // 구독 해제
            _downloadMonitorSubscription.close();
            completer.completeError('Download failed');
          }
        });
    await completer.future;
  }

  bool _thumbnailGenerated = false;

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

  Future<String> generateThumbnail(String segmentPath) async {
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

  double calculateDownloadSpeed(double downloadedSize, DateTime previousTime) {
    DateTime currentTime = DateTime.now();
    final timeDiff = currentTime.difference(previousTime).inMilliseconds;
    if (timeDiff > 0) {
      final downloadPerSecond = downloadedSize / (timeDiff / 1000);
      return downloadPerSecond;
    }
    return 0.0;
  }

  Future<void> pauseDownload() async {
    ref.read(VideoDownloadProgressProvider.notifier).updateDownloadQueue(downloadCompleterUUID, null, null, null, null, DownloadTaskStatus.paused);
    for (String taskId in segmentDownloadIds) {
      await FlutterDownloader.pause(taskId: taskId);
    }
  }

  Future<void> resumeDownload() async {
    ref.read(VideoDownloadProgressProvider.notifier).updateDownloadQueue(downloadCompleterUUID, null, null, null, null, DownloadTaskStatus.running);
    for (String taskId in segmentDownloadIds) {
    await FlutterDownloader.resume(taskId: taskId);
    }
  }

  Future<void> cancelDownload() async {
    ref.read(VideoDownloadProgressProvider.notifier).updateDownloadQueue(downloadCompleterUUID, null, null, null, null, DownloadTaskStatus.canceled);
    for (String taskId in segmentDownloadIds) {
      await FlutterDownloader.cancel(taskId: taskId);
    }
    segmentDownloadIds.clear();
    ref.read(VideoDownloadProgressProvider.notifier).deleteDownloadQueue(downloadCompleterUUID);
  }
}
