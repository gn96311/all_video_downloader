import 'package:all_video_downloader/presentation/pages/progress_tab/provider/progress_provider/task_info.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_download_model.freezed.dart';

@freezed
class VideoDownloadModel with _$VideoDownloadModel {
  const factory VideoDownloadModel({
    required String id,
    required String title,
    required Map<String, String?> selectedUrls,
    required Map<String, dynamic> responseMap,
    required Map<String, String> headers,
    required String backgroundImageUrl,
    required double downloadedSized,
    required double downloadSpeed,
    required double downloadProgress,
    required DownloadTaskStatus downloadStatus,
    required DateTime modifiedTime,
    required Map<String, TaskInfo> taskStatus,
    required String saveDir,
    required List<String> segmentPaths,
    required bool isMerged,
  }) = _VideoDownloadModel;

  factory VideoDownloadModel.empty() {
    return VideoDownloadModel(id: '',
        title: '',
        selectedUrls: {},
        responseMap: {},
        headers: {},
        backgroundImageUrl: '',
        downloadedSized: 0.0,
        downloadSpeed: 0,
        downloadProgress: 0,
        downloadStatus: DownloadTaskStatus.enqueued,
        modifiedTime: DateTime.now(),
        taskStatus: {},
        saveDir: '',
        segmentPaths: [],
        isMerged: true,);
  }
}