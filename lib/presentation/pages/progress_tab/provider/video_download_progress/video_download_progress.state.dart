import 'package:all_video_downloader/core/utils/error/error_response.dart';
import 'package:all_video_downloader/presentation/pages/progress_tab/provider/video_download_progress/video_download_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_download_progress.state.freezed.dart';

@freezed
class VideoDownloadProgressState with _$VideoDownloadProgressState {
  const factory VideoDownloadProgressState({
    @Default(<String, VideoDownloadItem> {}) Map<String, VideoDownloadItem> downloadItems,
    @Default(ErrorResponse()) ErrorResponse error,
  }) = _VideoDownloadProgressState;
}