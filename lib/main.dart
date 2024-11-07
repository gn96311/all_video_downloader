import 'dart:isolate';
import 'dart:ui';

import 'package:all_video_downloader/core/theme/theme_data.dart';
import 'package:all_video_downloader/data/entity/internet_bookmark.entity.dart';
import 'package:all_video_downloader/data/entity/internet_history.entity.dart';
import 'package:all_video_downloader/data/entity/internet_tab.entity.dart';
import 'package:all_video_downloader/presentation/pages/progress_tab/provider/progress_provider/progress_provider.provider.dart';
import 'package:all_video_downloader/presentation/pages/progress_tab/provider/progress_provider/task_info.dart';
import 'package:all_video_downloader/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);
  Hive.registerAdapter(InternetTabEntityAdapter());
  Hive.registerAdapter(InternetHistoryEntityAdapter());
  Hive.registerAdapter(InternetBookmarkEntityAdapter());

  final port = ReceivePort();
  IsolateNameServer.removePortNameMapping('downloader_send_port');
  IsolateNameServer.registerPortWithName(port.sendPort, 'downloader_send_port');

  WidgetsBinding.instance.addPostFrameCallback((_) {
    Future.delayed(Duration.zero, () {
      if (navigatorKey.currentContext != null) {
        final container = ProviderScope.containerOf(
            navigatorKey.currentContext!,
            listen: false);

        port.listen((dynamic data) async {
          String id = data[0];
          int status = data[1];
          int progress = data[2];

          final taskInfo = TaskInfo(
              status: DownloadTaskStatus.values[status], progress: progress);
          // 상태 업데이트
          // 여기서 나가는것은 id, status, progress 인데, 이것은 각각의 taskId를 뜻하는 것임.

          bool isSegmentDownloadComplete =
              taskInfo.status == DownloadTaskStatus.complete ||
              taskInfo.status == DownloadTaskStatus.enqueued;

          if (isSegmentDownloadComplete) {
            final downloadInformationList =
                container.read(progressProvider).downloadInformationList;
            bool found = false;
            for (var videoModel in downloadInformationList) {
              if (videoModel.taskStatus.containsKey(id)) {
                final updatedTaskStatus = {id: taskInfo};

                await container.read(progressProvider.notifier).updateDownloadQueue(
                    videoModel.id,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    updatedTaskStatus,
                    null,
                    null,
                    null);
              }
            }
            if (!found){
              retryUntilUpdated(id, taskInfo, container);
            }
          }
        });
      } else {}
    });
  });

  await FlutterDownloader.initialize(debug: true);
  FlutterDownloader.registerCallback(downloadCallback);
  runApp(const ProviderScope(child: MainApp()));
}

DateTime? lastSendTime;

void downloadCallback(String id, int status, int progress) {
  final SendPort? send =
      IsolateNameServer.lookupPortByName('downloader_send_port');
  send?.send([id, status, progress]);
}

Future<void> retryUntilUpdated(String id, TaskInfo taskInfo, ProviderContainer container) async {
  const retryInterval = Duration(milliseconds: 1000);
  const maxRetries = 5;

  int retries = 0;
  bool isUpdated = false;

  while (!isUpdated && retries <maxRetries) {
    final downloadInformationList = container.read(progressProvider).downloadInformationList;

    for (var videoModel in downloadInformationList) {
      if (videoModel.taskStatus.containsKey(id)) {
        final updatedTaskStatus = {id: taskInfo};
        await container.read(progressProvider.notifier).updateDownloadQueue(
          videoModel.id,
          null,
          null,
          null,
          null,
          null,
          null,
          updatedTaskStatus,
          null,
          null,
          null,
        );
        isUpdated = true;
        break;
      }
    }
    if (!isUpdated) {
      await Future.delayed(retryInterval);
      retries++;
    }
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: CustomThemeData.themeData,
    );
  }
}
