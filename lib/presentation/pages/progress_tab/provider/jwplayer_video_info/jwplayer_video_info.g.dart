// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jwplayer_video_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JwplayerVideoInfoImpl _$$JwplayerVideoInfoImplFromJson(
        Map<String, dynamic> json) =>
    _$JwplayerVideoInfoImpl(
      inputUrls: (json['inputUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      headers: (json['headers'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
    );

Map<String, dynamic> _$$JwplayerVideoInfoImplToJson(
        _$JwplayerVideoInfoImpl instance) =>
    <String, dynamic>{
      'inputUrls': instance.inputUrls,
      'headers': instance.headers,
    };
