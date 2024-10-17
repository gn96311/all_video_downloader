import 'package:all_video_downloader/core/theme/constant/app_colors.dart';
import 'package:all_video_downloader/core/theme/theme_data.dart';
import 'package:all_video_downloader/presentation/pages/progress_tab/progress_state_provider.dart';
import 'package:all_video_downloader/presentation/pages/progress_tab/progress_widget.dart';
import 'package:all_video_downloader/presentation/pages/progress_tab/provider/video_download_progress/video_download_progress.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProgressTabScreen extends ConsumerWidget {
  const ProgressTabScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloadInformationList =
        ref.watch(VideoDownloadProgressProvider).informationList;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Container(
            height: 60,
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  Text(
                    'PROGRESS',
                    style: CustomThemeData.themeData.textTheme.titleLarge,
                  ),
                  Expanded(child: SizedBox()),
                  Container(
                    height: 30,
                    width: 30,
                    alignment: Alignment.center,
                    child: Text('25'),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(1, 1),
                            color: AppColors.shadowColor.withOpacity(0.2),
                            blurRadius: 2,
                            spreadRadius: 2)
                      ],
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  PopupMenuButton(
                    onSelected: (result) {
                      switch (result) {
                        case 'allPaused':
                          debugPrint('allPaused');
                        case 'allRestart':
                          debugPrint('allRestart');
                        case 'allDelete':
                          debugPrint('allDelete');
                      }
                    },
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                        child: Row(
                          children: [
                            Icon(
                              Icons.pause,
                              size: 20,
                              color: AppColors.lessImportant,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '전부 다운로드 중지',
                              style: CustomThemeData
                                  .themeData.textTheme.titleSmall,
                            )
                          ],
                        ),
                        value: 'allPaused',
                      ),
                      PopupMenuItem(
                        child: Row(
                          children: [
                            Icon(
                              Icons.play_arrow,
                              size: 20,
                              color: AppColors.lessImportant,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '전부 다운로드 재시작',
                              style: CustomThemeData
                                  .themeData.textTheme.titleSmall,
                            )
                          ],
                        ),
                        value: 'allRestart',
                      ),
                      PopupMenuItem(
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete,
                              size: 20,
                              color: AppColors.lessImportant,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '전부 삭제',
                              style: CustomThemeData
                                  .themeData.textTheme.titleSmall,
                            )
                          ],
                        ),
                        value: 'allDelete',
                      ),
                    ],
                    icon: Icon(
                      Icons.more_vert,
                      size: 30,
                      color: AppColors.primary,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowColor.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                itemBuilder: (context, index) {
                  final item = downloadInformationList[index];
                  return ProgressWidget(
                      uuid: item.id,
                      title: item.title,
                      thumbnailPath: item.backgroundImageUrl,
                      downloadedSize: item.downloadedSized,
                      downloadSpeed: item.downloadSpeed,
                      downloadProgress: item.downloadProgress,
                      downloadStatus: item.downloadStatus);
                },
                itemCount: downloadInformationList.length,
              ))
            ],
          ),
          // child: ProgressWidget(
          //   title: 'Title of Video if has long name, describe like this.',
          //   downloadedVolume: 75.05,
          //   entireVolume: 120.02,
          //   progressState: ProgressState.downloading,
          // ),
        ),
      ),
    );
  }
}
