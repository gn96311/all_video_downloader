import 'dart:io';

import 'package:all_video_downloader/core/theme/constant/app_colors.dart';
import 'package:all_video_downloader/core/theme/theme_data.dart';
import 'package:all_video_downloader/core/utils/widgets/shadow_container.dart';
import 'package:all_video_downloader/domain/model/download_manager/download_manager.dart';
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
    double calculatedPercent = downloadProgress;
    return ShadowContainerWidget(
      outsidePadding: EdgeInsets.zero,
      insidePadding: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(5),
      height: 130,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            showThumbnail(thumbnailPath),
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
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          // TODO: ID를 받아서, REF를 통해 해당 ID를 찾아, FlutterDownloader를 정지시키는 기능을 넣어야함.다른 부분에도 다 넣어야함.
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
                    value: calculatedPercent / 100,
                    backgroundColor: AppColors.containerBackgroundColor,
                    color: AppColors.primary,
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${downloadedSize.toStringAsFixed(2)}MB (${downloadProgress.toStringAsFixed(1)}%)',
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
                          getDownloadStatusAndFunction(downloadStatus),
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

  Widget getDownloadStatusAndFunction(DownloadTaskStatus downloadStatus) {
    if (downloadStatus == DownloadTaskStatus.running) {
      return GestureDetector(
        onTap: () {
        },
        child: const Icon(
          Icons.pause,
          size: 24,
          color: AppColors.primary,
        ),
      );
    } else if (downloadStatus == DownloadTaskStatus.paused) {
      return GestureDetector(
        onTap: () {
        },
        child: const Icon(Icons.file_download_outlined,
          size: 24,
          color: AppColors.primary,),
      );
    } else if (downloadStatus == DownloadTaskStatus.enqueued) {
      return GestureDetector(
        onTap: () {
        },
        child: const Icon(Icons.access_time_rounded,
          size: 24,
          color: AppColors.primary,),
      );
    } else if (downloadStatus == DownloadTaskStatus.merging) {
      return GestureDetector(
        onTap: () {},
        child: const Icon(Icons.merge_outlined,
          size: 24,
          color: AppColors.primary,),
      );
    } else if (downloadStatus == DownloadTaskStatus.undefined) {
      return GestureDetector(
        onTap: () {},
        child: const Icon(Icons.access_time_rounded,
          size: 24,
          color: AppColors.primary,),
      );
    } else {
      return GestureDetector(
        onTap: () {
        },
        child: const Icon(Icons.pause,
          size: 24,
          color: AppColors.primary,),
      );
    }
  }

  String getDownloadStatusName(DownloadTaskStatus downloadStatus) {
    if (downloadStatus == DownloadTaskStatus.running) {
      return '다운로드 중';
    } else if (downloadStatus == DownloadTaskStatus.undefined) {
      return '대기중';
    } else if (downloadStatus == DownloadTaskStatus.enqueued) {
      return '대기중';
    } else if (downloadStatus == DownloadTaskStatus.paused) {
      return '중지';
    } else if (downloadStatus == DownloadTaskStatus.merging) {
      return '영상 변환중';
    } else {
      return '';
    }
  }

  Widget showThumbnail(String imagePath) {
    return imagePath.startsWith('assets/')
        ? Image.asset(
            imagePath,
            height: 88,
            width: 120,
          )
        : Image.file(
            File(imagePath),
            height: 88,
            width: 120,
          );
  }
}

//TODO: 2개 동시에 다운 가능한지,
//TODO: 중지 시에는 왜 재개가 안되는지 확인해야함.
//TODO: FINISH에 폴더의 영상파일 보이게 해야함.
