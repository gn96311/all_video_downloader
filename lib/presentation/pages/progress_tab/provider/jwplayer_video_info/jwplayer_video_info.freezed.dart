// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'jwplayer_video_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

JwplayerVideoInfo _$JwplayerVideoInfoFromJson(Map<String, dynamic> json) {
  return _JwplayerVideoInfo.fromJson(json);
}

/// @nodoc
mixin _$JwplayerVideoInfo {
  List<String>? get inputUrls => throw _privateConstructorUsedError;
  Map<String, String> get headers => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JwplayerVideoInfoCopyWith<JwplayerVideoInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JwplayerVideoInfoCopyWith<$Res> {
  factory $JwplayerVideoInfoCopyWith(
          JwplayerVideoInfo value, $Res Function(JwplayerVideoInfo) then) =
      _$JwplayerVideoInfoCopyWithImpl<$Res, JwplayerVideoInfo>;
  @useResult
  $Res call({List<String>? inputUrls, Map<String, String> headers});
}

/// @nodoc
class _$JwplayerVideoInfoCopyWithImpl<$Res, $Val extends JwplayerVideoInfo>
    implements $JwplayerVideoInfoCopyWith<$Res> {
  _$JwplayerVideoInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputUrls = freezed,
    Object? headers = null,
  }) {
    return _then(_value.copyWith(
      inputUrls: freezed == inputUrls
          ? _value.inputUrls
          : inputUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      headers: null == headers
          ? _value.headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$JwplayerVideoInfoImplCopyWith<$Res>
    implements $JwplayerVideoInfoCopyWith<$Res> {
  factory _$$JwplayerVideoInfoImplCopyWith(_$JwplayerVideoInfoImpl value,
          $Res Function(_$JwplayerVideoInfoImpl) then) =
      __$$JwplayerVideoInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String>? inputUrls, Map<String, String> headers});
}

/// @nodoc
class __$$JwplayerVideoInfoImplCopyWithImpl<$Res>
    extends _$JwplayerVideoInfoCopyWithImpl<$Res, _$JwplayerVideoInfoImpl>
    implements _$$JwplayerVideoInfoImplCopyWith<$Res> {
  __$$JwplayerVideoInfoImplCopyWithImpl(_$JwplayerVideoInfoImpl _value,
      $Res Function(_$JwplayerVideoInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputUrls = freezed,
    Object? headers = null,
  }) {
    return _then(_$JwplayerVideoInfoImpl(
      inputUrls: freezed == inputUrls
          ? _value._inputUrls
          : inputUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      headers: null == headers
          ? _value._headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$JwplayerVideoInfoImpl implements _JwplayerVideoInfo {
  const _$JwplayerVideoInfoImpl(
      {final List<String>? inputUrls = const [],
      final Map<String, String> headers = const {}})
      : _inputUrls = inputUrls,
        _headers = headers;

  factory _$JwplayerVideoInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$JwplayerVideoInfoImplFromJson(json);

  final List<String>? _inputUrls;
  @override
  @JsonKey()
  List<String>? get inputUrls {
    final value = _inputUrls;
    if (value == null) return null;
    if (_inputUrls is EqualUnmodifiableListView) return _inputUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, String> _headers;
  @override
  @JsonKey()
  Map<String, String> get headers {
    if (_headers is EqualUnmodifiableMapView) return _headers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_headers);
  }

  @override
  String toString() {
    return 'JwplayerVideoInfo(inputUrls: $inputUrls, headers: $headers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JwplayerVideoInfoImpl &&
            const DeepCollectionEquality()
                .equals(other._inputUrls, _inputUrls) &&
            const DeepCollectionEquality().equals(other._headers, _headers));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_inputUrls),
      const DeepCollectionEquality().hash(_headers));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JwplayerVideoInfoImplCopyWith<_$JwplayerVideoInfoImpl> get copyWith =>
      __$$JwplayerVideoInfoImplCopyWithImpl<_$JwplayerVideoInfoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JwplayerVideoInfoImplToJson(
      this,
    );
  }
}

abstract class _JwplayerVideoInfo implements JwplayerVideoInfo {
  const factory _JwplayerVideoInfo(
      {final List<String>? inputUrls,
      final Map<String, String> headers}) = _$JwplayerVideoInfoImpl;

  factory _JwplayerVideoInfo.fromJson(Map<String, dynamic> json) =
      _$JwplayerVideoInfoImpl.fromJson;

  @override
  List<String>? get inputUrls;
  @override
  Map<String, String> get headers;
  @override
  @JsonKey(ignore: true)
  _$$JwplayerVideoInfoImplCopyWith<_$JwplayerVideoInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
