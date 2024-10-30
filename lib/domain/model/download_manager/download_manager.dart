import 'dart:io';

import 'package:all_video_downloader/data/remote/flutter_donwloader.dart';
import 'package:all_video_downloader/domain/model/video_download/video_download_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

class DownloadManager{
  final VideoDownloadModel videoDownloadModel;
  WidgetRef ref;
  final String id;
  late final SegmentDownloader segmentDownloader;

  DownloadManager._(this.videoDownloadModel, this.ref, this.id, this.segmentDownloader);

  static Future<DownloadManager> create(
      VideoDownloadModel videoDownloadModel, WidgetRef ref, String id) async {

    final segmentDownloader = await _createSegmentDownloader(videoDownloadModel, ref, id);

    final manager = DownloadManager._(videoDownloadModel, ref, id, segmentDownloader);

    manager.segmentDownloader.startDownload();

    return manager;
  }

  static Future<SegmentDownloader> _createSegmentDownloader(
      VideoDownloadModel videoDownloadModel, WidgetRef ref, String id) async {
    final selectedUrls = videoDownloadModel.selectedUrls;
    final responseMap = videoDownloadModel.responseMap;
    final headers = videoDownloadModel.headers;
    final title = videoDownloadModel.title;
    final selectedData = responseMap[selectedUrls['videoUrl']];
    final segmentUrls = RegExp(r'https?://[^\s]+')
        .allMatches(selectedData)
        .map((m) => m.group(0)!)
        .toList();
    final directory = await getApplicationDocumentsDirectory();
    final segmentsDir = Directory('${directory.path}/downloadedSegments');
    if (!segmentsDir.existsSync()) {
      segmentsDir.createSync(recursive: true);
    }

    List<String> segmentPaths = [];
    Map<String, String> urlToSegmentPathMap = {};
    for (var url in segmentUrls) {
      final segmentName = url.split('/').last;
      final segmentNameWithNewExtension = '${segmentName.split('.').first}.ts';
      final segmentPath = '${segmentsDir.path}/$segmentNameWithNewExtension';
      segmentPaths.add(segmentPath);
      urlToSegmentPathMap[url] = segmentNameWithNewExtension;
    }

    // 저장 디렉토리 설정
    final saveDir = segmentsDir.path;

    return SegmentDownloader(
      downloadCompleterUUID: id,
      urlToSegmentPathMap: urlToSegmentPathMap,
      segmentPaths: segmentPaths,
      headers: headers,
      saveDir: saveDir,
      outputFileName: title,
      ref: ref,
    );
  }

  void pauseDownload() {
    segmentDownloader.pauseDownload();
  }

  void resumeDownload() {
    segmentDownloader.resumeDownload();
  }

  void cancelDownload() {
    segmentDownloader.cancelDownload();
  }
}