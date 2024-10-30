import 'package:all_video_downloader/core/utils/error/error_response.dart';
import 'package:all_video_downloader/domain/model/video_download/video_download_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'progress_provider.state.freezed.dart';

@freezed
class ProgressProviderState with _$ProgressProviderState {
  const factory ProgressProviderState({
    @Default(<VideoDownloadModel>[])
    List<VideoDownloadModel> downloadInformationList,
    @Default(false) bool progressDownloading,
    @Default(ErrorResponse()) ErrorResponse error,
  }) = _ProgressProviderState;
}
