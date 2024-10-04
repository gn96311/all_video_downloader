import 'package:all_video_downloader/data/entity/internet_bookmark.entity.dart';
import 'package:all_video_downloader/data/entity/internet_history.entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'internet_bookmark.model.freezed.dart';

@freezed
class InternetBookmarkModel with _$InternetBookmarkModel {
  const factory InternetBookmarkModel({
    required bool isImportant,
    required String url,
    required String faviconPath,
    required String title,
    required String bookmarkId,
  }) = _InternetBookmarkModel;
}

extension InternetBookmarkModelEx on InternetBookmarkModel{
  InternetBookmarkEntity toEntity() {
    return InternetBookmarkEntity(title: title, url: url, faviconPath: faviconPath, isImportant: isImportant, bookmarkId: bookmarkId);
  }
}