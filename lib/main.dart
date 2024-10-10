import 'dart:isolate';
import 'dart:ui';

import 'package:all_video_downloader/core/theme/theme_data.dart';
import 'package:all_video_downloader/data/entity/internet_bookmark.entity.dart';
import 'package:all_video_downloader/data/entity/internet_history.entity.dart';
import 'package:all_video_downloader/data/entity/internet_tab.entity.dart';
import 'package:all_video_downloader/data/remote/flutter_donwloader.dart';
import 'package:all_video_downloader/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

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
  await FlutterDownloader.initialize(debug: true);
  FlutterDownloader.registerCallback(downloadCallback);
  runApp(const ProviderScope(child: MainApp()));
}

void downloadCallback(String id, int status, int progress) {
  final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
  send?.send([id, status, progress]);
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
