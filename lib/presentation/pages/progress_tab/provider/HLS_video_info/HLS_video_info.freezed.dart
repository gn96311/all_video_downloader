// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'HLS_video_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HlsVideoInfo _$HlsVideoInfoFromJson(Map<String, dynamic> json) {
  return _HlsVideoInfo.fromJson(json);
}

/// @nodoc
mixin _$HlsVideoInfo {
  List<String>? get hlsUrls => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get thumbnail => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HlsVideoInfoCopyWith<HlsVideoInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HlsVideoInfoCopyWith<$Res> {
  factory $HlsVideoInfoCopyWith(
          HlsVideoInfo value, $Res Function(HlsVideoInfo) then) =
      _$HlsVideoInfoCopyWithImpl<$Res, HlsVideoInfo>;
  @useResult
  $Res call({List<String>? hlsUrls, String? title, String? thumbnail});
}

/// @nodoc
class _$HlsVideoInfoCopyWithImpl<$Res, $Val extends HlsVideoInfo>
    implements $HlsVideoInfoCopyWith<$Res> {
  _$HlsVideoInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hlsUrls = freezed,
    Object? title = freezed,
    Object? thumbnail = freezed,
  }) {
    return _then(_value.copyWith(
      hlsUrls: freezed == hlsUrls
          ? _value.hlsUrls
          : hlsUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnail: freezed == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HlsVideoInfoImplCopyWith<$Res>
    implements $HlsVideoInfoCopyWith<$Res> {
  factory _$$HlsVideoInfoImplCopyWith(
          _$HlsVideoInfoImpl value, $Res Function(_$HlsVideoInfoImpl) then) =
      __$$HlsVideoInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String>? hlsUrls, String? title, String? thumbnail});
}

/// @nodoc
class __$$HlsVideoInfoImplCopyWithImpl<$Res>
    extends _$HlsVideoInfoCopyWithImpl<$Res, _$HlsVideoInfoImpl>
    implements _$$HlsVideoInfoImplCopyWith<$Res> {
  __$$HlsVideoInfoImplCopyWithImpl(
      _$HlsVideoInfoImpl _value, $Res Function(_$HlsVideoInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hlsUrls = freezed,
    Object? title = freezed,
    Object? thumbnail = freezed,
  }) {
    return _then(_$HlsVideoInfoImpl(
      hlsUrls: freezed == hlsUrls
          ? _value._hlsUrls
          : hlsUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnail: freezed == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HlsVideoInfoImpl implements _HlsVideoInfo {
  const _$HlsVideoInfoImpl(
      {final List<String>? hlsUrls = const [],
      this.title = '',
      this.thumbnail = ''})
      : _hlsUrls = hlsUrls;

  factory _$HlsVideoInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$HlsVideoInfoImplFromJson(json);

  final List<String>? _hlsUrls;
  @override
  @JsonKey()
  List<String>? get hlsUrls {
    final value = _hlsUrls;
    if (value == null) return null;
    if (_hlsUrls is EqualUnmodifiableListView) return _hlsUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final String? title;
  @override
  @JsonKey()
  final String? thumbnail;

  @override
  String toString() {
    return 'HlsVideoInfo(hlsUrls: $hlsUrls, title: $title, thumbnail: $thumbnail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HlsVideoInfoImpl &&
            const DeepCollectionEquality().equals(other._hlsUrls, _hlsUrls) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_hlsUrls), title, thumbnail);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HlsVideoInfoImplCopyWith<_$HlsVideoInfoImpl> get copyWith =>
      __$$HlsVideoInfoImplCopyWithImpl<_$HlsVideoInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HlsVideoInfoImplToJson(
      this,
    );
  }
}

abstract class _HlsVideoInfo implements HlsVideoInfo {
  const factory _HlsVideoInfo(
      {final List<String>? hlsUrls,
      final String? title,
      final String? thumbnail}) = _$HlsVideoInfoImpl;

  factory _HlsVideoInfo.fromJson(Map<String, dynamic> json) =
      _$HlsVideoInfoImpl.fromJson;

  @override
  List<String>? get hlsUrls;
  @override
  String? get title;
  @override
  String? get thumbnail;
  @override
  @JsonKey(ignore: true)
  _$$HlsVideoInfoImplCopyWith<_$HlsVideoInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
