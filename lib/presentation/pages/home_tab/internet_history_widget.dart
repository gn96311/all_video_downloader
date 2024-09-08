import 'package:all_video_downloader/core/theme/constant/app_icons.dart';
import 'package:all_video_downloader/presentation/pages/home_tab/provider/internet_history/internet_history.provider.dart';
import 'package:all_video_downloader/presentation/pages/home_tab/provider/internet_tab.provider.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';

class InternetHistoryWidget extends ConsumerStatefulWidget {
  String title;
  String url;
  String faviconPath;
  String visitedTime;

  InternetHistoryWidget({super.key, required this.title, required this.url, required this.faviconPath, required this.visitedTime});

  @override
  ConsumerState<InternetHistoryWidget> createState() => _InternetHistoryWidgetState();
}

class _InternetHistoryWidgetState extends ConsumerState<InternetHistoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            leading: (widget.faviconPath == AppIcons.newTabIcon) ? Image.asset(widget.faviconPath, width: 20, height: 20,):Image.network(widget.faviconPath, width: 30, height: 30,),
            title: Text(widget.title),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        GestureDetector(
          onTap: () async {
            await ref.read(internetHistoryListProvider.notifier).deleteInternetHistory(widget.visitedTime);
            debugPrint(ref.watch(internetHistoryListProvider).toString());
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Transform.rotate(angle: math.pi / 4,child: Icon(Icons.add, size: 20,)),
          ),
        )
      ],
    );
  }
}
