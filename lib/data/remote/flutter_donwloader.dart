import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:all_video_downloader/presentation/pages/progress_tab/provider/video_download_progress/video_download_progress.provider.dart';
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

  static final Map<String, DownloadTaskStatus> _taskStatusMap = {};
  static final Map<String, Completer<void>> _taskCompleters = {};

  SegmentDownloader({
    required this.urlToSegmentPathMap,
    required this.headers,
    required this.saveDir,
    required this.outputFileName,
  });

  Future<void> startDownload(WidgetRef ref) async {
    var downloadCompleterUUID = Uuid().toString();
    ref.read(VideoDownloadProgressProvider.notifier).insertNewDownloadQueue(urlToSegmentPathMap.keys.toList(), downloadCompleterUUID, outputFileName);
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
    }

    final port = IsolateNameServer.lookupPortByName('downloader_send_port') as ReceivePort;
    port.listen((dynamic data) async {
      String id = data[0];
      int status = data[1];
      int progress = data[2];
      final taskStatus = DownloadTaskStatus.values[status];

      segmentProgressMap[id] = progress;
      _taskStatusMap[id] = taskStatus;
      
      final filePath = '$saveDir/${urlToSegmentPathMap.entries.firstWhere((e) => e.key == id).value}';
      final file = File(filePath);
      if (file.existsSync()) {
        // 다운로드 된 사이즈
        totalDownloadedSize += await file.length();
      }

      //다운로드 속도
      downloadSpeed = calculateDownloadSpeed(totalDownloadedSize) ?? 0;

      int totalProgress = segmentProgressMap.values.fold(0, (sum, p) => sum + p);
      // 전체 진행도
      double overallProgress = totalProgress / totalSegmentsLength;

      ref.read(VideoDownloadProgressProvider.notifier).updateDownloadQueue(downloadCompleterUUID, null, totalDownloadedSize, downloadSpeed, overallProgress, DownloadTaskStatus.enqueued);


      // TODO: 다운로드 uuid를 통해, 상태 변경까지 설정함.
      // TODO: 멈췄을때, 캔슬했을 때의 REF도 다 설정해야함.
      // TODO: 설정 전, 일단 잘 작동하는지 확인해야함.
      if (_taskStatusMap.values.every((status) => status == DownloadTaskStatus.complete || status == DownloadTaskStatus.failed || status == DownloadTaskStatus.canceled)) {
        _taskCompleters[id]?.complete();
        ref.read(VideoDownloadProgressProvider.notifier).updateDownloadQueue(downloadCompleterUUID, null, totalDownloadedSize, 0, 100, DownloadTaskStatus.complete);
        _taskCompleters.remove(id);
      }
    });
    await completer.future;
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
