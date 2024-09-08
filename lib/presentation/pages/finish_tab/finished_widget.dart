import 'package:all_video_downloader/core/theme/constant/app_colors.dart';
import 'package:all_video_downloader/core/theme/constant/app_icons.dart';
import 'package:all_video_downloader/core/theme/theme_data.dart';
import 'package:all_video_downloader/core/utils/widgets/shadow_container.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class FinishedWidget extends StatelessWidget {
  String title;
  double entireVolume;

  FinishedWidget({super.key, required this.title, required this.entireVolume});

  @override
  Widget build(BuildContext context) {
    return ShadowContainerWidget(
      outsidePadding: EdgeInsets.zero,
      insidePadding: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(5),
      height: 130,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Image.asset(
              AppIcons.exampleImage,
              height: 88,
              width: 120,
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: CustomThemeData.themeData.textTheme.titleSmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(Icons.more_vert, size: 24,color: AppColors.primary,)
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text('${entireVolume.toString()} MB', style: CustomThemeData.themeData.textTheme.labelSmall,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
