import 'package:all_video_downloader/core/theme/constant/app_icons.dart';
import 'package:all_video_downloader/presentation/pages/home_tab/provider/internet_tab.provider.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';

class InternetTabWidget extends ConsumerWidget {
  String title;
  String url;
  String faviconPath;
  String tabId;

  InternetTabWidget({super.key, required this.title, required this.url, required this.faviconPath, required this.tabId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            leading: (faviconPath == AppIcons.newTabIcon) ? Image.asset(faviconPath, width: 30, height: 30,):Image.network(faviconPath, width: 30, height: 30,),
            title: Text(title),
            onTap: () {
              ref.read(internetTabListProvider.notifier).setCurrentTabId(tabId);
              Navigator.pop(context);
            },
          ),
        ),
        GestureDetector(
          onTap: () async {
            await ref.read(internetTabListProvider.notifier).deleteInternetTab(tabId);
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
