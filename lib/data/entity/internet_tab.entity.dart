import 'package:all_video_downloader/domain/model/internet_tab/internet_tab.model.dart';
import 'package:hive/hive.dart';

part 'internet_tab.entity.g.dart';

@HiveType(typeId: 0)
class InternetTabEntity extends HiveObject {
  @HiveField(0, defaultValue: '')
  String title;

  @HiveField(1, defaultValue: '')
  String url;

  @HiveField(2, defaultValue: '')
  String faviconPath;

  @HiveField(3, defaultValue: '')
  String tabId;

  InternetTabEntity({
    required this.title,
    required this.url,
    required this.faviconPath,
    required this.tabId
  });
}

extension InternetTabEntityEx on InternetTabEntity {
  InternetTabModel toModel() {
    return InternetTabModel(url: url, faviconPath: faviconPath, title: title, tabId: tabId);
  }
}