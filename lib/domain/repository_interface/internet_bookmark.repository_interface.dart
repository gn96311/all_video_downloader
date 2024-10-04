import 'package:all_video_downloader/data/common/response_wrapper.dart';
import 'package:all_video_downloader/data/entity/internet_bookmark.entity.dart';
import 'package:all_video_downloader/domain/model/internet_bookmark/internet_bookmark.model.dart';
import 'package:all_video_downloader/domain/model/internet_history/internet_history.model.dart';
import 'package:all_video_downloader/domain/repository_interface/repository_interface.dart';

abstract class InternetBookmarkRepositoryInterface extends Repository {
  Future<ResponseWrapper<List<InternetBookmarkModel>>> getInternetBookmarkList();

  Future<ResponseWrapper<List<InternetBookmarkModel>>> insertInternetBookmark(
      {required InternetBookmarkEntity internetBookmark});

  Future<ResponseWrapper<List<InternetBookmarkModel>>> deleteInternetBookmark(
      {required String bookmarkId});

  Future<ResponseWrapper<List<InternetBookmarkModel>>> clearInternetBookmark();
}