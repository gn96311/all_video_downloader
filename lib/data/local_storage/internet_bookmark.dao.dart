import 'package:all_video_downloader/data/common/response_wrapper.dart';
import 'package:all_video_downloader/data/entity/internet_bookmark.entity.dart';
import 'package:hive/hive.dart';

const String _internetBookmarkDB = 'INTERNET_BOOKMARK_DB';

class InternetBookmarkDao {
  Future<ResponseWrapper<List<InternetBookmarkEntity>>> getInternetBookmarkList() async {
    final localStorage = await Hive.openBox<InternetBookmarkEntity>(_internetBookmarkDB);
    return ResponseWrapper(
        status: 'SUCCESS',
        code: '200',
        message: 'Complete get Internet Bookmark List',
        data: localStorage.values.toList()
    );
  }

  Future<ResponseWrapper<List<InternetBookmarkEntity>>> insertInternetBookmark(InternetBookmarkEntity internetBookmarkEntity) async {
    final localStorage = await Hive.openBox<InternetBookmarkEntity>(_internetBookmarkDB);
    await localStorage.add(internetBookmarkEntity);
    return ResponseWrapper(
        status: 'SUCCESS',
        code: '200',
        message: 'Complete add Internet Bookmark List',
        data: localStorage.values.toList()
    );
  }

  Future<ResponseWrapper<List<InternetBookmarkEntity>>> deleteInternetBookmark(String bookmarkId) async {
    final localStorage = await Hive.openBox<InternetBookmarkEntity>(_internetBookmarkDB);
    int? keyToDelete = localStorage.keys.firstWhere((key) => localStorage.get(key)?.bookmarkId == bookmarkId, orElse: () => null);
    await localStorage.delete(keyToDelete);
    return ResponseWrapper(
        status: 'SUCCESS',
        code: '200',
        message: 'Complete delete Internet Bookmark List',
        data: localStorage.values.toList()
    );
  }

  Future<ResponseWrapper<List<InternetBookmarkEntity>>> clearInternetBookmark() async {
    final localStorage = await Hive.openBox<InternetBookmarkEntity>(_internetBookmarkDB);
    await localStorage.clear();
    return ResponseWrapper(
      status: 'SUCCESS',
      code: '200',
      message: 'Completely clear internet Bookmark',
      data: [],
    );
  }
}