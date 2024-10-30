import 'package:all_video_downloader/core/theme/constant/app_icons.dart';
import 'package:all_video_downloader/domain/model/download_manager/download_manager.dart';
import 'package:all_video_downloader/domain/model/video_download/video_download_model.dart';
import 'package:all_video_downloader/presentation/pages/progress_tab/provider/video_download_progress/video_download_item.dart';
import 'package:all_video_downloader/presentation/pages/progress_tab/provider/video_download_progress/video_download_progress.state.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class VideoDownloadProgressNotifier
    extends StateNotifier<VideoDownloadProgressState> {
  VideoDownloadProgressNotifier()
      :super(VideoDownloadProgressState());

  void insertNewDownloadQueue(Map<String, String?> segmentUrls, Map<String, dynamic> responseMap, String title, Map<String, String> headers, WidgetRef ref) async {
    final String id = Uuid().toString();
    VideoDownloadModel newVideoDownloadQueue = VideoDownloadModel(
      id: id,
      selectedUrls: segmentUrls,
      responseMap: responseMap,
      headers: headers,
      title: title.replaceAll(' ', '_'),
      backgroundImageUrl: AppIcons.noThumbnail,
      downloadedSized: 0.0,
      downloadSpeed: 0.0,
      downloadProgress: 0.0,
      downloadStatus: DownloadTaskStatus.enqueued,
      modifiedTime: DateTime.now(),
      taskStatus: {},
    );
    final downloadManager = await DownloadManager.create(newVideoDownloadQueue, ref, id);
    final newItem = VideoDownloadItem(videoDownloadModel: newVideoDownloadQueue, downloadManager: downloadManager);
    state = state.copyWith(
      downloadItems: {...state.downloadItems, id:newItem}
    );
  }

  void updateDownloadQueue(String id, String? backgroundImageUrl, double? downloadedSized, double? downloadSpeed, double? downloadProgress, DownloadTaskStatus? downloadStatus) {
    final existingItem = state.downloadItems[id];
    if (existingItem != null) {
      final updatedInformationModel = existingItem.videoDownloadModel.copyWith(
        backgroundImageUrl: backgroundImageUrl ?? existingItem.videoDownloadModel.backgroundImageUrl,
        downloadedSized: downloadedSized ?? existingItem.videoDownloadModel.downloadedSized,
        downloadSpeed: downloadSpeed ?? existingItem.videoDownloadModel.downloadSpeed,
        downloadProgress: downloadProgress ?? existingItem.videoDownloadModel.downloadProgress,
        downloadStatus: downloadStatus ?? existingItem.videoDownloadModel.downloadStatus,
      );
      final updatedItem = VideoDownloadItem(videoDownloadModel: updatedInformationModel, downloadManager: existingItem.downloadManager);
      state = state.copyWith(
        downloadItems: {...state.downloadItems, id: updatedItem}
      );
    }
  }

  void deleteDownloadQueue(String id) {
    final existingItem = state.downloadItems[id];
    if (existingItem != null) {
      final updatedItems = Map.of(state.downloadItems);
      updatedItems.remove(id);
      state = state.copyWith(
          downloadItems: updatedItems,
      );
    }
  }
}

final VideoDownloadProgressProvider = StateNotifierProvider<VideoDownloadProgressNotifier, VideoDownloadProgressState>((ref) {
  return VideoDownloadProgressNotifier();
});