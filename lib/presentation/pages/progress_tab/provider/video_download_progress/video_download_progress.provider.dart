import 'package:all_video_downloader/domain/model/video_download/video_download_model.dart';
import 'package:all_video_downloader/presentation/pages/progress_tab/provider/video_download_progress/video_download_progress.state.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class VideoDownloadProgressNotifier
    extends StateNotifier<VideoDownloadProgressState> {
  VideoDownloadProgressNotifier()
      :super(VideoDownloadProgressState(downloadList: []));

  void insertNewDownloadQueue(List<String> segmentUrls, String uuid, String title) {
    VideoDownloadModel newVideoDownloadQueue = VideoDownloadModel(
      id: uuid,
      segmentUrls: segmentUrls,
      title: title.replaceAll(' ', '_'),
      backgroundImageUrl: '',
      downloadedSized: 0.0,
      downloadSpeed: 0.0,
      downloadProgress: 0.0,
      downloadStatus: DownloadTaskStatus.undefined,
    );
    state = state.copyWith(
      downloadList: [...state.downloadList, newVideoDownloadQueue],
    );
  }

  void updateDownloadQueue(String id, String? backgroundImageUrl, double? downloadedSized, double? downloadSpeed, double? downloadProgress, DownloadTaskStatus? downloadStatus) {
    List<VideoDownloadModel> updatedList = state.downloadList.map((item) {
      if (item.id == id){
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
    state = state.copyWith(downloadList: updatedList);
  }
}

final VideoDownloadProgressProvider = StateNotifierProvider<VideoDownloadProgressNotifier, VideoDownloadProgressState>((ref) {
  return VideoDownloadProgressNotifier();
});