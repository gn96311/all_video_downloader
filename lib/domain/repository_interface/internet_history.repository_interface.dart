import 'package:all_video_downloader/data/common/response_wrapper.dart';
import 'package:all_video_downloader/data/entity/internet_history.entity.dart';
import 'package:all_video_downloader/data/entity/internet_tab.entity.dart';
import 'package:all_video_downloader/domain/model/internet_history/internet_history.model.dart';
import 'package:all_video_downloader/domain/model/internet_tab/internet_tab.model.dart';
import 'package:all_video_downloader/domain/repository_interface/repository_interface.dart';

abstract class InternetHistoryRepositoryInterface extends Repository {
  Future<ResponseWrapper<List<InternetHistoryModel>>> getInternetHistoryList();

  Future<ResponseWrapper<List<InternetHistoryModel>>> insertInternetHistory(
      {required InternetHistoryEntity internetHistory});

  Future<ResponseWrapper<List<InternetHistoryModel>>> deleteInternetHistory(
      {required String visitedTime});

  Future<ResponseWrapper<List<InternetHistoryModel>>> clearInternetHistory();
}