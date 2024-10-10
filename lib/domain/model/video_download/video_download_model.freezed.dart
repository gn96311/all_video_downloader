// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_download_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$VideoDownloadModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  List<String> get segmentUrls => throw _privateConstructorUsedError;
  String get backgroundImageUrl => throw _privateConstructorUsedError;
  double get downloadedSized => throw _privateConstructorUsedError;
  double get downloadSpeed => throw _privateConstructorUsedError;
  double get downloadProgress => throw _privateConstructorUsedError;
  DownloadTaskStatus get downloadStatus => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $VideoDownloadModelCopyWith<VideoDownloadModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoDownloadModelCopyWith<$Res> {
  factory $VideoDownloadModelCopyWith(
          VideoDownloadModel value, $Res Function(VideoDownloadModel) then) =
      _$VideoDownloadModelCopyWithImpl<$Res, VideoDownloadModel>;
  @useResult
  $Res call(
      {String id,
      String title,
      List<String> segmentUrls,
      String backgroundImageUrl,
      double downloadedSized,
      double downloadSpeed,
      double downloadProgress,
      DownloadTaskStatus downloadStatus});
}

/// @nodoc
class _$VideoDownloadModelCopyWithImpl<$Res, $Val extends VideoDownloadModel>
    implements $VideoDownloadModelCopyWith<$Res> {
  _$VideoDownloadModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? segmentUrls = null,
    Object? backgroundImageUrl = null,
    Object? downloadedSized = null,
    Object? downloadSpeed = null,
    Object? downloadProgress = null,
    Object? downloadStatus = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      segmentUrls: null == segmentUrls
          ? _value.segmentUrls
          : segmentUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      backgroundImageUrl: null == backgroundImageUrl
          ? _value.backgroundImageUrl
          : backgroundImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      downloadedSized: null == downloadedSized
          ? _value.downloadedSized
          : downloadedSized // ignore: cast_nullable_to_non_nullable
              as double,
      downloadSpeed: null == downloadSpeed
          ? _value.downloadSpeed
          : downloadSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      downloadProgress: null == downloadProgress
          ? _value.downloadProgress
          : downloadProgress // ignore: cast_nullable_to_non_nullable
              as double,
      downloadStatus: null == downloadStatus
          ? _value.downloadStatus
          : downloadStatus // ignore: cast_nullable_to_non_nullable
              as DownloadTaskStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VideoDownloadModelImplCopyWith<$Res>
    implements $VideoDownloadModelCopyWith<$Res> {
  factory _$$VideoDownloadModelImplCopyWith(_$VideoDownloadModelImpl value,
          $Res Function(_$VideoDownloadModelImpl) then) =
      __$$VideoDownloadModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      List<String> segmentUrls,
      String backgroundImageUrl,
      double downloadedSized,
      double downloadSpeed,
      double downloadProgress,
      DownloadTaskStatus downloadStatus});
}

/// @nodoc
class __$$VideoDownloadModelImplCopyWithImpl<$Res>
    extends _$VideoDownloadModelCopyWithImpl<$Res, _$VideoDownloadModelImpl>
    implements _$$VideoDownloadModelImplCopyWith<$Res> {
  __$$VideoDownloadModelImplCopyWithImpl(_$VideoDownloadModelImpl _value,
      $Res Function(_$VideoDownloadModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? segmentUrls = null,
    Object? backgroundImageUrl = null,
    Object? downloadedSized = null,
    Object? downloadSpeed = null,
    Object? downloadProgress = null,
    Object? downloadStatus = null,
  }) {
    return _then(_$VideoDownloadModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      segmentUrls: null == segmentUrls
          ? _value._segmentUrls
          : segmentUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      backgroundImageUrl: null == backgroundImageUrl
          ? _value.backgroundImageUrl
          : backgroundImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      downloadedSized: null == downloadedSized
          ? _value.downloadedSized
          : downloadedSized // ignore: cast_nullable_to_non_nullable
              as double,
      downloadSpeed: null == downloadSpeed
          ? _value.downloadSpeed
          : downloadSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      downloadProgress: null == downloadProgress
          ? _value.downloadProgress
          : downloadProgress // ignore: cast_nullable_to_non_nullable
              as double,
      downloadStatus: null == downloadStatus
          ? _value.downloadStatus
          : downloadStatus // ignore: cast_nullable_to_non_nullable
              as DownloadTaskStatus,
    ));
  }
}

/// @nodoc

class _$VideoDownloadModelImpl implements _VideoDownloadModel {
  const _$VideoDownloadModelImpl(
      {required this.id,
      required this.title,
      required final List<String> segmentUrls,
      required this.backgroundImageUrl,
      required this.downloadedSized,
      required this.downloadSpeed,
      required this.downloadProgress,
      required this.downloadStatus})
      : _segmentUrls = segmentUrls;

  @override
  final String id;
  @override
  final String title;
  final List<String> _segmentUrls;
  @override
  List<String> get segmentUrls {
    if (_segmentUrls is EqualUnmodifiableListView) return _segmentUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_segmentUrls);
  }

  @override
  final String backgroundImageUrl;
  @override
  final double downloadedSized;
  @override
  final double downloadSpeed;
  @override
  final double downloadProgress;
  @override
  final DownloadTaskStatus downloadStatus;

  @override
  String toString() {
    return 'VideoDownloadModel(id: $id, title: $title, segmentUrls: $segmentUrls, backgroundImageUrl: $backgroundImageUrl, downloadedSized: $downloadedSized, downloadSpeed: $downloadSpeed, downloadProgress: $downloadProgress, downloadStatus: $downloadStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoDownloadModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality()
                .equals(other._segmentUrls, _segmentUrls) &&
            (identical(other.backgroundImageUrl, backgroundImageUrl) ||
                other.backgroundImageUrl == backgroundImageUrl) &&
            (identical(other.downloadedSized, downloadedSized) ||
                other.downloadedSized == downloadedSized) &&
            (identical(other.downloadSpeed, downloadSpeed) ||
                other.downloadSpeed == downloadSpeed) &&
            (identical(other.downloadProgress, downloadProgress) ||
                other.downloadProgress == downloadProgress) &&
            (identical(other.downloadStatus, downloadStatus) ||
                other.downloadStatus == downloadStatus));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      const DeepCollectionEquality().hash(_segmentUrls),
      backgroundImageUrl,
      downloadedSized,
      downloadSpeed,
      downloadProgress,
      downloadStatus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoDownloadModelImplCopyWith<_$VideoDownloadModelImpl> get copyWith =>
      __$$VideoDownloadModelImplCopyWithImpl<_$VideoDownloadModelImpl>(
          this, _$identity);
}

abstract class _VideoDownloadModel implements VideoDownloadModel {
  const factory _VideoDownloadModel(
          {required final String id,
          required final String title,
          required final List<String> segmentUrls,
          required final String backgroundImageUrl,
          required final double downloadedSized,
          required final double downloadSpeed,
          required final double downloadProgress,
          required final DownloadTaskStatus downloadStatus}) =
      _$VideoDownloadModelImpl;

  @override
  String get id;
  @override
  String get title;
  @override
  List<String> get segmentUrls;
  @override
  String get backgroundImageUrl;
  @override
  double get downloadedSized;
  @override
  double get downloadSpeed;
  @override
  double get downloadProgress;
  @override
  DownloadTaskStatus get downloadStatus;
  @override
  @JsonKey(ignore: true)
  _$$VideoDownloadModelImplCopyWith<_$VideoDownloadModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
