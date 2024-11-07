import 'package:all_video_downloader/core/theme/constant/app_icons.dart';
import 'package:all_video_downloader/presentation/pages/home_tab/provider/internet_bookmark/internet_bookmark.provider.dart';
import 'package:all_video_downloader/presentation/pages/home_tab/provider/internet_tab.provider.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';

class InternetBookmarkWidget extends ConsumerWidget {
  String title;
  String url;
  String faviconPath;
  String tabId;
  String bookmarkId;

  InternetBookmarkWidget({super.key, required this.title, required this.url, required this.faviconPath, required this.bookmarkId, required this.tabId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            leading: (faviconPath == AppIcons.newTabIcon) ? Image.asset(faviconPath, width: 30, height: 30,):Image.network(faviconPath, width: 30, height: 30,),
            title: Text(title),
            onTap: () {
              debugPrint(tabId);
              ref.read(internetTabListProvider.notifier).setCurrentTabId(tabId);
              ref.read(internetTabListProvider.notifier).changeCurrentUrl(tabId, url);
              ref.read(internetTabListProvider.notifier).saveLastTabInfo(tabId, url);
              Navigator.pop(context);
            },
          ),
        ),
        GestureDetector(
          onTap: () async {
            await ref.read(internetBookmarkListProvider.notifier).deleteInternetBookmark(bookmarkId);
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Transform.rotate(angle: math.pi / 4,child: Icon(Icons.add, size: 24,)),
          ),
        )
      ],
    );
  }
}
