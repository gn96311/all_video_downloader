import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_download_model.freezed.dart';

@freezed
class VideoDownloadModel with _$VideoDownloadModel {
  const factory VideoDownloadModel({
    required String id,
    required String title,
    required Map<String, String?> selectedUrls,
    required Map<String, dynamic> responseMap,
    required Map<String, String> headers,
    required String backgroundImageUrl,
    required double downloadedSized,
    required double downloadSpeed,
    required double downloadProgress,
    required DownloadTaskStatus downloadStatus,
  }) = _VideoDownloadModel;
}