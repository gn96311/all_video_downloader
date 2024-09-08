import 'package:all_video_downloader/core/theme/constant/app_colors.dart';
import 'package:all_video_downloader/core/theme/constant/app_icons.dart';
import 'package:all_video_downloader/core/theme/theme_data.dart';
import 'package:all_video_downloader/data/entity/internet_tab.entity.dart';
import 'package:all_video_downloader/domain/model/internet_history/internet_history.model.dart';
import 'package:all_video_downloader/domain/model/internet_tab/internet_tab.model.dart';
import 'package:all_video_downloader/presentation/pages/home_tab/internet_history_widget.dart';
import 'package:all_video_downloader/presentation/pages/home_tab/internet_tab_widget.dart';
import 'package:all_video_downloader/presentation/pages/home_tab/new_tab_screen.dart';
import 'package:all_video_downloader/presentation/pages/home_tab/provider/internet_history/internet_history.provider.dart';
import 'package:all_video_downloader/presentation/pages/home_tab/provider/internet_history/internet_history.state.dart';
import 'package:all_video_downloader/presentation/pages/home_tab/provider/internet_tab.provider.dart';
import 'package:all_video_downloader/presentation/pages/home_tab/webview_screen.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class HomeTabScreen extends ConsumerStatefulWidget {
  final void Function(InAppWebViewController controller) onWebViewCreated;
  const HomeTabScreen({super.key, required this.onWebViewCreated});

  @override
  ConsumerState<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends ConsumerState<HomeTabScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _urlTextController = TextEditingController();
  final FocusNode _urlFocusNode = FocusNode();
  InAppWebViewController? webViewController;

  bool _hasUrlFocus = false;
  bool _hasUrlText = false;

  Widget? _endDrawerContent;

  @override
  void initState() {
    _urlFocusNode.addListener(_handleFocusChange);
    _urlTextController.addListener(_handleTextChange);
    ref.read(internetTabListProvider.notifier).getInternetTabList();
    ref.read(internetHistoryListProvider.notifier).getInternetHistoryList();
    super.initState();

    Future.microtask(() async {
      final prefs = await SharedPreferences.getInstance();
      final lastTabId = prefs.getString('lastTabId');
      final lastUrl = prefs.getString('lastUrl');
      if (lastTabId != null && lastTabId.isNotEmpty){
        ref.read(internetTabListProvider.notifier).setCurrentTabId(lastTabId);
        _urlTextController.text = lastUrl!;
      }
    });
  }

  //TODO: 기타 여러가지 디테일 구성해야함.

  void _handleFocusChange() {
    setState(() {
      _hasUrlFocus = _urlFocusNode.hasFocus;
    });
  }

  void _handleTextChange() {
    setState(() {
      _hasUrlText = _urlTextController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _urlTextController.dispose();
    _urlFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uuid = Uuid();
    final historyListState = ref.watch(internetHistoryListProvider);
    final tabListState = ref.watch(internetTabListProvider);
    final currentTabId = ref.watch(internetTabListProvider.select((state) => state.currentTabId)) ?? ''; // tabId 변경 확인
    final currentUrl = currentTabId != null ? ref.read(internetTabListProvider.notifier).getCurrentUrl(currentTabId) : ''; // tabId가 변경되면, 자동으로 currentUrl도 변경.
    ref.listen(internetTabListProvider.select((state) => state.currentUrl), (previous, next) {
      if (next != null && _urlTextController.text != next) {
        _urlTextController.text = next;
      }
    });

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(65),
            child: Container(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 8),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        alignment: Alignment.center,
                        child: Text('${tabListState.tabList.length}'),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(1, 1),
                                color: AppColors.shadowColor.withOpacity(0.2),
                                blurRadius: 2,
                                spreadRadius: 2)
                          ],
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Container(
                        height: 35,
                        child: Row(
                          children: [
                            IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () async {
                                if (_hasUrlText) {
                                  Clipboard.setData(ClipboardData(text: _urlTextController.text));
                                } else{
                                  final clipboardData = await Clipboard.getData('text/plain');
                                  if (clipboardData != null && clipboardData.text != null) {
                                    _urlTextController.text = clipboardData.text!;
                                    _urlFocusNode.requestFocus();
                                  }
                                }
                              },
                              icon: Icon(
                                _hasUrlText ? Icons.copy : Icons.paste,
                                color: AppColors.lessImportant,
                                size: 20,
                              ),
                            ),
                            Expanded(
                                child: TextField(
                                  style: CustomThemeData
                                      .themeData.textTheme.titleSmall,
                                  controller: _urlTextController,
                                  focusNode: _urlFocusNode,
                                  keyboardType: TextInputType.url,
                                  textInputAction: TextInputAction.go,
                                  maxLines: 1,
                                  decoration:
                                      InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.only(bottom: 14)),
                                  onSubmitted: (url) {
                                    if (tabListState.tabList.isEmpty){
                                      InternetTabEntity addTab = InternetTabEntity(url: url, faviconPath: AppIcons.newTabIcon, title: '새 탭', tabId: uuid.v4());
                                      ref.read(internetTabListProvider.notifier).insertInternetTab(addTab);
                                      _urlTextController.text = '';
                                    } else {
                                      ref.read(internetTabListProvider.notifier).changeCurrentUrl(currentTabId, url);
                                    }
                                  },
                                )),
                            SizedBox(
                              width: 4,
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                _urlTextController.clear();
                              },
                              icon: getEnterIcon(),
                              iconSize: 24,
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(1, 1),
                                color: AppColors.shadowColor.withOpacity(0.2),
                                blurRadius: 2,
                                spreadRadius: 2)
                          ],
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                      onTap: (){
                        InternetTabEntity newTab = InternetTabEntity(url: '', faviconPath: AppIcons.newTabIcon, title: '새 탭', tabId: uuid.v4());
                        ref.read(internetTabListProvider.notifier).insertInternetTab(newTab);
                        _urlTextController.text = '';
                      },
                      child: Icon(
                        Icons.add,
                        size: 30,
                        color: AppColors.primary,
                      ),
                    ),
                    PopupMenuButton(
                      onSelected: (result) {
                        switch (result) {
                          case 'bookmark':
                            setState(() {
                              _endDrawerContent = _buildBookmarkDrawer(historyListState);
                            });
                            _scaffoldKey.currentState?.openEndDrawer();
                          case 'history':
                            setState(() {
                              _endDrawerContent = _buildHistoryDrawer(historyListState);
                            });
                            _scaffoldKey.currentState?.openEndDrawer();
                          case 'settings':
                            debugPrint('settings');
                        }
                      },
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem(
                          child: Row(
                            children: [
                              Icon(
                                Icons.bookmark_outline,
                                size: 20,
                                color: AppColors.lessImportant,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '북마크',
                                style: CustomThemeData
                                    .themeData.textTheme.titleSmall,
                              )
                            ],
                          ),
                          value: 'bookmark',
                        ),
                        PopupMenuItem(
                          child: Row(
                            children: [
                              Icon(
                                Icons.history,
                                size: 20,
                                color: AppColors.lessImportant,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '방문기록',
                                style: CustomThemeData
                                    .themeData.textTheme.titleSmall,
                              )
                            ],
                          ),
                          value: 'history',
                        ),
                        PopupMenuItem(
                          child: Row(
                            children: [
                              Icon(
                                Icons.settings,
                                size: 20,
                                color: AppColors.lessImportant,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '환경설정',
                                style: CustomThemeData
                                    .themeData.textTheme.titleSmall,
                              )
                            ],
                          ),
                          value: 'settings',
                        ),
                      ],
                      icon: Icon(
                        Icons.more_vert,
                        size: 30,
                        color: AppColors.primary,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowColor.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
          drawer: Drawer(
            width: 300,
            child: ListView(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Text(
                          '열어둔 탭',
                          style: CustomThemeData.themeData.textTheme.titleLarge,
                        ),
                        Expanded(child: SizedBox()),
                        PopupMenuButton(
                          onSelected: (result) {
                            switch (result) {
                              case 'CloseAll':
                                ref.read(internetTabListProvider.notifier).clearInternetTab();
                            }
                          },
                          itemBuilder: (BuildContext context) => [
                            PopupMenuItem(
                              child: Text('Close All'),
                              value: 'CloseAll',
                            )
                          ],
                          icon: Icon(Icons.more_vert),
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ),
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(1, 1),
                          color: AppColors.shadowColor.withOpacity(0.2),
                          blurRadius: 2,
                          spreadRadius: 2)
                    ],
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                Column(
                  children: tabListState.tabList.asMap().entries.map((entry) {
                    int index = entry.key;
                    InternetTabModel e = entry.value;
                    return InternetTabWidget(title: e.title, url: e.url, faviconPath: e.faviconPath, tabId: e.tabId);
                  }).toList(),
                )
              ],
            ),
          ),
          endDrawer: Drawer(
            width: 300,
            child: _endDrawerContent ?? const Center(child: Text('아무런 기록이 없습니다.'),),
          ),
          body: (tabListState.tabList.isEmpty) ? NewTabScreen() : getWebviewScreen(currentUrl, currentTabId),
        ),
      ),
    );
  }

  Widget _buildBookmarkDrawer(InternetHistoryState historyState) {
    return ListView(
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  '북마크',
                  style: CustomThemeData.themeData.textTheme.titleLarge,
                ),
                Expanded(child: SizedBox()),
                PopupMenuButton(
                  onSelected: (result) {
                    switch (result) {
                      case 'DeleteAll':
                        //ref.read(internetTabListProvider.notifier).clearInternetTab();
                    }
                  },
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                      child: Text('전체 삭제'),
                      value: 'DeleteAll',
                    )
                  ],
                  icon: Icon(Icons.more_vert),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                  offset: Offset(1, 1),
                  color: AppColors.shadowColor.withOpacity(0.2),
                  blurRadius: 2,
                  spreadRadius: 2)
            ],
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        // Column(
        //   children: tabListState.tabList.asMap().entries.map((entry) {
        //     int index = entry.key;
        //     InternetTabModel e = entry.value;
        //     return InternetTabWidget(title: e.title, url: e.url, faviconPath: e.faviconPath, tabId: e.tabId);
        //   }).toList(),
        // )
      ],
    );
  }

  Widget _buildHistoryDrawer(InternetHistoryState historyState) {
    return ListView(
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  'History',
                  style: CustomThemeData.themeData.textTheme.titleLarge,
                ),
                Expanded(child: SizedBox()),
                PopupMenuButton(
                  onSelected: (result) {
                    switch (result) {
                      case 'DeleteAll':
                      ref.read(internetHistoryListProvider.notifier).clearInternetHistory();
                    }
                  },
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                      child: Text('전체 삭제'),
                      value: 'DeleteAll',
                    )
                  ],
                  icon: Icon(Icons.more_vert),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                  offset: Offset(1, 1),
                  color: AppColors.shadowColor.withOpacity(0.2),
                  blurRadius: 2,
                  spreadRadius: 2)
            ],
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        Column(
          children: historyState.historyList.asMap().entries.map((entry) {
            int index = entry.key;
            InternetHistoryModel e = entry.value;
            return InternetHistoryWidget(title: e.title, url: e.url, faviconPath: e.faviconPath, visitedTime: e.VisitedTime);
          }).toList(),
        )
      ],
    );
  }

  Widget getWebviewScreen(url, currentTabId) {
    if (url == '') {
      return NewTabScreen();
    } else{
      return WebviewScreen(inputUrl: url, currentTabId: currentTabId, onWebViewCreated: widget.onWebViewCreated);
    }
  }

  Widget getEnterIcon() {
    if (!_hasUrlText) {
      return Icon(
        Icons.keyboard_return,
        color: AppColors.lessImportant,
      );
    } else {
      return Transform.rotate(
        angle: math.pi / 4,
        child: Icon(
          Icons.add,
          color: AppColors.lessImportant,
        ),
      );
    }
  }
}
