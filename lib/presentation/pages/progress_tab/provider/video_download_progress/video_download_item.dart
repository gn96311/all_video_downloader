import 'package:all_video_downloader/domain/model/download_manager/download_manager.dart';
import 'package:all_video_downloader/domain/model/video_download/video_download_model.dart';

class VideoDownloadItem {
  final VideoDownloadModel videoDownloadModel;
  final DownloadManager downloadManager;

  VideoDownloadItem({
    required this.videoDownloadModel,
    required this.downloadManager,
  });
}
