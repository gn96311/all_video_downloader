import 'package:all_video_downloader/data/entity/internet_bookmark.entity.dart';
import 'package:all_video_downloader/data/local_storage/internet_bookmark.dao.dart';
import 'package:all_video_downloader/data/repository_impl/internet_bookmark.repository_impl.dart';
import 'package:all_video_downloader/domain/model/internet_bookmark/internet_bookmark.model.dart';
import 'package:all_video_downloader/domain/repository_interface/internet_bookmark.repository_interface.dart';
import 'package:all_video_downloader/domain/usecase/internet_tab/internet_bookmark.usecase.dart';
import 'package:all_video_downloader/presentation/pages/home_tab/provider/internet_bookmark/internet_bookmark.state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const String _internetBookmarkDB = 'INTERNET_BOOKMARK_DB';

class InternetBookmarkNotifier extends StateNotifier<InternetBookmarkState> {
  final InternetBookmarkUsecase _internetBookmarkUsecase;

  InternetBookmarkNotifier(this._internetBookmarkUsecase)
      : super(InternetBookmarkState(bookmarkList: []));

  Future<void> getInternetBookmarkList() async {
    final result = await _internetBookmarkUsecase.execute(
        usecase: GetInternetBookmarkUsecase());
    result.when(success: (data) async {
      List<InternetBookmarkModel> bookmarkList = data;
      state = state.copyWith(bookmarkList: bookmarkList);
    }, failure: (error) {
      state = state.copyWith(error: error);
    });
  }

  Future<void> insertInternetBookmark(InternetBookmarkEntity internetBookmarkEntity) async {
    final result = await _internetBookmarkUsecase.execute(
        usecase: InsertInternetBookmarkUsecase(internetBookmarkEntity: internetBookmarkEntity));
    result.when(success: (data) async {
      List<InternetBookmarkModel> bookmarkList = data;
      state = state.copyWith(bookmarkList: bookmarkList);
    }, failure: (error) {
      state = state.copyWith(error: error);
    });
  }

  Future<void> deleteInternetBookmark(String bookmarkId) async {
    final result = await _internetBookmarkUsecase.execute(
        usecase: DeleteInternetBookmarkUsecase(bookmarkId: bookmarkId));
    result.when(success: (data) async {
      List<InternetBookmarkModel> bookmarkList = data;
      state = state.copyWith(bookmarkList: bookmarkList);
    }, failure: (error) {
      state = state.copyWith(error: error);
    });
  }

  Future<void> clearInternetBookmark() async {
    final result = await _internetBookmarkUsecase.execute(
        usecase: ClearInternetBookmarkUsecase());
    result.when(success: (data) async {
      List<InternetBookmarkModel> bookmarkList = data;
      state = state.copyWith(bookmarkList: bookmarkList);
    }, failure: (error) {
      state = state.copyWith(error: error);
    });
  }
}


final internetBookmarkDaoProvider = Provider<InternetBookmarkDao>((ref){
  return InternetBookmarkDao();
});

final internetBookmarkRepositoryProvider = Provider<InternetBookmarkRepositoryInterface>((ref) {
  final dao = ref.watch(internetBookmarkDaoProvider);
  return InternetBookmarkRepositoryImpl(dao);
});

final internetBookmarkUsecaseProvider = Provider<InternetBookmarkUsecase>((ref) {
  final repository = ref.watch(internetBookmarkRepositoryProvider);
  return InternetBookmarkUsecase(repository);
});

final internetBookmarkListProvider = StateNotifierProvider<InternetBookmarkNotifier, InternetBookmarkState>((ref) {
  final internetBookmarkUsecase = ref.watch(internetBookmarkUsecaseProvider);
  return InternetBookmarkNotifier(internetBookmarkUsecase);
});