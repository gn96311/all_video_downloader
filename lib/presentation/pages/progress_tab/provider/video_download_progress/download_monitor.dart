import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DownloadMonitorState {
  final String id;
  final DownloadTaskStatus status;
  final int progress;

  DownloadMonitorState({required this.id, required this.status, required this.progress});
}

class DownloadMonitorNotifier extends StateNotifier<Map<String, DownloadMonitorState>> {
  DownloadMonitorNotifier() : super({});

  void addDownloadProgress(String id, DownloadTaskStatus status, int progress) {
    state = {
      ...this.state,
      id: DownloadMonitorState(id: id, status: status, progress: progress)
    };
  }

  void updateDownloadProgress(String id, DownloadTaskStatus status,
      int progress) {
    if (this.state.containsKey(id)) {
      state = {
        ...this.state,
        id: DownloadMonitorState(id: id, status: status, progress: progress)
      };
    }
  }
}

final downloadMonitorProvider = StateNotifierProvider<DownloadMonitorNotifier, Map<String, DownloadMonitorState>>((ref) {
  return DownloadMonitorNotifier();
});