import 'dart:io';

import 'package:all_video_downloader/core/theme/constant/app_icons.dart';
import 'package:all_video_downloader/core/theme/constant/app_scripts.dart';
import 'package:all_video_downloader/data/entity/internet_history.entity.dart';
import 'package:all_video_downloader/data/entity/internet_tab.entity.dart';
import 'package:all_video_downloader/presentation/pages/home_tab/provider/internet_history/internet_history.provider.dart';
import 'package:all_video_downloader/presentation/pages/home_tab/provider/internet_tab.provider.dart';
import 'package:all_video_downloader/presentation/pages/home_tab/provider/webview_controller.provider.dart';
import 'package:all_video_downloader/presentation/pages/progress_tab/provider/HLS_video_info/HLS_video_info.dart';
import 'package:all_video_downloader/presentation/pages/progress_tab/provider/HLS_video_info/HLS_video_info.provider.dart';
import 'package:all_video_downloader/presentation/pages/progress_tab/provider/jwplayer_video_info/jwplayer_video_info.dart';
import 'package:all_video_downloader/presentation/pages/progress_tab/provider/jwplayer_video_info/jwplayer_video_info.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

// TODO: sup 사이트 parsing 확인 및 여타 사이트(m3u8로 다운받는 사이트, ex: 트위터 등등) 다운로드 가능하게 해야함.

class WebviewScreen extends ConsumerStatefulWidget {
  String inputUrl;
  String currentTabId;
  final void Function(InAppWebViewController controller) onWebViewCreated;
  final void Function(bool isLoaded) onPageLoad;

  WebviewScreen(
      {super.key,
      required this.inputUrl,
      required this.currentTabId,
      required this.onWebViewCreated,
      required this.onPageLoad});

  @override
  ConsumerState<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends ConsumerState<WebviewScreen> {
  InAppWebViewController? webViewController;
  late PullToRefreshController pullToRefreshController;
  String url = '';
  double progress = 0;
  List<String>? m3u8UrlList = [];
  List<String>? shtmlUrlList = [];
  Map<String, String> customHeader = {};
  String jwplayerUrl = '';
  List<String> jwplayerUrlList = [];


  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
        javaScriptEnabled: true,
        javaScriptCanOpenWindowsAutomatically: true,
        useOnLoadResource: true,
        useShouldInterceptAjaxRequest: true,
        useShouldInterceptFetchRequest: true,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
        useShouldInterceptRequest: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  @override
  void initState() {
    super.initState();
    pullToRefreshController = PullToRefreshController(
        options: PullToRefreshOptions(
          color: Colors.blue,
        ),
        onRefresh: () async {
          if (Platform.isAndroid) {
            webViewController?.reload();
          } else if (Platform.isIOS) {
            webViewController?.loadUrl(
                urlRequest: URLRequest(url: await webViewController?.getUrl()));
          }
        });
  }

  @override
  void didUpdateWidget(covariant WebviewScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.inputUrl != widget.inputUrl) {
      loadUrl(widget.inputUrl);
      Future.microtask(() {
        ref
            .read(internetTabListProvider.notifier)
            .changeCurrentUrl(widget.currentTabId, widget.inputUrl);
      });
    }
  }

  void loadUrl(String url) {
    final fullUrl = ensureHttpPrefix(url);
    webViewController?.loadUrl(urlRequest: URLRequest(url: Uri.parse(fullUrl)));
  }

  @override
  Widget build(BuildContext context) {
    var inputUrl = ensureHttpPrefix(widget.inputUrl);
    String? previousUrl;
    ref.listen(internetTabListProvider.select((state) => state.currentUrl), (previous, next) {
      if (previous != next) {
        ref.read(JwPlayerVideoInfoProvider.notifier).state = JwplayerVideoInfo(inputUrls: [], headers: {});
        ref.read(HlsVideoInfoProvider.notifier).state = HlsVideoInfo(hlsUrls: [], title: '');
        m3u8UrlList!.clear();
        jwplayerUrlList!.clear();
      }
    });
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  InAppWebView(
                    initialUrlRequest: URLRequest(
                      url: Uri.parse(inputUrl),
                    ),
                    initialOptions: options,
                    pullToRefreshController: pullToRefreshController,
                    onWebViewCreated: (controller) {
                      webViewController = controller;
                      ref.read(webViewControllerProvider.notifier).state =
                          controller;
                      widget.onWebViewCreated(controller);
                    },
                    onCreateWindow: (controller, action) async {
                      final isConfirmed = await showDialog<bool>(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('새 탭을 여시겠습니까?'),
                            actions: [
                              TextButton(
                                child: Text("취소"),
                                onPressed: () => Navigator.pop(context, false),
                              ),
                              TextButton(
                                child: Text("확인"),
                                onPressed: () => Navigator.pop(context, true),
                              ),
                            ],
                          );
                        }
                      );

                      if (isConfirmed == true) {
                        final newTabId = Uuid().v4();
                        final newUrl = action.request.url.toString();

                        InternetTabEntity addTab = InternetTabEntity(
                          url: newUrl,
                          faviconPath: AppIcons.newTabIcon,
                          title: '새 탭',
                          tabId: newTabId,
                        );

                        await ref.read(internetTabListProvider.notifier).insertInternetTab(addTab);
                        ref.read(internetTabListProvider.notifier).setCurrentTabId(newTabId);
                        return true;
                      }

                      return false;
                    },
                    onLoadStart: (controller, url) async {
                      await ref
                          .read(internetTabListProvider.notifier)
                          .changeCurrentUrl(
                              widget.currentTabId, url.toString());
                      ref.read(internetTabListProvider.notifier).saveLastTabInfo(widget.currentTabId, url.toString());
                      setState(() {
                        this.url = url.toString();
                      });
                    },
                    onLoadStop: (controller, url) async {
                      if (url.toString() == previousUrl) {
                        return;
                      }
                      await ref.read(internetTabListProvider.notifier).saveLastTabInfo(widget.currentTabId, url.toString());
                      previousUrl = url.toString();
                      setState(() {
                        this.url = url.toString();
                        m3u8UrlList!.clear();
                      });
                      if (FocusScope.of(context).hasFocus) {
                        FocusScope.of(context).unfocus();
                      }

                      Map<String, dynamic> siteInformation = await getSiteInformation(controller);
                      String? title = siteInformation['title'];
                      print('title: $title');
                      String faviconUrl = siteInformation['faviconUrl'];

                      if (mounted) {
                        ref.read(HlsVideoInfoProvider.notifier).state = HlsVideoInfo(
                                hlsUrls: m3u8UrlList,
                                title: title,);
                      }

                      WidgetsBinding.instance.addPostFrameCallback((_) async {
                        if (!mounted) return;
                        await ref
                            .read(internetTabListProvider.notifier)
                            .setPageDetails(
                                widget.currentTabId, title ?? '', faviconUrl);
                        final InternetHistoryEntity internetHistoryEntity =
                            InternetHistoryEntity(
                                title: title!,
                                url: url.toString(),
                                faviconPath: faviconUrl,
                                VisitedTime: DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString());
                        await ref
                            .read(internetHistoryListProvider.notifier)
                            .insertInternetHistory(internetHistoryEntity);
                        widget.onPageLoad(true);
                      });
                    },
                    androidOnPermissionRequest:
                        (controller, origin, resources) async {
                      return PermissionRequestResponse(
                          resources: resources,
                          action: PermissionRequestResponseAction.GRANT);
                    },
                    shouldOverrideUrlLoading:
                        (controller, navigationAction) async {
                      final currentUri = Uri.parse(url);
                      final targetUri = navigationAction.request.url!;

                      if (currentUri.host != targetUri.host) {
                        final isConfirmed = await showDialog<bool>(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("다른 사이트로 이동하시겠습니까?"),
                              content: Text("${targetUri.host}로 이동하려고 합니다."),
                              actions: [
                                TextButton(
                                  child: Text("취소"),
                                  onPressed: () => Navigator.pop(context, false),
                                ),
                                TextButton(
                                  child: Text("확인"),
                                  onPressed: () => Navigator.pop(context, true),
                                ),
                              ],
                            );
                          },
                        );

                        if (isConfirmed == true) {
                          // 사용자가 확인한 경우에만 새 URL로 이동 허용
                          return NavigationActionPolicy.ALLOW;
                        } else {
                          // 사용자가 취소를 누르면 이동하지 않음
                          return NavigationActionPolicy.CANCEL;
                        }
                      }

                      var uri = navigationAction.request.url!;
                      if (![
                        'http',
                        'https',
                        'file',
                        'chrome',
                        'data',
                        'javascript',
                        'about'
                      ].contains(uri.scheme)) {
                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(
                            Uri.parse(url),
                          );
                          return NavigationActionPolicy.CANCEL;
                        }
                      }
                      return NavigationActionPolicy.ALLOW;
                    },
                    onLoadError: (controller, url, code, message) {
                      pullToRefreshController.endRefreshing();
                    },
                    onProgressChanged: (controller, progress) async {
                      if (progress == 100) {
                        pullToRefreshController.endRefreshing();

                        Map<String, dynamic> siteInformation = await getSiteInformation(controller);
                        String? title = siteInformation['title'];
                        print('title: $title');
                        String faviconUrl = siteInformation['faviconUrl'];

                        await ref
                            .read(internetTabListProvider.notifier)
                            .setPageDetails(
                            widget.currentTabId, title ?? '', faviconUrl);
                      }
                      setState(() {
                        this.progress = progress / 100;
                      });
                    },
                    onLoadResource: (controller, resource) {
                    },
                    // onResourceLoad로는 안되는 request intercept를 되게함.
                    androidShouldInterceptRequest: (controller, request) async {
                      final getUrl = request.url.toString();

                      customHeader = request.headers!;
                      if (getUrl.contains('.m3u8')){
                        setState(() {
                          m3u8UrlList!.add(getUrl);
                        });
                        ref.read(HlsVideoInfoProvider.notifier).state = HlsVideoInfo(hlsUrls: m3u8UrlList, title: ref.read(HlsVideoInfoProvider).title);
                      }
                      if (getUrl.endsWith(".html") || getUrl.endsWith(".js")) {
                        if (!shouldIgnoreFile(getUrl)){
                          setState(() {
                            jwplayerUrlList.add(getUrl);
                          });
                        }
                        ref.read(JwPlayerVideoInfoProvider.notifier).state = JwplayerVideoInfo(inputUrls: jwplayerUrlList, headers: customHeader);
                      }
                    },
                  ),
                  progress < 1.0
                      ? LinearProgressIndicator(
                          value: progress,
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool shouldIgnoreFile(String url) {
    final List<String> ignoreList = [
      "loads",
      "jquery",
      "common",
      "wrest",
      "placeholders",
      "contentscript",
      "viewimageresize",
      "email-decode",
      "main",
      "content_script",
      "jwplayer",
      "hls",
      "jwpsrv",
      "disable-devtool",
      "content",
      "collect",
      "vendor",
      "client-web",
      "modules",
      "loader"
    ];

    for (String fileName in ignoreList){
      if (url.contains(fileName)){
        return true;
      }
    }
    return false;
  }

  String ensureHttpPrefix(String url) {
    if (!url.startsWith(RegExp(r'https?://'))) {
      return 'https://$url';
    } else {
      return url;
    }
  }

  Future<Map<String, dynamic>> getSiteInformation(InAppWebViewController controller) async {
    Map<String, dynamic> siteInformation = {};
    String? title = await controller.getTitle();
    List<Favicon> favicons = await controller.getFavicons();
    final faviconUrl = favicons.isNotEmpty
        ? favicons.first.url.toString()
        : '';
    if (title?.isNotEmpty == true){
      title = title;
    } else{
      Future.delayed(Duration(milliseconds: 1000));
      title = await controller.getTitle();
    }
    siteInformation['title'] = title;
    siteInformation['faviconUrl'] = faviconUrl;


    return siteInformation;
  }
}
