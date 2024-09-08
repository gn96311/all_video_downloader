import 'package:all_video_downloader/core/utils/error/error_response.dart';
import 'package:all_video_downloader/domain/model/internet_tab/internet_tab.model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'internet_tab.state.freezed.dart';

@freezed
class InternetTabState with _$InternetTabState {
  const factory InternetTabState({
    @Default(<InternetTabModel>[]) List<InternetTabModel> tabList,
    @Default(ErrorResponse()) ErrorResponse error,
    String? currentTabId,
    String? currentUrl,
  }) = _InternetTabState;
}
