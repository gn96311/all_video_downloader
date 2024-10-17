import 'package:all_video_downloader/data/remote/video_download.dart';
import 'package:all_video_downloader/domain/model/video_download/video_download_model.dart';
import 'package:all_video_downloader/presentation/pages/progress_tab/provider/video_download_progress/video_download_progress.provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DownloadManager{
  final VideoDownloadModel videoDownloadModel;
  WidgetRef ref;

  DownloadManager(this.videoDownloadModel, this.ref);

  Future<void> downloadAndMergeVideo() async {
    ref.read(VideoDownloadProgressProvider.notifier).updateDownloadQueue(videoDownloadModel.id, null, null, null, null, DownloadTaskStatus.enqueued);
    final selectedUrls = videoDownloadModel.selectedUrls;
    final responseMap = videoDownloadModel.responseMap;
    final headers = videoDownloadModel.headers;
    final title = videoDownloadModel.title;
    final selectedData = responseMap[selectedUrls['videoUrl']];

    final segmentUrls = RegExp(r'https?://[^\s]+').allMatches(selectedData).map((m) => m.group(0)!).toList();

    final segmentPaths = await downloadSegmentsFunction(videoDownloadModel.id, segmentUrls, title, headers, ref);

    await mergeSegments(segmentPaths, title);
  }
}