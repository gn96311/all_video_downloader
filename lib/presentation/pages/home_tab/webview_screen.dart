import 'dart:io';

import 'package:all_video_downloader/data/entity/internet_history.entity.dart';
import 'package:all_video_downloader/presentation/pages/home_tab/provider/internet_history/internet_history.provider.dart';
import 'package:all_video_downloader/presentation/pages/home_tab/provider/internet_tab.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class WebviewScreen extends ConsumerStatefulWidget {
  String inputUrl;
  String currentTabId;
  final void Function(InAppWebViewController controller) onWebViewCreated;

  WebviewScreen(
      {super.key, required this.inputUrl, required this.currentTabId, required this.onWebViewCreated});

  @override
  ConsumerState<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends ConsumerState<WebviewScreen> {
  InAppWebViewController? webViewController;
  late PullToRefreshController pullToRefreshController;
  String url = '';
  double progress = 0;

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
        javaScriptEnabled: true,
        javaScriptCanOpenWindowsAutomatically: true,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
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
                      widget.onWebViewCreated(controller);
                    },
                    onLoadStart: (controller, url) {
                      ref.read(internetTabListProvider.notifier).changeCurrentUrl(widget.currentTabId, url.toString());
                      setState(() {
                        this.url = url.toString();
                      });
                    },
                    onLoadStop: (controller, url) async {
                      setState(() {
                        this.url = url.toString();
                      });
                      if (FocusScope.of(context).hasFocus){
                        FocusScope.of(context).unfocus();
                      }
                      final title = await controller.getTitle();
                      final favicons = await controller.getFavicons();
                      final faviconUrl = favicons.isNotEmpty
                          ? favicons.first.url.toString()
                          : '';

                      WidgetsBinding.instance.addPostFrameCallback((_) async {
                        await ref
                            .read(internetTabListProvider.notifier)
                            .setPageDetails(
                                widget.currentTabId, title ?? '', faviconUrl);
                        final InternetHistoryEntity internetHistoryEntity = InternetHistoryEntity(title: title!, url: url.toString(), faviconPath: faviconUrl, VisitedTime: DateTime.now().millisecondsSinceEpoch.toString());
                        await ref.read(internetHistoryListProvider.notifier).insertInternetHistory(internetHistoryEntity);
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
                    onProgressChanged: (controller, progress) {
                      if (progress == 100) {
                        pullToRefreshController.endRefreshing();
                      }
                      setState(() {
                        this.progress = progress / 100;
                      });
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

  String ensureHttpPrefix(String url) {
    if (!url.startsWith(RegExp(r'https?://'))) {
      return 'https://$url';
    } else {
      return url;
    }
  }
}
