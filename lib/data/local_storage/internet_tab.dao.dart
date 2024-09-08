import 'package:all_video_downloader/data/common/response_wrapper.dart';
import 'package:all_video_downloader/data/entity/internet_tab.entity.dart';
import 'package:hive/hive.dart';

const String _internetTabDB = 'INTERNET_TAB_DB';

class InternetTabDao{
  Future<ResponseWrapper<List<InternetTabEntity>>> getInternetTabList() async{
    final localStorage = await Hive.openBox<InternetTabEntity>(_internetTabDB);
    return ResponseWrapper(
      status: 'SUCCESS',
      code: '200',
      message: 'Complete get Internet Tab List',
      data: localStorage.values.toList(),
    );
  }

  Future<ResponseWrapper<List<InternetTabEntity>>> insertInternetTab(InternetTabEntity internetTab) async {
    final localStorage = await Hive.openBox<InternetTabEntity>(_internetTabDB);
    await localStorage.add(internetTab);
    return ResponseWrapper(
      status: 'SUCCESS',
      code: '200',
      message: 'Completely add internetTab',
      data: localStorage.values.toList(),
    );
  }

  Future<ResponseWrapper<List<InternetTabEntity>>> deleteInternetTab(String tabId) async {
    final localStorage = await Hive.openBox<InternetTabEntity>(_internetTabDB);
    int? keyToDelete = localStorage.keys.firstWhere(
        (key) => localStorage.get(key)?.tabId == tabId, orElse: () => null
    );
    await localStorage.delete(keyToDelete);
    return ResponseWrapper(
      status: 'SUCCESS',
      code: '200',
      message: 'Completely delete internetTab',
      data: localStorage.values.toList(),
    );
  }

  Future<ResponseWrapper<List<InternetTabEntity>>> clearInternetTab() async {
    final localStorage = await Hive.openBox<InternetTabEntity>(_internetTabDB);
    await localStorage.clear();
    return ResponseWrapper(
      status: 'SUCCESS',
      code: '200',
      message: 'Completely clear internetTab',
      data: [],
    );
  }
}