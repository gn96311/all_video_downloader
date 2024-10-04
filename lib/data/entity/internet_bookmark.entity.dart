import 'package:all_video_downloader/domain/model/internet_bookmark/internet_bookmark.model.dart';
import 'package:all_video_downloader/domain/model/internet_history/internet_history.model.dart';
import 'package:all_video_downloader/domain/model/internet_tab/internet_tab.model.dart';
import 'package:hive/hive.dart';

part 'internet_bookmark.entity.g.dart';

@HiveType(typeId: 2)
class InternetBookmarkEntity extends HiveObject {
  @HiveField(0, defaultValue: '')
  String title;

  @HiveField(1, defaultValue: '')
  String url;

  @HiveField(2, defaultValue: '')
  String faviconPath;

  @HiveField(3, defaultValue: false)
  bool isImportant;

  @HiveField(4, defaultValue: '')
  String bookmarkId;


  InternetBookmarkEntity({
    required this.title,
    required this.url,
    required this.faviconPath,
    required this.isImportant,
    required this.bookmarkId,
  });
}

extension InternetBookmarkEntityEx on InternetBookmarkEntity {
  InternetBookmarkModel toModel() {
    return InternetBookmarkModel(url: url, faviconPath: faviconPath, title: title, isImportant: isImportant, bookmarkId: bookmarkId);
  }
}