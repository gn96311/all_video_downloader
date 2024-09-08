import 'package:all_video_downloader/core/theme/theme_data.dart';
import 'package:all_video_downloader/presentation/pages/home_tab/recently_site_widget.dart';
import 'package:flutter/material.dart';

class NewTabScreen extends StatelessWidget {
  const NewTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                height: 12,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      RecentlySiteWidget(
                          child: Icon(
                            Icons.check_circle,
                            size: 40,
                          ),
                          title: 'Example'),
                      RecentlySiteWidget(
                          child: Icon(
                            Icons.check_circle,
                            size: 40,
                          ),
                          title: 'Example'),
                      RecentlySiteWidget(
                          child: Icon(
                            Icons.check_circle,
                            size: 40,
                          ),
                          title: 'Example'),
                      RecentlySiteWidget(
                          child: Icon(
                            Icons.check_circle,
                            size: 40,
                          ),
                          title: 'Example'),
                      RecentlySiteWidget(
                          child: Icon(
                            Icons.check_circle,
                            size: 40,
                          ),
                          title: 'Example'),
                    ],
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
