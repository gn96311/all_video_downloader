import 'package:all_video_downloader/data/entity/internet_tab.entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'internet_tab.model.freezed.dart';

@freezed
class InternetTabModel with _$InternetTabModel {
  const factory InternetTabModel({
    required String tabId,
    required String url,
    required String faviconPath,
    required String title,
  }) = _InternetTabModel;

  factory InternetTabModel.newTab() {
    var uuid = Uuid();
    return InternetTabModel(url: '', faviconPath: '', title: '새 탭', tabId: uuid.v4());
  }
}

extension InternetTabModelEx on InternetTabModel{
  InternetTabEntity toEntity() {
    return InternetTabEntity(title: title, url: url, faviconPath: faviconPath, tabId: tabId);
  }
}

//TODO: index 또는 특정한 숫자(삭제할 때 필요한 요소) 추가하여 삭제 활성화.