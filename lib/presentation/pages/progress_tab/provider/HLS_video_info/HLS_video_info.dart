
import 'package:freezed_annotation/freezed_annotation.dart';

part 'HLS_video_info.freezed.dart';
part 'HLS_video_info.g.dart';

@freezed
class HlsVideoInfo with _$HlsVideoInfo {
  const factory HlsVideoInfo({
    @Default([]) List<String>? hlsUrls,
    @Default('') String? title,
    @Default('') String? thumbnail,
  }) = _HlsVideoInfo;

  factory HlsVideoInfo.fromJson(Map<String, dynamic> json) => _$HlsVideoInfoFromJson(json);
}