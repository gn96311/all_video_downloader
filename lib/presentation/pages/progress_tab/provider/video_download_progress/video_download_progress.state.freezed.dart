// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_download_progress.state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$VideoDownloadProgressState {
  Map<String, VideoDownloadItem> get downloadItems =>
      throw _privateConstructorUsedError;
  ErrorResponse get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $VideoDownloadProgressStateCopyWith<VideoDownloadProgressState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoDownloadProgressStateCopyWith<$Res> {
  factory $VideoDownloadProgressStateCopyWith(VideoDownloadProgressState value,
          $Res Function(VideoDownloadProgressState) then) =
      _$VideoDownloadProgressStateCopyWithImpl<$Res,
          VideoDownloadProgressState>;
  @useResult
  $Res call(
      {Map<String, VideoDownloadItem> downloadItems, ErrorResponse error});
}

/// @nodoc
class _$VideoDownloadProgressStateCopyWithImpl<$Res,
        $Val extends VideoDownloadProgressState>
    implements $VideoDownloadProgressStateCopyWith<$Res> {
  _$VideoDownloadProgressStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? downloadItems = null,
    Object? error = null,
  }) {
    return _then(_value.copyWith(
      downloadItems: null == downloadItems
          ? _value.downloadItems
          : downloadItems // ignore: cast_nullable_to_non_nullable
              as Map<String, VideoDownloadItem>,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ErrorResponse,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VideoDownloadProgressStateImplCopyWith<$Res>
    implements $VideoDownloadProgressStateCopyWith<$Res> {
  factory _$$VideoDownloadProgressStateImplCopyWith(
          _$VideoDownloadProgressStateImpl value,
          $Res Function(_$VideoDownloadProgressStateImpl) then) =
      __$$VideoDownloadProgressStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, VideoDownloadItem> downloadItems, ErrorResponse error});
}

/// @nodoc
class __$$VideoDownloadProgressStateImplCopyWithImpl<$Res>
    extends _$VideoDownloadProgressStateCopyWithImpl<$Res,
        _$VideoDownloadProgressStateImpl>
    implements _$$VideoDownloadProgressStateImplCopyWith<$Res> {
  __$$VideoDownloadProgressStateImplCopyWithImpl(
      _$VideoDownloadProgressStateImpl _value,
      $Res Function(_$VideoDownloadProgressStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? downloadItems = null,
    Object? error = null,
  }) {
    return _then(_$VideoDownloadProgressStateImpl(
      downloadItems: null == downloadItems
          ? _value._downloadItems
          : downloadItems // ignore: cast_nullable_to_non_nullable
              as Map<String, VideoDownloadItem>,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ErrorResponse,
    ));
  }
}

/// @nodoc

class _$VideoDownloadProgressStateImpl implements _VideoDownloadProgressState {
  const _$VideoDownloadProgressStateImpl(
      {final Map<String, VideoDownloadItem> downloadItems =
          const <String, VideoDownloadItem>{},
      this.error = const ErrorResponse()})
      : _downloadItems = downloadItems;

  final Map<String, VideoDownloadItem> _downloadItems;
  @override
  @JsonKey()
  Map<String, VideoDownloadItem> get downloadItems {
    if (_downloadItems is EqualUnmodifiableMapView) return _downloadItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_downloadItems);
  }

  @override
  @JsonKey()
  final ErrorResponse error;

  @override
  String toString() {
    return 'VideoDownloadProgressState(downloadItems: $downloadItems, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoDownloadProgressStateImpl &&
            const DeepCollectionEquality()
                .equals(other._downloadItems, _downloadItems) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_downloadItems), error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoDownloadProgressStateImplCopyWith<_$VideoDownloadProgressStateImpl>
      get copyWith => __$$VideoDownloadProgressStateImplCopyWithImpl<
          _$VideoDownloadProgressStateImpl>(this, _$identity);
}

abstract class _VideoDownloadProgressState
    implements VideoDownloadProgressState {
  const factory _VideoDownloadProgressState(
      {final Map<String, VideoDownloadItem> downloadItems,
      final ErrorResponse error}) = _$VideoDownloadProgressStateImpl;

  @override
  Map<String, VideoDownloadItem> get downloadItems;
  @override
  ErrorResponse get error;
  @override
  @JsonKey(ignore: true)
  _$$VideoDownloadProgressStateImplCopyWith<_$VideoDownloadProgressStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
