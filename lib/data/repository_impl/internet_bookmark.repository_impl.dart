import 'package:all_video_downloader/data/common/response_wrapper.dart';
import 'package:all_video_downloader/data/entity/internet_bookmark.entity.dart';
import 'package:all_video_downloader/data/local_storage/internet_bookmark.dao.dart';
import 'package:all_video_downloader/domain/model/internet_bookmark/internet_bookmark.model.dart';
import 'package:all_video_downloader/domain/model/internet_history/internet_history.model.dart';
import 'package:all_video_downloader/domain/repository_interface/internet_bookmark.repository_interface.dart';

class InternetBookmarkRepositoryImpl
    implements InternetBookmarkRepositoryInterface {
  final InternetBookmarkDao _internetBookmarkDao;

  InternetBookmarkRepositoryImpl(this._internetBookmarkDao);

  @override
  Future<ResponseWrapper<List<InternetBookmarkModel>>>
      clearInternetBookmark() async {
    final response = await _internetBookmarkDao.clearInternetBookmark();
    return response.toModel<List<InternetBookmarkModel>>(
        response.data?.map((entityData) => entityData.toModel()).toList() ??
            []);
  }

  @override
  Future<ResponseWrapper<List<InternetBookmarkModel>>> deleteInternetBookmark(
      {required String bookmarkId}) async {
    final response =
        await _internetBookmarkDao.deleteInternetBookmark(bookmarkId);
    return response.toModel<List<InternetBookmarkModel>>(
        response.data?.map((entityData) => entityData.toModel()).toList() ??
            []);
  }

  @override
  Future<ResponseWrapper<List<InternetBookmarkModel>>>
      getInternetBookmarkList() async {
    final response = await _internetBookmarkDao.getInternetBookmarkList();
    return response.toModel<List<InternetBookmarkModel>>(
        response.data?.map((entityData) => entityData.toModel()).toList() ??
            []);
  }

  @override
  Future<ResponseWrapper<List<InternetBookmarkModel>>> insertInternetBookmark(
      {required InternetBookmarkEntity internetBookmark}) async {
    final response =
        await _internetBookmarkDao.insertInternetBookmark(internetBookmark);
    return response.toModel<List<InternetBookmarkModel>>(
        response.data?.map((entityData) => entityData.toModel()).toList() ??
            []);
  }
}
