import 'package:all_video_downloader/core/utils/error/error_response.dart';
import 'package:all_video_downloader/domain/model/internet_bookmark/internet_bookmark.model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'internet_bookmark.state.freezed.dart';

@freezed
class InternetBookmarkState with _$InternetBookmarkState {
  const factory InternetBookmarkState({
    @Default(<InternetBookmarkModel>[]) List<InternetBookmarkModel> bookmarkList,
    @Default(ErrorResponse()) ErrorResponse error,
  }) = _InternetBookmarkState;
}
