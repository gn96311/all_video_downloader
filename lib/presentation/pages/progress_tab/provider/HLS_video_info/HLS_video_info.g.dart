// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HLS_video_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HlsVideoInfoImpl _$$HlsVideoInfoImplFromJson(Map<String, dynamic> json) =>
    _$HlsVideoInfoImpl(
      hlsUrls: (json['hlsUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      title: json['title'] as String? ?? '',
    );

Map<String, dynamic> _$$HlsVideoInfoImplToJson(_$HlsVideoInfoImpl instance) =>
    <String, dynamic>{
      'hlsUrls': instance.hlsUrls,
      'title': instance.title,
    };
