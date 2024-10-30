// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'progress_provider.state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProgressProviderState {
  List<VideoDownloadModel> get downloadInformationList =>
      throw _privateConstructorUsedError;
  bool get progressDownloading => throw _privateConstructorUsedError;
  ErrorResponse get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProgressProviderStateCopyWith<ProgressProviderState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgressProviderStateCopyWith<$Res> {
  factory $ProgressProviderStateCopyWith(ProgressProviderState value,
          $Res Function(ProgressProviderState) then) =
      _$ProgressProviderStateCopyWithImpl<$Res, ProgressProviderState>;
  @useResult
  $Res call(
      {List<VideoDownloadModel> downloadInformationList,
      bool progressDownloading,
      ErrorResponse error});
}

/// @nodoc
class _$ProgressProviderStateCopyWithImpl<$Res,
        $Val extends ProgressProviderState>
    implements $ProgressProviderStateCopyWith<$Res> {
  _$ProgressProviderStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? downloadInformationList = null,
    Object? progressDownloading = null,
    Object? error = null,
  }) {
    return _then(_value.copyWith(
      downloadInformationList: null == downloadInformationList
          ? _value.downloadInformationList
          : downloadInformationList // ignore: cast_nullable_to_non_nullable
              as List<VideoDownloadModel>,
      progressDownloading: null == progressDownloading
          ? _value.progressDownloading
          : progressDownloading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ErrorResponse,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProgressProviderStateImplCopyWith<$Res>
    implements $ProgressProviderStateCopyWith<$Res> {
  factory _$$ProgressProviderStateImplCopyWith(
          _$ProgressProviderStateImpl value,
          $Res Function(_$ProgressProviderStateImpl) then) =
      __$$ProgressProviderStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<VideoDownloadModel> downloadInformationList,
      bool progressDownloading,
      ErrorResponse error});
}

/// @nodoc
class __$$ProgressProviderStateImplCopyWithImpl<$Res>
    extends _$ProgressProviderStateCopyWithImpl<$Res,
        _$ProgressProviderStateImpl>
    implements _$$ProgressProviderStateImplCopyWith<$Res> {
  __$$ProgressProviderStateImplCopyWithImpl(_$ProgressProviderStateImpl _value,
      $Res Function(_$ProgressProviderStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? downloadInformationList = null,
    Object? progressDownloading = null,
    Object? error = null,
  }) {
    return _then(_$ProgressProviderStateImpl(
      downloadInformationList: null == downloadInformationList
          ? _value._downloadInformationList
          : downloadInformationList // ignore: cast_nullable_to_non_nullable
              as List<VideoDownloadModel>,
      progressDownloading: null == progressDownloading
          ? _value.progressDownloading
          : progressDownloading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ErrorResponse,
    ));
  }
}

/// @nodoc

class _$ProgressProviderStateImpl implements _ProgressProviderState {
  const _$ProgressProviderStateImpl(
      {final List<VideoDownloadModel> downloadInformationList =
          const <VideoDownloadModel>[],
      this.progressDownloading = false,
      this.error = const ErrorResponse()})
      : _downloadInformationList = downloadInformationList;

  final List<VideoDownloadModel> _downloadInformationList;
  @override
  @JsonKey()
  List<VideoDownloadModel> get downloadInformationList {
    if (_downloadInformationList is EqualUnmodifiableListView)
      return _downloadInformationList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_downloadInformationList);
  }

  @override
  @JsonKey()
  final bool progressDownloading;
  @override
  @JsonKey()
  final ErrorResponse error;

  @override
  String toString() {
    return 'ProgressProviderState(downloadInformationList: $downloadInformationList, progressDownloading: $progressDownloading, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProgressProviderStateImpl &&
            const DeepCollectionEquality().equals(
                other._downloadInformationList, _downloadInformationList) &&
            (identical(other.progressDownloading, progressDownloading) ||
                other.progressDownloading == progressDownloading) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_downloadInformationList),
      progressDownloading,
      error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProgressProviderStateImplCopyWith<_$ProgressProviderStateImpl>
      get copyWith => __$$ProgressProviderStateImplCopyWithImpl<
          _$ProgressProviderStateImpl>(this, _$identity);
}

abstract class _ProgressProviderState implements ProgressProviderState {
  const factory _ProgressProviderState(
      {final List<VideoDownloadModel> downloadInformationList,
      final bool progressDownloading,
      final ErrorResponse error}) = _$ProgressProviderStateImpl;

  @override
  List<VideoDownloadModel> get downloadInformationList;
  @override
  bool get progressDownloading;
  @override
  ErrorResponse get error;
  @override
  @JsonKey(ignore: true)
  _$$ProgressProviderStateImplCopyWith<_$ProgressProviderStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
