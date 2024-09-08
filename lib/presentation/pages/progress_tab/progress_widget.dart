import 'package:all_video_downloader/core/theme/constant/app_colors.dart';
import 'package:all_video_downloader/core/theme/constant/app_icons.dart';
import 'package:all_video_downloader/core/theme/theme_data.dart';
import 'package:all_video_downloader/core/utils/widgets/shadow_container.dart';
import 'package:all_video_downloader/presentation/pages/progress_tab/progress_state_provider.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ProgressWidget extends StatelessWidget {
  String title;
  double entireVolume;
  double downloadedVolume;
  ProgressState progressState;

  ProgressWidget(
      {super.key,
      required this.title,
      required this.entireVolume,
      required this.downloadedVolume,
      required this.progressState});

  @override
  Widget build(BuildContext context) {
    int calculatedPercent = ((downloadedVolume / entireVolume) * 100).toInt();
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
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: CustomThemeData.themeData.textTheme.titleSmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 5,),
                      Transform.rotate(
                        angle: math.pi / 4,
                        child: Icon(
                          Icons.add,
                          size: 24,
                          color: AppColors.primary,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  LinearProgressIndicator(
                    value: 0.63,
                    backgroundColor: AppColors.containerBackgroundColor,
                    color: AppColors.primary,
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${downloadedVolume}MB/${entireVolume}MB (${calculatedPercent}%)',
                    style: CustomThemeData.themeData.textTheme.labelSmall,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        progressState.toName,
                        style: CustomThemeData.themeData.textTheme.labelSmall,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.language,
                            size: 24,
                            color: AppColors.primary,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Icon(
                            getProgressStateIcon(progressState),
                            size: 24,
                            color: AppColors.primary,
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  IconData getProgressStateIcon(ProgressState progressState){
    if (progressState == ProgressState.downloading) {
      return Icons.pause;
    } else if (progressState == ProgressState.paused) {
      return Icons.file_download_outlined;
    } else if (progressState == ProgressState.waiting){
      return Icons.access_time_rounded;
    } else {
      return Icons.pause;
    }
  }

}


