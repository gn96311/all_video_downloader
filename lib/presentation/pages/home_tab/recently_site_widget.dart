import 'package:all_video_downloader/core/theme/theme_data.dart';
import 'package:all_video_downloader/presentation/pages/home_tab/provider/internet_tab.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecentlySiteWidget extends ConsumerWidget {
  Widget child;
  String title;
  String url;
  String currentTabId;
  RecentlySiteWidget({super.key, required this.child, required this.title, required this.url, required this.currentTabId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        GestureDetector(
          onTap: () {
            ref.read(internetTabListProvider.notifier).changeCurrentUrl(currentTabId, url);
          },
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    child: child,
                  ),
                  SizedBox(height: 10,),
                  Text(
                    title.length > 10 ? '${title.substring(0,7)}...' : title,
                    style:
                    CustomThemeData.themeData.textTheme.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(width: 20,)
            ],
          ),
        ),
      ],
    );
  }
}
