import 'package:all_video_downloader/data/common/response_wrapper.dart';
import 'package:all_video_downloader/data/entity/internet_tab.entity.dart';
import 'package:all_video_downloader/domain/model/internet_tab/internet_tab.model.dart';
import 'package:all_video_downloader/domain/repository_interface/repository_interface.dart';

abstract class InternetTabInterfaceRepository extends Repository {
  Future<ResponseWrapper<List<InternetTabModel>>> getInternetTabList();

  Future<ResponseWrapper<List<InternetTabModel>>> insertInternetTab(
      {required InternetTabEntity internetTab});

  Future<ResponseWrapper<List<InternetTabModel>>> deleteInternetTab(
      {required String tabId});

  Future<ResponseWrapper<List<InternetTabModel>>> clearInternetTab();
}