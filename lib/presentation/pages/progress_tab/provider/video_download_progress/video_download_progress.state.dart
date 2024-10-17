import 'package:all_video_downloader/core/utils/error/error_response.dart';
import 'package:all_video_downloader/domain/model/download_manager/download_manager.dart';
import 'package:all_video_downloader/domain/model/video_download/video_download_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_download_progress.state.freezed.dart';

@freezed
class VideoDownloadProgressState with _$VideoDownloadProgressState {
  const factory VideoDownloadProgressState({
    @Default(<VideoDownloadModel>[]) List<VideoDownloadModel> informationList,
    @Default(<DownloadManager>[]) List<DownloadManager> downloadList,
    @Default(ErrorResponse()) ErrorResponse error,
  }) = _VideoDownloadProgressState;
}

// TODO: downloadList, informationList의 2가지를 운용해야함.
// TODO: 1. url을 얻어서, informationList(VideoDownloadModel로 구성됨)에 추가 / 정보만 제공하는 list
// TODO: 2. VideoDownloadModel로 부터 다운로드 매니저 작성하여, 다운로드만 관리 / 다운로드 관리 list
// TODO: 3. Download Manager로부터 업데이트 되는 값은 id를 찾아서 informationList 최신화
// TODO: 4. 완료 시 2개 다 삭제
// TODO: 5. video_download, flutter_downloader 함수를 바꿔야함.