import 'package:flutter_downloader/flutter_downloader.dart';

class TaskInfo {
  DownloadTaskStatus status;
  int progress;

  TaskInfo({
    required this.status,
    required this.progress,
  });
}
