import 'package:all_video_downloader/data/common/response_wrapper.dart';
import 'package:all_video_downloader/data/entity/internet_history.entity.dart';
import 'package:all_video_downloader/data/entity/internet_tab.entity.dart';
import 'package:hive/hive.dart';

const String _internetHistoryDB = 'INTERNET_HISTORY_DB';

class InternetHistoryDao {
  Future<ResponseWrapper<List<InternetHistoryEntity>>> getInternetHistoryList() async {
    final localStorage = await Hive.openBox<InternetHistoryEntity>(_internetHistoryDB);
    return ResponseWrapper(
      status: 'SUCCESS',
      code: '200',
      message: 'Complete get Internet History List',
      data: localStorage.values.toList()
    );
  }

  Future<ResponseWrapper<List<InternetHistoryEntity>>> insertInternetHistory(InternetHistoryEntity internetHistory) async {
    final localStorage = await Hive.openBox<InternetHistoryEntity>(_internetHistoryDB);
    await localStorage.add(internetHistory);
    return ResponseWrapper(
        status: 'SUCCESS',
        code: '200',
        message: 'Complete add Internet History List',
        data: localStorage.values.toList()
    );
  }

  Future<ResponseWrapper<List<InternetHistoryEntity>>> deleteInternetHistory(String visitedTime) async {
    final localStorage = await Hive.openBox<InternetHistoryEntity>(_internetHistoryDB);
    int? keyToDelete = localStorage.keys.firstWhere((key) => localStorage.get(key)?.VisitedTime == visitedTime, orElse: () => null);
    await localStorage.delete(keyToDelete);
    return ResponseWrapper(
        status: 'SUCCESS',
        code: '200',
        message: 'Complete delete Internet History List',
        data: localStorage.values.toList()
    );
  }

  Future<ResponseWrapper<List<InternetHistoryEntity>>> clearInternetHistory() async {
    final localStorage = await Hive.openBox<InternetHistoryEntity>(_internetHistoryDB);
    await localStorage.clear();
    return ResponseWrapper(
      status: 'SUCCESS',
      code: '200',
      message: 'Completely clear internetHistory',
      data: [],
    );
  }
}