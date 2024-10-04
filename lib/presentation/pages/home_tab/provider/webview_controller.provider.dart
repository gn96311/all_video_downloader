import 'dart:convert';

import 'package:all_video_downloader/core/theme/constant/app_scripts.dart';
import 'package:all_video_downloader/presentation/pages/progress_tab/provider/video_info/video_info.dart';
import 'package:all_video_downloader/presentation/pages/progress_tab/provider/video_info/video_info.provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart' show rootBundle;

final webViewControllerProvider =
    StateProvider<InAppWebViewController?>((ref) => null);

final videoExtractionTriggerProvider = StateProvider<int>((ref) => 0);

final videoExtractionFutureProvider =
    FutureProvider<List<VideoInfo>>((ref) async {
  ref.watch(videoExtractionTriggerProvider);

  final controller = ref.read(webViewControllerProvider);
  if (controller == null) {
    return [];
  }

  try {
    String jsCode = await rootBundle.loadString(AppScripts.extractVideoInfo);
    String? result = await controller.evaluateJavascript(source: jsCode);

    if (result != null && result.isNotEmpty) {
      List<dynamic> jsonList = jsonDecode(result);
      List<VideoInfo> videoInfos =
          jsonList.map((item) => VideoInfo.fromJson(item)).toList();

      ref.read(videoInfoProvider.notifier).state = videoInfos;
      return videoInfos;
    }
  } catch (e) {
    debugPrint('비디오 추출 오류: $e');
  }
  return [];
});
