import 'package:all_video_downloader/core/theme/constant/app_colors.dart';
import 'package:all_video_downloader/core/theme/theme_data.dart';
import 'package:all_video_downloader/data/remote/video_segment_downloader.dart';
import 'package:all_video_downloader/presentation/pages/progress_tab/progress_widget.dart';
import 'package:all_video_downloader/presentation/pages/progress_tab/provider/progress_provider/progress_provider.provider.dart';
import 'package:all_video_downloader/presentation/pages/progress_tab/provider/progress_provider/progress_provider.state.dart';
import 'package:all_video_downloader/presentation/pages/progress_tab/provider/video_download_progress/video_download_progress.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

class ProgressTabScreen extends ConsumerStatefulWidget {
  const ProgressTabScreen({super.key});

  @override
  ConsumerState<ProgressTabScreen> createState() => _ProgressTabScreenState();
}

class _ProgressTabScreenState extends ConsumerState<ProgressTabScreen> {
  @override
  Widget build(BuildContext context) {
    ref.listen<Tuple2<bool, int>>(progressProvider.select((state) => Tuple2(state.progressDownloading, state.downloadInformationList.length)), (previous, current){
      final previousDownloading = previous?.item1 ?? false;
      final currentDownloading = current.item1;
      final previousLength = previous?.item2 ?? 0;
      final currentLength = current.item2;
      print('state updated!!!');
      print(previousDownloading);
      print(currentDownloading);
      // progressDownloading이 바뀌었는데, current.progressDownloading이 false면 다운로드 가능 확인. 가능하면 시작.
      if (previousDownloading != currentDownloading){
        if (currentDownloading == false) {
          print('up');
          startNextDownloadIfPossible();
        }
      }

      // informationList 요소 삭제, 완료 등으로 인해 길이가 바뀌면, 반응. list가 안비어있고, progressDownloading이 false면 다운로드 가능 확인. 가능하면 시작.
      if (previousLength != currentLength){
        if (currentLength > 0 && !currentDownloading){
          print('down');
          startNextDownloadIfPossible();
        }
      }
    });

    final downloadList = ref.watch(progressProvider).downloadInformationList;
    // TODO: 이걸 이제 progressProvider로 바꾸어야 함.
    // TODO: 각 위젯에 VideoDownloadModel을 넘기고,
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
                    child: Text(downloadList.length.toString()),
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
                  final item = downloadList[index];
                  return Column(
                    children: [
                      ProgressWidget(
                          uuid: item.id,
                          previousTime: DateTime.now(),
                          title: item.title,
                      ),
                      SizedBox(height: 10,),
                    ],
                  );
                },
                itemCount: downloadList.length,
              ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> startNextDownloadIfPossible() async {
    //여기서는 들어가는 다운로드 info를 얻을 수 있음.
    final state = ref.read(progressProvider);
    if (!state.progressDownloading && state.downloadInformationList.isNotEmpty) {
      final nextDownloadInformation = state.downloadInformationList.first;
      try {
        await ref.read(progressProvider.notifier).startDownloading();
        await startSegmentDownload(nextDownloadInformation, ref);
      } catch (e) {
      }
    }
  }
}
