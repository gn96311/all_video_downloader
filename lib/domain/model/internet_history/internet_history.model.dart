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