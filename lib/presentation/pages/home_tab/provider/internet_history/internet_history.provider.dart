import 'package:all_video_downloader/data/entity/internet_history.entity.dart';
import 'package:all_video_downloader/data/local_storage/internet_history.dao.dart';
import 'package:all_video_downloader/data/repository_impl/internet_history.repository_impl.dart';
import 'package:all_video_downloader/domain/model/internet_history/internet_history.model.dart';
import 'package:all_video_downloader/domain/repository_interface/internet_history.repository_interface.dart';
import 'package:all_video_downloader/domain/usecase/internet_tab/internet_history.usecase.dart';
import 'package:all_video_downloader/presentation/pages/home_tab/provider/internet_history/internet_history.state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const String _internetHistoryDB = 'INTERNET_HISTORY_DB';

class InternetHistoryNotifier extends StateNotifier<InternetHistoryState> {
  final InternetHistoryUsecase _internetHistoryUsecase;

  InternetHistoryNotifier(this._internetHistoryUsecase) : super(InternetHistoryState(historyList: []));

  Future<void> getInternetHistoryList() async {
    final result = await _internetHistoryUsecase.execute(usecase: GetInternetHistoryUsecase());
    result.when(success: (data) async {
      List<InternetHistoryModel> historyList = data;
      state = state.copyWith(historyList: historyList);
    }, failure: (error) {
      state = state.copyWith(error: error);
    });
  }

  Future<void> insertInternetHistory(InternetHistoryEntity internetHistoryEntity) async {
    final result = await _internetHistoryUsecase.execute(usecase: InsertInternetHistoryUsecase(internetHistoryEntity: internetHistoryEntity));
    result.when(success: (data) async {
      List<InternetHistoryModel> historyList = data;
      state = state.copyWith(historyList: historyList);
    }, failure: (error) {
      state = state.copyWith(error: error);
    });
  }

  Future<void> deleteInternetHistory(String visitedTime) async {
    final result = await _internetHistoryUsecase.execute(usecase: DeleteInternetHistoryUsecase(visitedTime: visitedTime));
    result.when(success: (data) async {
      List<InternetHistoryModel> historyList = data;
      state = state.copyWith(historyList: historyList);
    }, failure: (error) {
      state = state.copyWith(error: error);
    });
  }

  Future<void> clearInternetHistory() async {
    final result = await _internetHistoryUsecase.execute(usecase: ClearInternetHistoryUsecase());
    result.when(success: (data) async {
      List<InternetHistoryModel> historyList = data;
      state = state.copyWith(historyList: historyList);
    }, failure: (error) {
      state = state.copyWith(error: error);
    });
  }
}

final internetHistoryDaoProvider = Provider<InternetHistoryDao>((ref) {
  return InternetHistoryDao();
});

final internetHistoryRepositoryProvider = Provider<InternetHistoryRepositoryInterface>((ref){
  final dao = ref.watch(internetHistoryDaoProvider);
  return InternetHistoryRepositoryImpl(dao);
});

final internetHistoryUsecaseProvider = Provider<InternetHistoryUsecase>((ref) {
  final repository = ref.watch(internetHistoryRepositoryProvider);
  return InternetHistoryUsecase(repository);
});

final internetHistoryListProvider = StateNotifierProvider<InternetHistoryNotifier, InternetHistoryState>((ref) {
  final internetHistoryUsecase = ref.watch(internetHistoryUsecaseProvider);
  return InternetHistoryNotifier(internetHistoryUsecase);
});