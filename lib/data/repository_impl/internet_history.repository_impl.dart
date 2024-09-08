import 'package:all_video_downloader/data/common/response_wrapper.dart';
import 'package:all_video_downloader/data/entity/internet_history.entity.dart';
import 'package:all_video_downloader/data/entity/internet_tab.entity.dart';
import 'package:all_video_downloader/data/local_storage/internet_history.dao.dart';
import 'package:all_video_downloader/data/local_storage/internet_tab.dao.dart';
import 'package:all_video_downloader/domain/model/internet_history/internet_history.model.dart';
import 'package:all_video_downloader/domain/model/internet_tab/internet_tab.model.dart';
import 'package:all_video_downloader/domain/repository_interface/internet_history.repository_interface.dart';
import 'package:all_video_downloader/domain/repository_interface/internet_tab.repository_interface.dart';

class InternetHistoryRepositoryImpl implements InternetHistoryRepositoryInterface{
  final InternetHistoryDao _internetHistoryDao;

  InternetHistoryRepositoryImpl(this._internetHistoryDao);

  @override
  Future<ResponseWrapper<List<InternetHistoryModel>>> clearInternetHistory() async {
    final response = await _internetHistoryDao.clearInternetHistory();
    return response.toModel<List<InternetHistoryModel>>(response.data?.map((entityData) => entityData.toModel()).toList() ?? []);
  }

  @override
  Future<ResponseWrapper<List<InternetHistoryModel>>> deleteInternetHistory({required String visitedTime}) async {
    final response = await _internetHistoryDao.deleteInternetHistory(visitedTime);
    return response.toModel<List<InternetHistoryModel>>(response.data?.map((entityData) => entityData.toModel()).toList() ?? []);
  }

  @override
  Future<ResponseWrapper<List<InternetHistoryModel>>> getInternetHistoryList() async {
    final response = await _internetHistoryDao.getInternetHistoryList();
    return response.toModel<List<InternetHistoryModel>>(response.data?.map((entityData) => entityData.toModel()).toList() ?? []);
  }

  @override
  Future<ResponseWrapper<List<InternetHistoryModel>>> insertInternetHistory({required InternetHistoryEntity internetHistory}) async {
    final response = await _internetHistoryDao.insertInternetHistory(internetHistory);
    return response.toModel<List<InternetHistoryModel>>(response.data?.map((entityData) => entityData.toModel()).toList() ?? []);
  }
}