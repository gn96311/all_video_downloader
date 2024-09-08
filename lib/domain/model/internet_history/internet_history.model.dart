import 'package:all_video_downloader/data/entity/internet_history.entity.dart';
import 'package:all_video_downloader/data/entity/internet_tab.entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'internet_history.model.freezed.dart';

@freezed
class InternetHistoryModel with _$InternetHistoryModel {
  const factory InternetHistoryModel({
    required String VisitedTime,
    required String url,
    required String faviconPath,
    required String title,
  }) = _InternetHistoryModel;
}

extension InternetHistoryModelEx on InternetHistoryModel{
  InternetHistoryEntity toEntity() {
    return InternetHistoryEntity(title: title, url: url, faviconPath: faviconPath, VisitedTime: VisitedTime);
  }
}

//TODO: index 또는 특정한 숫자(삭제할 때 필요한 요소) 추가하여 삭제 활성화.