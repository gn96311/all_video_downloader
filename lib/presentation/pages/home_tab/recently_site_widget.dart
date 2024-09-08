import 'package:all_video_downloader/core/theme/theme_data.dart';
import 'package:flutter/material.dart';

class RecentlySiteWidget extends StatelessWidget {
  Widget child;
  String title;
  RecentlySiteWidget({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          children: [
            Column(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  child: child,
                ),
                Text(
                  title,
                  style:
                  CustomThemeData.themeData.textTheme.titleSmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(width: 20,)
          ],
        ), // TODO: recently_site_widget으로 변환
      ],
    );
  }
}
