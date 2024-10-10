import 'package:all_video_downloader/core/utils/error/error_response.dart';
import 'package:all_video_downloader/domain/model/video_download/video_download_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_download_progress.state.freezed.dart';

@freezed
class VideoDownloadProgressState with _$VideoDownloadProgressState {
  const factory VideoDownloadProgressState({
    @Default(<VideoDownloadModel>[]) List<VideoDownloadModel> downloadList,
    @Default(ErrorResponse()) ErrorResponse error,
  }) = _VideoDownloadProgressState;
}

// TODO: 1. m3u8의 세그먼트 url로부터 다운 시작 전에 video_download_progress.state에 값(타이틀, 전체 다운로드 개수, 상태)이 들어가야함.
// TODO: 2. 세그먼트 1개가 다운로드 된 뒤, 이미지 추가.
// TODO: 3. 다운로드가 되면 상태를 DOWNLOADING에서 다른걸로 바꾸어야 함.