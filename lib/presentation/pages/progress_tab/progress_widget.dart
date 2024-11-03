import 'dart:io';

import 'package:all_video_downloader/core/theme/constant/app_colors.dart';
import 'package:all_video_downloader/core/theme/theme_data.dart';
import 'package:all_video_downloader/core/utils/widgets/shadow_container.dart';
import 'package:all_video_downloader/data/remote/video_download.dart';
import 'package:all_video_downloader/domain/model/video_download/video_download_model.dart';
import 'package:all_video_downloader/presentation/pages/progress_tab/provider/progress_provider/progress_provider.provider.dart';
import 'package:all_video_downloader/presentation/pages/progress_tab/provider/progress_provider/task_info.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProgressWidget extends ConsumerStatefulWidget {
  String uuid;
  DateTime previousTime;
  String title;

  ProgressWidget(
      {super.key,
      required this.uuid,
      required this.previousTime,
      required this.title});

  @override
  ConsumerState<ProgressWidget> createState() => _ProgressWidgetState();
}

class _ProgressWidgetState extends ConsumerState<ProgressWidget> {
  bool _isMerging = false;
  @override
  void initState() {
    _isMerging = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double totalDownloadedSize = 0.0;
    double downloadSpeed = 0.0;
    ref.listen<VideoDownloadModel>(progressProvider.select((state) => state.downloadInformationList.firstWhere((model) => model.id == widget.uuid, orElse: () => VideoDownloadModel.empty())), (previous, next) async {
      final videoModel = next!;
      if (!videoModel.isMerged){
        print('_isMerging: $_isMerging');
        final title = videoModel.title;
        final segmentPaths = videoModel.segmentPaths;
        double totalProgress = 0.0;

        for (String taskId in videoModel.taskStatus.keys){
          int progress = videoModel.taskStatus[taskId]!.progress ?? 0;
          totalProgress += progress;
        }

        // 전체 진행도
        double overallProgress = totalProgress / videoModel.taskStatus.length;

        // 전체 다운로드 사이즈
        totalDownloadedSize = await getTotalDownloadedSize(videoModel.saveDir);

        // 다운로드 속도
        downloadSpeed = calculateDownloadSpeed(totalDownloadedSize, widget.previousTime);

        if (!mounted){
          return;
        } else {
          await ref.read(progressProvider.notifier).updateDownloadQueue(videoModel.id, null, totalDownloadedSize, downloadSpeed, overallProgress, null, null, null, null, null, null);
        }

        // TODO: taskStatus.updateAll을 추가했으니, 확인해보고. 안되면 초기의 10개 값 정도만 null로 초기화 되닌까, 초기값 null 마지막 값 complete 일때는 이름을 써서 다운로드 됬는지 체크하는걸로 ㄱㄱ
        // TODO: 아니면 allTaskCompleted를 하지 말고, 다운로드된 segment수와 taskStatus의 수가 같으면 진행하는걸로 ㄱㄱ

        final allTaskCompleted = videoModel.taskStatus.values.every((taskInfo) =>
        taskInfo.status == DownloadTaskStatus.complete ||
            taskInfo.status == DownloadTaskStatus.canceled ||
            taskInfo.status == DownloadTaskStatus.failed
        );
        final isAllTaskComplete = videoModel.taskStatus.values.every((taskInfo) =>
        taskInfo.status == DownloadTaskStatus.complete);

        bool isCountEqual = await isFileCountEqualToStatusCount(videoModel.saveDir, videoModel.taskStatus);

        // TODO: 1103, 다운로드 문제 없이 되는거 확인함. 연속 다운로드 문제 없는지 확인 필요.

        if (isCountEqual && !_isMerging){
          _isMerging = true;
          await ref.read(progressProvider.notifier).updateDownloadQueue(videoModel.id, null, null, null, null, DownloadTaskStatus.merging, null, null, null, null, true);
          bool ffmpegResult = await mergeSegmentsFuction(videoModel.id, segmentPaths, title, ref);
          if (ffmpegResult) {
            await ref.read(progressProvider.notifier).updateDownloadQueue(videoModel.id, null, null, null, null, DownloadTaskStatus.complete, null, null, null, null, null);
            await ref.read(progressProvider.notifier).deleteDownloadQueue(videoModel.id);
            await ref.read(progressProvider.notifier).stopDownloading();
          } else{
            await ref.read(progressProvider.notifier).updateDownloadQueue(videoModel.id, null, null, null, null, DownloadTaskStatus.failed, null, null, null, null, null);
            await ref.read(progressProvider.notifier).deleteDownloadQueue(videoModel.id);
            await ref.read(progressProvider.notifier).stopDownloading();
          }
          _isMerging = false;
        } else if (allTaskCompleted && !isAllTaskComplete && !_isMerging){
          await ref.read(progressProvider.notifier).updateDownloadQueue(videoModel.id, null, null, null, null, DownloadTaskStatus.failed, null, null, null, null, true);
        }
      }
      // TODO: 2개 연속 다운로드, 다운 중 정지/재다운 확인, 다운로드 잘 되는지 확인.
    });

    final progressState = ref.watch(progressProvider);
    final videoModel = progressState.downloadInformationList.firstWhere((model) => model.id == widget.uuid);
    if (videoModel == null){
      return SizedBox.shrink();
    }
    final title = videoModel.title;
    final thumbnailPath = videoModel.backgroundImageUrl;
    final downloadedSize = videoModel.downloadedSized;
    final downloadProgress = videoModel.downloadProgress;
    final downloadStatus = videoModel.downloadStatus;

    double calculatedPercent = downloadProgress;
    double progressValue = (calculatedPercent.isFinite && !calculatedPercent.isNaN) ? calculatedPercent / 100 : 0.0;
    double progressDoubleValue = (calculatedPercent.isFinite && !calculatedPercent.isNaN) ? calculatedPercent : 0.0;
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
                        onTap: () async {
                          _cancelDownload(videoModel);
                          await ref.read(progressProvider.notifier).updateDownloadQueue(widget.uuid, null, null, null, null, DownloadTaskStatus.canceled, null, null, null, null, null);
                          await ref.read(progressProvider.notifier).deleteDownloadQueue(widget.uuid);
                          await ref.read(progressProvider.notifier).stopDownloading();
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
                    value: progressValue,
                    backgroundColor: AppColors.containerBackgroundColor,
                    color: AppColors.primary,
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${downloadedSize.toStringAsFixed(2)}MB (${progressDoubleValue.toStringAsFixed(1)}%)',
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
                          getDownloadStatusAndFunction(downloadStatus, videoModel),
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

  Widget getDownloadStatusAndFunction(DownloadTaskStatus downloadStatus, VideoDownloadModel videoModel) {
    if (downloadStatus == DownloadTaskStatus.running) {
      return GestureDetector(
        onTap: () async {
          _pauseDownload(videoModel);
          await ref.read(progressProvider.notifier).updateDownloadQueue(videoModel.id, null, null, null, null, DownloadTaskStatus.paused, null, null, null, null, null);
        },
        child: const Icon(
          Icons.pause,
          size: 24,
          color: AppColors.primary,
        ),
      );
    } else if (downloadStatus == DownloadTaskStatus.paused) {
      return GestureDetector(
        onTap: () async {
          _resumeDownload(videoModel);
          await ref.read(progressProvider.notifier).updateDownloadQueue(videoModel.id, null, null, null, null, DownloadTaskStatus.running, null, null, null, null, null);
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
        onTap: () async {
          _pauseDownload(videoModel);
          await ref.read(progressProvider.notifier).updateDownloadQueue(videoModel.id, null, null, null, null, DownloadTaskStatus.paused, null, null, null, null, null);
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
    } else if (downloadStatus == DownloadTaskStatus.failed) {
      return '다운로드 실패';
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

  Future<void> _cancelDownload(VideoDownloadModel videoModel) async {
    final taskIds = videoModel.taskStatus.keys;
    for (String taskId in taskIds){
      await FlutterDownloader.cancel(taskId: taskId);
    }
  }

  Future<void> _pauseDownload(VideoDownloadModel videoModel) async {
    final taskIds = videoModel.taskStatus.keys;
    for (String taskId in taskIds) {
      await FlutterDownloader.pause(taskId: taskId);
    }
  }

  Future<void> _resumeDownload(VideoDownloadModel videoModel) async {
    final taskIds = videoModel.taskStatus.keys;
    for (String taskId in taskIds){
      final taskInfo = videoModel.taskStatus[taskId];
      if (taskInfo!.status == DownloadTaskStatus.paused){
        final newTaskId = await FlutterDownloader.resume(taskId: taskId);
        videoModel.taskStatus.remove(taskId);
        videoModel.taskStatus[newTaskId!] = TaskInfo(
          status: DownloadTaskStatus.enqueued,
          progress: taskInfo.progress,
        );
        await ref.read(progressProvider.notifier).updateDownloadQueue(videoModel.id, null, null, null, null, DownloadTaskStatus.running, null, videoModel.taskStatus, null, null, null);
      }
    }
  }

  Future<double> getTotalDownloadedSize(String saveDir) async {
    final directory = Directory(saveDir);
    double totalSizeInMB = 0.0;
    if (directory.existsSync()) {
      final files = directory.listSync();
      for (var file in files) {
        if (file is File) {
          int fileSizeInBytes = await file.length();
          double fileSizeInMB = fileSizeInBytes / (1024 * 1024);
          totalSizeInMB += fileSizeInMB;
        }
      }
    }
    return totalSizeInMB;
  }

  double calculateDownloadSpeed(double downloadedSize, DateTime previousTime) {
    DateTime currentTime = DateTime.now();
    final timeDiff = currentTime.difference(previousTime).inMilliseconds;
    if (timeDiff > 0) {
      final downloadPerSecond = downloadedSize / (timeDiff / 1000);
      return downloadPerSecond;
    }
    return 0.0;
  }

  Future<bool> isFileCountEqualToStatusCount(String saveDir, Map<String, TaskInfo> taskStatus) async{
    final directory = Directory(saveDir);

    if (!directory.existsSync()){
      return taskStatus.isEmpty;
    }

    final files = directory.listSync();
    int fileCount = files.whereType<File>().length;

    if (fileCount >= taskStatus.length){
      return true;
    } else{
      return false;
    }
  }
}

//TODO: 2개 동시에 다운 가능한지,
//TODO: 중지 시에는 왜 재개가 안되는지 확인해야함.
//TODO: FINISH에 폴더의 영상파일 보이게 해야함.
