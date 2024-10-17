import 'package:all_video_downloader/core/theme/constant/app_icons.dart';
import 'package:all_video_downloader/domain/model/download_manager/download_manager.dart';
import 'package:all_video_downloader/domain/model/video_download/video_download_model.dart';
import 'package:all_video_downloader/presentation/pages/progress_tab/provider/video_download_progress/video_download_progress.state.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class VideoDownloadProgressNotifier
    extends StateNotifier<VideoDownloadProgressState> {
  VideoDownloadProgressNotifier()
      :super(VideoDownloadProgressState(downloadList: []));

  void insertNewDownloadQueue(Map<String, String> segmentUrls, Map<String, dynamic> responseMap, String uuid, String title, Map<String, String> headers, WidgetRef ref) {
    VideoDownloadModel newVideoDownloadQueue = VideoDownloadModel(
      id: uuid,
      selectedUrls: segmentUrls,
      responseMap: responseMap,
      headers: headers,
      title: title.replaceAll(' ', '_'),
      backgroundImageUrl: AppIcons.noThumbnail,
      downloadedSized: 0.0,
      downloadSpeed: 0.0,
      downloadProgress: 0.0,
      downloadStatus: DownloadTaskStatus.undefined,
    );
    DownloadManager downloadManager = DownloadManager(newVideoDownloadQueue, ref);
    state = state.copyWith(
      informationList: [...state.informationList, newVideoDownloadQueue],
      downloadList: [...state.downloadList, downloadManager],
    );
  }

  void updateDownloadQueue(String id, String? backgroundImageUrl, double? downloadedSized, double? downloadSpeed, double? downloadProgress, DownloadTaskStatus? downloadStatus) {
    List<VideoDownloadModel> updatedInformationList = state.informationList.map((item) {
      if (item.id == id) {
        return item.copyWith(
          backgroundImageUrl: backgroundImageUrl ?? item.backgroundImageUrl,
          downloadedSized: downloadedSized ?? item.downloadedSized,
          downloadSpeed: downloadSpeed ?? item.downloadSpeed,
          downloadProgress: downloadProgress ?? item.downloadProgress,
          downloadStatus: downloadStatus ?? item.downloadStatus,
        );
      }
      return item;
    }).toList();
    state = state.copyWith(informationList: updatedInformationList);
  }
}

final VideoDownloadProgressProvider = StateNotifierProvider<VideoDownloadProgressNotifier, VideoDownloadProgressState>((ref) {
  return VideoDownloadProgressNotifier();
});