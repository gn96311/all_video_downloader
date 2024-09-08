import 'package:all_video_downloader/core/utils/error/error_response.dart';
import 'package:all_video_downloader/domain/model/internet_history/internet_history.model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'internet_history.state.freezed.dart';

@freezed
class InternetHistoryState with _$InternetHistoryState {
  const factory InternetHistoryState({
    @Default(<InternetHistoryModel>[]) List<InternetHistoryModel> historyList,
    @Default(ErrorResponse()) ErrorResponse error,
  }) = _InternetHistoryState;
}
