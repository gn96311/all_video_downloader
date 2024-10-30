import 'package:all_video_downloader/core/theme/constant/app_icons.dart';
import 'package:all_video_downloader/domain/model/video_download/video_download_model.dart';
import 'package:all_video_downloader/presentation/pages/progress_tab/provider/progress_provider/progress_provider.state.dart';
import 'package:all_video_downloader/presentation/pages/progress_tab/provider/progress_provider/task_info.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class ProgressProviderNotifier
    extends StateNotifier<ProgressProviderState>{
  ProgressProviderNotifier() : super(ProgressProviderState());

  void insertNewDownloadQueue(Map<String, String?> segmentUrls, Map<String, dynamic> responseMap, String title, Map<String, String> headers) async {
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
    final updatedDownloadInformationList = List<VideoDownloadModel>.from(
        state.downloadInformationList)
      ..add(newVideoDownloadQueue);
    updatedDownloadInformationList.sort((a, b) => a.modifiedTime.compareTo(b.modifiedTime));
    state = state.copyWith(
        downloadInformationList: updatedDownloadInformationList
    );
  }

  void updateDownloadQueue(String id, String? backgroundImageUrl, double? downloadedSized, double? downloadSpeed, double? downloadProgress, DownloadTaskStatus? downloadStatus, DateTime? modifiedTime, Map<String, TaskInfo>? taskStatus){
    final existingItemIndex = state.downloadInformationList.indexWhere((item) => item.id == id);
    if (existingItemIndex != -1) {
      final updatedItem = state.downloadInformationList[existingItemIndex].copyWith(
        backgroundImageUrl: backgroundImageUrl ?? state.downloadInformationList[existingItemIndex].backgroundImageUrl,
        downloadedSized: downloadedSized ?? state.downloadInformationList[existingItemIndex].downloadedSized,
        downloadSpeed: downloadSpeed ?? state.downloadInformationList[existingItemIndex].downloadSpeed,
        downloadProgress: downloadProgress ?? state.downloadInformationList[existingItemIndex].downloadProgress,
        downloadStatus: downloadStatus ?? state.downloadInformationList[existingItemIndex].downloadStatus,
        modifiedTime: modifiedTime ?? state.downloadInformationList[existingItemIndex].modifiedTime,
        taskStatus: taskStatus ?? state.downloadInformationList[existingItemIndex].taskStatus,
      );

      final updatedDownloadInformationList = List<VideoDownloadModel>.from(state.downloadInformationList)..[existingItemIndex] = updatedItem;
      state = state.copyWith(downloadInformationList: updatedDownloadInformationList);
    }
  }
}

final progressProvider = StateNotifierProvider<ProgressProviderNotifier, ProgressProviderState>((ref){
  return ProgressProviderNotifier();
});
