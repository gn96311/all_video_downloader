import 'package:all_video_downloader/core/theme/theme_data.dart';
import 'package:all_video_downloader/domain/model/internet_bookmark/internet_bookmark.model.dart';
import 'package:all_video_downloader/presentation/pages/home_tab/provider/internet_bookmark/internet_bookmark.provider.dart';
import 'package:all_video_downloader/presentation/pages/home_tab/provider/internet_history/internet_history.provider.dart';
import 'package:all_video_downloader/presentation/pages/home_tab/recently_site_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewTabScreen extends ConsumerWidget {
  String currentTabId;

  NewTabScreen({super.key, required this.currentTabId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarkList = ref.watch(internetBookmarkListProvider).bookmarkList;
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Container(
        width: double.infinity,
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recently used website',
                style: CustomThemeData.themeData.textTheme.labelLarge,
              ),
              SizedBox(
                height: 16,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: bookmarkList.asMap().entries.map((entry) {
                      int index = entry.key;
                      InternetBookmarkModel e = entry.value;
                      return Row(children: [
                        RecentlySiteWidget(
                          child: Image.network(e.faviconPath),
                          title: e.title,
                          url: e.url,
                          currentTabId: currentTabId,
                        ),
                        SizedBox(
                          width: 10,
                        )
                      ]);
                    }).toList(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// children: tabListState.tabList.asMap().entries.map((entry) {
// int index = entry.key;
// InternetTabModel e = entry.value;
// return InternetTabWidget(
// title: e.title,
// url: e.url,
// faviconPath: e.faviconPath,
// tabId: e.tabId);
// }).toList(),

// RecentlySiteWidget(
// child: Icon(
// Icons.check_circle,
// size: 40,
// ),
// title: 'Example'),
