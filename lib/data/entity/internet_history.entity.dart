import 'package:all_video_downloader/domain/model/internet_history/internet_history.model.dart';
import 'package:all_video_downloader/domain/model/internet_tab/internet_tab.model.dart';
import 'package:hive/hive.dart';

part 'internet_history.entity.g.dart';

@HiveType(typeId: 1)
class InternetHistoryEntity extends HiveObject {
  @HiveField(0, defaultValue: '')
  String title;

  @HiveField(1, defaultValue: '')
  String url;

  @HiveField(2, defaultValue: '')
  String faviconPath;

  @HiveField(3, defaultValue: '')
  String VisitedTime;

  InternetHistoryEntity({
    required this.title,
    required this.url,
    required this.faviconPath,
    required this.VisitedTime
  });
}

extension InternetHistoryEntityEx on InternetHistoryEntity {
  InternetHistoryModel toModel() {
    return InternetHistoryModel(url: url, faviconPath: faviconPath, title: title, VisitedTime: VisitedTime);
  }
}