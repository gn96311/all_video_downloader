import 'dart:math';

import 'package:all_video_downloader/data/entity/internet_tab.entity.dart';
import 'package:all_video_downloader/data/local_storage/internet_tab.dao.dart';
import 'package:all_video_downloader/data/repository_impl/internet_tab.repository_impl.dart';
import 'package:all_video_downloader/domain/model/internet_tab/internet_tab.model.dart';
import 'package:all_video_downloader/domain/repository_interface/internet_tab.repository_interface.dart';
import 'package:all_video_downloader/domain/usecase/internet_tab/internet_tab.usecase.dart';
import 'package:all_video_downloader/presentation/pages/home_tab/provider/internet_tab.state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _internetTabDB = 'INTERNET_TAB_DB';

class InternetTabNotifier extends StateNotifier<InternetTabState> {
  final InternetTabUsecase _internetTabUsecase;

  InternetTabNotifier(this._internetTabUsecase) : super(InternetTabState(tabList: [InternetTabModel.newTab()]));

  void setCurrentTabId(String tabId){
    state = state.copyWith(currentTabId: tabId);
  }

  String getCurrentUrl(String tabId){
    var tab = state.tabList.firstWhere((tab) => tab.tabId == tabId, orElse: () => InternetTabModel(tabId: '', url: '', faviconPath: '', title: 'Null'));
    return tab.url;
  }

  // newUrl을 받아서, 해당 tabId의 url을 변경하는 함수.
  Future<void> changeCurrentUrl(String tabId, String newUrl) async {
    int tabIndex = state.tabList.indexWhere((tab) => tab.tabId == tabId);
    if (tabIndex != -1){
      var updatedTabs = List<InternetTabModel>.from(state.tabList);
      var updatedTab = updatedTabs[tabIndex].copyWith(url: newUrl);
      updatedTabs[tabIndex] = updatedTab;
      state = state.copyWith(tabList: updatedTabs, currentUrl: newUrl);

      final localStorage = await Hive.openBox<InternetTabEntity>(_internetTabDB);
      final tabKey = localStorage.keys.firstWhere(
              (key) => localStorage.get(key)!.tabId == tabId,
          orElse: () => null
      );
      if (tabKey != null) {
        var tab = localStorage.get(tabKey);
        if (tab != null) {
          tab.url = newUrl;
          await tab.save();
        }
      }
    }
  }

  // 파비콘 및 타이틀 가져오는 함수, drawer에 사용
  Future<void> setPageDetails(String tabId, String title, String faviconPath) async {
    int tabIndex = state.tabList.indexWhere((tab) => tab.tabId == tabId);
    if (tabIndex != -1){
      var updatedTabs = List<InternetTabModel>.from(state.tabList);
      var updatedTab = updatedTabs[tabIndex].copyWith(title: title, faviconPath: faviconPath);
      updatedTabs[tabIndex] = updatedTab;
      state = state.copyWith(tabList: updatedTabs);

      final localStorage = await Hive.openBox<InternetTabEntity>(_internetTabDB);
      final tabKey = localStorage.keys.firstWhere(
              (key) => localStorage.get(key)!.tabId == tabId,
          orElse: () => null
      );
      if (tabKey != null) {
        var tab = localStorage.get(tabKey);
        if (tab != null) {
          tab.title = title;
          tab.faviconPath = faviconPath;
          await tab.save();
        }
      }
    }
  }


  // 마지막 방문 url 및 사용 tabId 저장 함수
  Future<void> saveLastTabInfo(String tabId, String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastTabId', tabId);
    await prefs.setString('lastUrl', url);
  }

  Future<void> getInternetTabList() async {
    final result = await _internetTabUsecase.execute(usecase: GetInternetTabListUsecase());
    result.when(success: (data) async {
      List<InternetTabModel> tabList = data;
      state = state.copyWith(tabList: tabList);
    }, failure: (error) {
      state = state.copyWith(error: error);
    });
  }

  Future<void> insertInternetTab(InternetTabEntity internetTab) async {
    final result = await _internetTabUsecase.execute(usecase: InsertInternetTabUsecase(internetTabEntity: internetTab));
    result.when(success: (data) async {
      List<InternetTabModel> tabList = data;
      state = state.copyWith(tabList: tabList);
      state = state.copyWith(currentTabId: internetTab.tabId);
    }, failure: (error) {
      state = state.copyWith(error: error);
    });
  }

  Future<void> deleteInternetTab(String tabId) async {
    final isCurrentTab = state.currentTabId == tabId;
    final result = await _internetTabUsecase.execute(usecase: DeleteInternetUsecase(tabId: tabId));
    result.when(success: (data) async {
      List<InternetTabModel> tabList = data;
      state = state.copyWith(tabList: tabList);
    }, failure: (error) {
      state = state.copyWith(error: error);
    });
    if (isCurrentTab) {
      if (state.tabList.isNotEmpty) {
        setCurrentTabId(state.tabList.last.tabId);
      } else {
        state = state.copyWith(currentTabId: null, currentUrl: null);
      }
    }
  }

  Future<void> clearInternetTab() async {
    final result = await _internetTabUsecase.execute(usecase: ClearInternetTabUsecase());
    result.when(success: (data) async {
      List<InternetTabModel> tabList = data;
      state = state.copyWith(tabList: tabList);
    }, failure: (error) {
      state = state.copyWith(error: error);
    });
  }
}

final internetTabDaoProvider = Provider<InternetTabDao>((ref){
  return InternetTabDao();
});

final internetTabRepositodyProvider = Provider<InternetTabInterfaceRepository>((ref){
  final dao = ref.watch(internetTabDaoProvider);
  return InternetTabRepositoryImpl(dao);
});

final internetTabUsecaseProvider = Provider<InternetTabUsecase>((ref) {
  final repository = ref.watch(internetTabRepositodyProvider);
  return InternetTabUsecase(repository);
});

final internetTabListProvider = StateNotifierProvider<InternetTabNotifier, InternetTabState>((ref) {
  final internetTabUsecase = ref.watch(internetTabUsecaseProvider);
  return InternetTabNotifier(internetTabUsecase);
});