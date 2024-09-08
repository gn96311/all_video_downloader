import 'package:all_video_downloader/data/common/response_wrapper.dart';
import 'package:all_video_downloader/data/entity/internet_tab.entity.dart';
import 'package:all_video_downloader/data/local_storage/internet_tab.dao.dart';
import 'package:all_video_downloader/domain/model/internet_tab/internet_tab.model.dart';
import 'package:all_video_downloader/domain/repository_interface/internet_tab.repository_interface.dart';

class InternetTabRepositoryImpl implements InternetTabInterfaceRepository{
  final InternetTabDao _internetTabDao;

  InternetTabRepositoryImpl(this._internetTabDao);


  @override
  Future<ResponseWrapper<List<InternetTabModel>>> getInternetTabList() async {
    final response = await _internetTabDao.getInternetTabList();
    return response.toModel<List<InternetTabModel>>(response.data?.map((entityData) => entityData.toModel()).toList() ?? []);
  }

  @override
  Future<ResponseWrapper<List<InternetTabModel>>> insertInternetTab({required InternetTabEntity internetTab}) async {
    final response = await _internetTabDao.insertInternetTab(internetTab);
    return response.toModel<List<InternetTabModel>>(response.data?.map((entityData) => entityData.toModel()).toList() ?? []);
  }

  @override
  Future<ResponseWrapper<List<InternetTabModel>>> deleteInternetTab({required String tabId}) async {
    final response = await _internetTabDao.deleteInternetTab(tabId);
    return response.toModel<List<InternetTabModel>>(response.data?.map((entityData) => entityData.toModel()).toList() ?? []);
  }

  @override
  Future<ResponseWrapper<List<InternetTabModel>>> clearInternetTab() async {
    final response = await _internetTabDao.clearInternetTab();
    return response.toModel<List<InternetTabModel>>(response.data?.map((entityData) => entityData.toModel()).toList() ?? []);
  }
}