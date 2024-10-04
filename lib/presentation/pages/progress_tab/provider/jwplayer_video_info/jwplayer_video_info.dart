
import 'package:freezed_annotation/freezed_annotation.dart';

part 'jwplayer_video_info.freezed.dart';
part 'jwplayer_video_info.g.dart';

@freezed
class JwplayerVideoInfo with _$JwplayerVideoInfo {
  const factory JwplayerVideoInfo({
    @Default([]) List<String>? inputUrls,
    @Default({}) Map<String, String> headers,
  }) = _JwplayerVideoInfo;

  factory JwplayerVideoInfo.fromJson(Map<String, dynamic> json) => _$JwplayerVideoInfoFromJson(json);
}