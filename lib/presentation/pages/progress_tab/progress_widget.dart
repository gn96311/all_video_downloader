import 'package:all_video_downloader/core/theme/constant/app_colors.dart';
import 'package:all_video_downloader/core/theme/theme_data.dart';
import 'package:all_video_downloader/core/utils/widgets/shadow_container.dart';
import 'package:all_video_downloader/presentation/pages/progress_tab/progress_state_provider.dart';
import 'package:all_video_downloader/presentation/pages/progress_tab/provider/video_download_progress/video_download_progress.provider.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProgressWidget extends ConsumerWidget {
  String uuid;
  String title;
  String thumbnailPath;
  double downloadedSize;
  double downloadSpeed;
  double downloadProgress;
  DownloadTaskStatus downloadStatus;

  ProgressWidget(
      {super.key,
        required this.uuid,
      required this.title,
      required this.thumbnailPath,
      required this.downloadedSize,
      required this.downloadSpeed,
      required this.downloadProgress,
      required this.downloadStatus,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int calculatedPercent = downloadProgress.toInt();
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
              thumbnailPath,
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
                      GestureDetector(
                        onTap: () {
                        },
                        child: Transform.rotate(
                          angle: math.pi / 4,
                          child: Icon(
                            Icons.add,
                            size: 24,
                            color: AppColors.primary,
                          ),
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
                    '${downloadedSize}MB downloaded (${downloadProgress}%)',
                    style: CustomThemeData.themeData.textTheme.labelSmall,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        getDownloadStatusName(downloadStatus),
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
                            getDownloadStatus(downloadStatus),
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

  IconData getDownloadStatus(DownloadTaskStatus downloadStatus){
    if (downloadStatus == DownloadTaskStatus.running) {
      return Icons.pause;
    } else if (downloadStatus == DownloadTaskStatus.paused) {
      return Icons.file_download_outlined;
    } else if (downloadStatus == DownloadTaskStatus.enqueued){
      return Icons.access_time_rounded;
    } else if (downloadStatus == DownloadTaskStatus.merging) {
      return Icons.merge_outlined;
    } else if (downloadStatus == DownloadTaskStatus.undefined) {
      return Icons.access_time_rounded;
    }
    else {
      return Icons.pause;
    }
  }

  String getDownloadStatusName(DownloadTaskStatus downloadStatus){
    if (downloadStatus == DownloadTaskStatus.running){
      return '다운로드 중';
    } else if (downloadStatus == DownloadTaskStatus.undefined) {
      return '대기중';
    } else if (downloadStatus == DownloadTaskStatus.enqueued) {
      return '대기중';
    } else if (downloadStatus == DownloadTaskStatus.paused) {
      return '중지';
    } else if (downloadStatus == DownloadTaskStatus.merging) {
      return '영상 변환중';
    } else{
      return '';
    }
  }
}


