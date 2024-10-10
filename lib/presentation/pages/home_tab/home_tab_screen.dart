import 'dart:convert';
import 'dart:io';

import 'package:all_video_downloader/core/theme/constant/app_colors.dart';
import 'package:all_video_downloader/core/theme/constant/app_icons.dart';
import 'package:all_video_downloader/core/theme/theme_data.dart';
import 'package:all_video_downloader/data/remote/video_download.dart';
import 'package:all_video_downloader/presentation/pages/progress_tab/provider/HLS_video_info/HLS_video_info.provider.dart';
import 'package:all_video_downloader/presentation/pages/progress_tab/provider/jwplayer_video_info/jwplayer_video_info.provider.dart';
import 'package:all_video_downloader/data/entity/internet_bookmark.entity.dart';
import 'package:all_video_downloader/data/entity/internet_tab.entity.dart';
import 'package:all_video_downloader/domain/model/internet_bookmark/internet_bookmark.model.dart';
import 'package:all_video_downloader/domain/model/internet_history/internet_history.model.dart';
import 'package:all_video_downloader/domain/model/internet_tab/internet_tab.model.dart';
import 'package:all_video_downloader/presentation/pages/home_tab/internet_bookmark_widget.dart';
import 'package:all_video_downloader/presentation/pages/home_tab/internet_history_widget.dart';
import 'package:all_video_downloader/presentation/pages/home_tab/internet_tab_widget.dart';
import 'package:all_video_downloader/presentation/pages/home_tab/new_tab_screen.dart';
import 'package:all_video_downloader/presentation/pages/home_tab/provider/internet_bookmark/internet_bookmark.provider.dart';
import 'package:all_video_downloader/presentation/pages/home_tab/provider/internet_bookmark/internet_bookmark.state.dart';
import 'package:all_video_downloader/presentation/pages/home_tab/provider/internet_history/internet_history.provider.dart';
import 'package:all_video_downloader/presentation/pages/home_tab/provider/internet_history/internet_history.state.dart';
import 'package:all_video_downloader/presentation/pages/home_tab/provider/internet_tab.provider.dart';
import 'package:all_video_downloader/presentation/pages/home_tab/webview_screen.dart';
import 'package:all_video_downloader/presentation/pages/progress_tab/provider/video_download_progress/video_download_progress.provider.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
  bool isPageLoaded = false;
  String? jwFileName = '';

  Widget? _endDrawerContent;

  @override
  void initState() {
    _urlFocusNode.addListener(_handleFocusChange);
    _urlTextController.addListener(_handleTextChange);
    ref.read(internetTabListProvider.notifier).getInternetTabList();
    ref.read(internetHistoryListProvider.notifier).getInternetHistoryList();
    ref.read(internetBookmarkListProvider.notifier).getInternetBookmarkList();
    super.initState();

    Future.microtask(() async {
      final prefs = await SharedPreferences.getInstance();
      final lastTabId = prefs.getString('lastTabId');
      final lastUrl = prefs.getString('lastUrl');
      if (lastTabId != null && lastTabId.isNotEmpty) {
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
    // Tab ID, URL 초기화
    final uuid = Uuid();
    final tabListState = ref.watch(internetTabListProvider);
    final currentTabId = ref.watch(internetTabListProvider.select((state) => state.currentTabId)) ?? ''; // tabId 변경 확인
    final currentUrl = currentTabId != null ? ref.read(internetTabListProvider.notifier).getCurrentUrl(currentTabId) : ''; // tabId가 변경되면, 자동으로 currentUrl도 변경.

    // Bookmark List, Id 초기화
    final currentBookmarkList = ref.watch(internetBookmarkListProvider); // bookmark List 불러오기
    bool isBookmarked = currentBookmarkList.bookmarkList.any((bookmark) => bookmark.url == currentUrl);
    String? bookmarkId;
    if (isBookmarked) {
      bookmarkId = currentBookmarkList.bookmarkList
          .firstWhere((bookmark) => bookmark.url == currentUrl)
          .bookmarkId;
    } else {
      bookmarkId = 'None';
    }

    // currentUrl의 상태가 바뀌면, _urlTextController.text를 next로 바꿈.
    // 사이트 접속 시, 해당 사이트의 url을 url창에 반영.
    ref.listen(internetTabListProvider.select((state) => state.currentUrl),
            (previous, next) {
          if (next != null && _urlTextController.text != next) {
            _urlTextController.text = next;
          }
        });

    ref.listen(internetHistoryListProvider, (previous, next) {
      setState(() {
        if (_scaffoldKey.currentState?.isEndDrawerOpen ?? false) {
          _endDrawerContent = _buildHistoryDrawer(next, currentTabId);
        }
      });
    });
    ref.listen(internetBookmarkListProvider, (previous, next) {
      setState(() {
        if (_scaffoldKey.currentState?.isEndDrawerOpen ?? false) {
          _endDrawerContent = _buildBookmarkDrawer(next, currentTabId);
        }
      });
    });

    List<String>? hlsUrls = ref.watch(HlsVideoInfoProvider).hlsUrls;
    List<String>? jwplayerUrls = ref.watch(JwPlayerVideoInfoProvider).inputUrls;

    bool isFabEnabled = (hlsUrls != null && hlsUrls.isNotEmpty) || (jwplayerUrls != null && jwplayerUrls.isNotEmpty);

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
                padding: const EdgeInsets.only(
                    left: 16, top: 16, bottom: 16, right: 8),
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
                                  Clipboard.setData(ClipboardData(
                                      text: _urlTextController.text));
                                } else {
                                  final clipboardData =
                                  await Clipboard.getData('text/plain');
                                  if (clipboardData != null &&
                                      clipboardData.text != null) {
                                    _urlTextController.text =
                                    clipboardData.text!;
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
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          bottom: 14)),
                                  onSubmitted: (url) {
                                    if (tabListState.tabList.isEmpty) {
                                      InternetTabEntity addTab = InternetTabEntity(
                                          url: url,
                                          faviconPath: AppIcons.newTabIcon,
                                          title: '새 탭',
                                          tabId: uuid.v4());
                                      ref
                                          .read(
                                          internetTabListProvider.notifier)
                                          .insertInternetTab(addTab);
                                      //_urlTextController.text = ''; should Delete
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
                                if (_hasUrlFocus) {
                                  _urlTextController.clear();
                                } else {
                                  if (isPageLoaded) {
                                    if (isBookmarked) {
                                      ref
                                          .read(internetBookmarkListProvider
                                          .notifier)
                                          .deleteInternetBookmark(bookmarkId!);
                                    } else {
                                      String newBookmarkId = uuid.v4();
                                      InternetTabModel nowTabInformation = ref
                                          .watch(internetTabListProvider)
                                          .tabList
                                          .firstWhere((internetTab) =>
                                      internetTab.tabId ==
                                          currentTabId);
                                      ref
                                          .read(internetBookmarkListProvider
                                          .notifier)
                                          .insertInternetBookmark(
                                          InternetBookmarkEntity(
                                              title:
                                              nowTabInformation.title,
                                              url: nowTabInformation.url,
                                              faviconPath: nowTabInformation
                                                  .faviconPath,
                                              isImportant: isBookmarked,
                                              bookmarkId: newBookmarkId));
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('페이지 로딩중...')));
                                  }
                                }
                              },
                              icon: getEnterIcon(isBookmarked),
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
                      onTap: () {
                        InternetTabEntity newTab = InternetTabEntity(
                            url: '',
                            faviconPath: AppIcons.newTabIcon,
                            title: '새 탭',
                            tabId: uuid.v4());
                        ref
                            .read(internetTabListProvider.notifier)
                            .insertInternetTab(newTab);
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
                              _endDrawerContent = _buildBookmarkDrawer(
                                  ref.watch(internetBookmarkListProvider),
                                  currentTabId);
                            });
                            _scaffoldKey.currentState?.openEndDrawer();
                            break;
                          case 'history':
                            setState(() {
                              _endDrawerContent = _buildHistoryDrawer(
                                  ref.watch(internetHistoryListProvider),
                                  currentTabId);
                            });
                            _scaffoldKey.currentState?.openEndDrawer();
                            break;
                          case 'settings':
                            GoRouter.of(context).goNamed('settings');
                            break;
                        }
                      },
                      itemBuilder: (BuildContext context) =>
                      [
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
                                ref
                                    .read(internetTabListProvider.notifier)
                                    .clearInternetTab();
                                _urlTextController.text = '';
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                          [
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
                  children: tabListState.tabList
                      .asMap()
                      .entries
                      .map((entry) {
                    InternetTabModel e = entry.value;
                    return InternetTabWidget(
                      key: ValueKey(e.tabId),
                        title: e.title,
                        url: e.url,
                        faviconPath: e.faviconPath,
                        tabId: e.tabId,
                    urlTextEditingController: _urlTextController,);
                  }).toList(),
                )
              ],
            ),
          ),
          endDrawer: Drawer(
            width: 300,
            child: _endDrawerContent ??
                const Center(
                  child: Text('아무런 기록이 없습니다.'),
                ),
          ),
          body: (tabListState.tabList.isEmpty)
              ? NewTabScreen(
            currentTabId: currentTabId,
          )
              : getWebviewScreen(currentUrl, currentTabId),
          floatingActionButton: FloatingActionButton(
            //TODO: 클릭 시, 위로 버튼이 올라오면서 다운로드, provider 초기화 등이 선택 가능하게 변경.
            onPressed: isFabEnabled ? _onFabPressed : null,
            child: Icon(
              Icons.download,
              size: 30,
            ),
            backgroundColor: isFabEnabled? AppColors.primary: AppColors.lessImportant,
          ),
        ),
      ),
    );
  }

  void _onFabPressed() async {
    String? title = ref
        .watch(HlsVideoInfoProvider)
        .title;
    List<String>? hlsUrls = ref
        .watch(HlsVideoInfoProvider)
        .hlsUrls;
    List<String>? jwplayerUrls = ref
        .watch(JwPlayerVideoInfoProvider)
        .inputUrls;
    Map<String, String> headers = ref
        .watch(JwPlayerVideoInfoProvider)
        .headers;

    await processGetStreamFunction(context, hlsUrls, jwplayerUrls, headers, title);
    //TODO: 다른 사이트의 영상도 다운로드 되는지 확인해야함.(유튜브, 인스타, 기타 다른 사이트 포함)
    //TODO: 영상 제목 잘 뜨는지 확인해야함.(제목별로 다른 이름으로 다운되게 해야함, 사이트별 아님.)
    //TODO: 영상의 용량과 converting 과정을 알고, progress에 반영해야함
    // TODO: 영상이 m3u8 형식이 아닌 경우를 구현해야함.
  }

  Future<Map<String, String?>> _showVideoSelectionDialog(
      List<Map<String, String>> streamOptions) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('다운로드 영상 선택'),
            content: Container(
              width: 200,
              height: 400,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final option = streamOptions[index];
                  if (option['type'] == 'video') {
                    // 비디오 옵션만 표시
                    return ListTile(
                        title: Text(
                            '${option['resolution']} @ ${option['size']}'),
                        onTap: () {
                          // 일치하는 오디오 스트림 찾기
                          final matchingAudio = streamOptions.firstWhere(
                                  (audioOption) =>
                              audioOption['type'] == 'audio',
                              orElse: () => <String, String>{}
                          );
                          Navigator.pop(context, {
                            'videoUrl': option['url'],
                            'audioUrl': matchingAudio.isNotEmpty
                                ? matchingAudio['url']
                                : null,
                          });
                        });
                  }
                  return Container();
                },
                itemCount: streamOptions.length,
                shrinkWrap: true,
              ),
            ),
          );
        }) ?? {};
  }

  Widget _buildBookmarkDrawer(InternetBookmarkState bookmarkState,
      String currentTabId) {
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
                        ref
                            .read(internetBookmarkListProvider.notifier)
                            .clearInternetBookmark();
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                  [
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
          children: bookmarkState.bookmarkList
              .asMap()
              .entries
              .map((entry) {
            int index = entry.key;
            InternetBookmarkModel e = entry.value;
            return InternetBookmarkWidget(
              title: e.title,
              url: e.url,
              faviconPath: e.faviconPath,
              bookmarkId: e.bookmarkId,
              tabId: currentTabId,
            );
          }).toList(),
        )
      ],
    );
  }

  Widget _buildHistoryDrawer(InternetHistoryState historyState,
      String currentTabId) {
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
                        ref
                            .read(internetHistoryListProvider.notifier)
                            .clearInternetHistory();
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                  [
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
          children: historyState.historyList
              .asMap()
              .entries
              .map((entry) {
            int index = entry.key;
            InternetHistoryModel e = entry.value;
            return InternetHistoryWidget(
              title: e.title,
              url: e.url,
              faviconPath: e.faviconPath,
              visitedTime: e.VisitedTime,
              currentTabId: currentTabId,
            );
          }).toList(),
        )
      ],
    );
  }

  Widget getWebviewScreen(url, currentTabId) {
    if (url == '') {
      return NewTabScreen(
        currentTabId: currentTabId,
      );
    } else {
      return WebviewScreen(
          inputUrl: url,
          currentTabId: currentTabId,
          onWebViewCreated: widget.onWebViewCreated,
          onPageLoad: (loaded) {
            setState(() {
              isPageLoaded = loaded;
            });
          });
    }
  }

  Widget getEnterIcon(bool isBookmarked) {
    if (!_hasUrlText) {
      return Icon(
        Icons.keyboard_return,
        color: AppColors.lessImportant,
      );
    } else {
      if (_hasUrlFocus) {
        return Transform.rotate(
          angle: math.pi / 4,
          child: Icon(
            Icons.add,
            color: AppColors.lessImportant,
          ),
        );
      } else {
        if (isBookmarked) {
          return Icon(
            Icons.star,
            color: AppColors.primary,
          );
        } else {
          return Icon(
            Icons.star_border_outlined,
            color: AppColors.lessImportant,
          );
        }
      }
    }
  }

  Future<void> processGetStreamFunction(BuildContext context, List<String>? hlsUrls, List<String>? otherFormatUrls, Map<String, String> headers, title) async {
    final strategies = {
      'hls': () => hlsGetStreamFunction(hlsUrls!, headers, title), //case 1
      'otherFormat': () => otherFormatGetStreamFunction(otherFormatUrls!, headers, title), // case 2
      'default': () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('동영상 URL을 찾을 수 없습니다.')))
    };

    if (hlsUrls != null && hlsUrls.isNotEmpty) {
      await strategies['hls']!(); //case 1
    } else if (otherFormatUrls != null && otherFormatUrls.isNotEmpty) {
      await strategies['otherFormat']!(); //case 2
    } else {
      await strategies['default']!();
    }
  }

  // case 1
  // master m3u8 존재, media playlist(video/audio) url로부터 직접 전체 영상 다운로드
  Future<void> hlsGetStreamFunction(List<String> hlsUrls, Map<String, String> headers, title) async {
    print('case1');
    Map<String, dynamic> responseMap = await fetchAndStoreM3U8Response(hlsUrls, headers);
    List<Map<String, String>> streamOptions = await getStreamOptions(responseMap, headers);
    final selectedUrls = await _showVideoSelectionDialog(streamOptions);
    if (selectedUrls.isEmpty){
      return;
    }
    await convertVideo(selectedUrls, title: title);
  }

  //case 2
  // media playlist를 html, js 등으로 바꾸어서 함.
  Future<void> otherFormatGetStreamFunction(List<String> otherFormatUrls, Map<String, String> headers, title) async {
    print('case2');
    List<String> m3u8Urls = otherFormatUrls.where((url) => url.endsWith('.html') || url.endsWith('index.js')).toList();
    if (m3u8Urls == null){
      m3u8Urls = otherFormatUrls.where((url) => url.endsWith('.js')).toList();
    }
    Map<String, dynamic> responseMap = await fetchAndStoreM3U8Response(m3u8Urls, headers);
    List<Map<String, String>> streamOptions = await getStreamOptions(responseMap, headers);
    final selectedUrls = await _showVideoSelectionDialog(streamOptions);
    if (selectedUrls.isEmpty){
      return;
    }
    final selectedData = responseMap[selectedUrls['videoUrl']];
    await processM3U8(selectedData, title, headers, ref);
  }
}
