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
  Map<String, String?> get selectedUrls => throw _privateConstructorUsedError;
  Map<String, dynamic> get responseMap => throw _privateConstructorUsedError;
  Map<String, String> get headers => throw _privateConstructorUsedError;
  String get backgroundImageUrl => throw _privateConstructorUsedError;
  double get downloadedSized => throw _privateConstructorUsedError;
  double get downloadSpeed => throw _privateConstructorUsedError;
  double get downloadProgress => throw _privateConstructorUsedError;
  DownloadTaskStatus get downloadStatus => throw _privateConstructorUsedError;
  DateTime get modifiedTime => throw _privateConstructorUsedError;
  Map<String, TaskInfo> get taskStatus => throw _privateConstructorUsedError;
  String get saveDir => throw _privateConstructorUsedError;
  List<String> get segmentPaths => throw _privateConstructorUsedError;
  bool get isMerged => throw _privateConstructorUsedError;

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
      Map<String, String?> selectedUrls,
      Map<String, dynamic> responseMap,
      Map<String, String> headers,
      String backgroundImageUrl,
      double downloadedSized,
      double downloadSpeed,
      double downloadProgress,
      DownloadTaskStatus downloadStatus,
      DateTime modifiedTime,
      Map<String, TaskInfo> taskStatus,
      String saveDir,
      List<String> segmentPaths,
      bool isMerged});
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
    Object? selectedUrls = null,
    Object? responseMap = null,
    Object? headers = null,
    Object? backgroundImageUrl = null,
    Object? downloadedSized = null,
    Object? downloadSpeed = null,
    Object? downloadProgress = null,
    Object? downloadStatus = null,
    Object? modifiedTime = null,
    Object? taskStatus = null,
    Object? saveDir = null,
    Object? segmentPaths = null,
    Object? isMerged = null,
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
      selectedUrls: null == selectedUrls
          ? _value.selectedUrls
          : selectedUrls // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>,
      responseMap: null == responseMap
          ? _value.responseMap
          : responseMap // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      headers: null == headers
          ? _value.headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
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
      modifiedTime: null == modifiedTime
          ? _value.modifiedTime
          : modifiedTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      taskStatus: null == taskStatus
          ? _value.taskStatus
          : taskStatus // ignore: cast_nullable_to_non_nullable
              as Map<String, TaskInfo>,
      saveDir: null == saveDir
          ? _value.saveDir
          : saveDir // ignore: cast_nullable_to_non_nullable
              as String,
      segmentPaths: null == segmentPaths
          ? _value.segmentPaths
          : segmentPaths // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isMerged: null == isMerged
          ? _value.isMerged
          : isMerged // ignore: cast_nullable_to_non_nullable
              as bool,
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
      Map<String, String?> selectedUrls,
      Map<String, dynamic> responseMap,
      Map<String, String> headers,
      String backgroundImageUrl,
      double downloadedSized,
      double downloadSpeed,
      double downloadProgress,
      DownloadTaskStatus downloadStatus,
      DateTime modifiedTime,
      Map<String, TaskInfo> taskStatus,
      String saveDir,
      List<String> segmentPaths,
      bool isMerged});
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
    Object? selectedUrls = null,
    Object? responseMap = null,
    Object? headers = null,
    Object? backgroundImageUrl = null,
    Object? downloadedSized = null,
    Object? downloadSpeed = null,
    Object? downloadProgress = null,
    Object? downloadStatus = null,
    Object? modifiedTime = null,
    Object? taskStatus = null,
    Object? saveDir = null,
    Object? segmentPaths = null,
    Object? isMerged = null,
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
      selectedUrls: null == selectedUrls
          ? _value._selectedUrls
          : selectedUrls // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>,
      responseMap: null == responseMap
          ? _value._responseMap
          : responseMap // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      headers: null == headers
          ? _value._headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
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
      modifiedTime: null == modifiedTime
          ? _value.modifiedTime
          : modifiedTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      taskStatus: null == taskStatus
          ? _value._taskStatus
          : taskStatus // ignore: cast_nullable_to_non_nullable
              as Map<String, TaskInfo>,
      saveDir: null == saveDir
          ? _value.saveDir
          : saveDir // ignore: cast_nullable_to_non_nullable
              as String,
      segmentPaths: null == segmentPaths
          ? _value._segmentPaths
          : segmentPaths // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isMerged: null == isMerged
          ? _value.isMerged
          : isMerged // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$VideoDownloadModelImpl implements _VideoDownloadModel {
  const _$VideoDownloadModelImpl(
      {required this.id,
      required this.title,
      required final Map<String, String?> selectedUrls,
      required final Map<String, dynamic> responseMap,
      required final Map<String, String> headers,
      required this.backgroundImageUrl,
      required this.downloadedSized,
      required this.downloadSpeed,
      required this.downloadProgress,
      required this.downloadStatus,
      required this.modifiedTime,
      required final Map<String, TaskInfo> taskStatus,
      required this.saveDir,
      required final List<String> segmentPaths,
      required this.isMerged})
      : _selectedUrls = selectedUrls,
        _responseMap = responseMap,
        _headers = headers,
        _taskStatus = taskStatus,
        _segmentPaths = segmentPaths;

  @override
  final String id;
  @override
  final String title;
  final Map<String, String?> _selectedUrls;
  @override
  Map<String, String?> get selectedUrls {
    if (_selectedUrls is EqualUnmodifiableMapView) return _selectedUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_selectedUrls);
  }

  final Map<String, dynamic> _responseMap;
  @override
  Map<String, dynamic> get responseMap {
    if (_responseMap is EqualUnmodifiableMapView) return _responseMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_responseMap);
  }

  final Map<String, String> _headers;
  @override
  Map<String, String> get headers {
    if (_headers is EqualUnmodifiableMapView) return _headers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_headers);
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
  final DateTime modifiedTime;
  final Map<String, TaskInfo> _taskStatus;
  @override
  Map<String, TaskInfo> get taskStatus {
    if (_taskStatus is EqualUnmodifiableMapView) return _taskStatus;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_taskStatus);
  }

  @override
  final String saveDir;
  final List<String> _segmentPaths;
  @override
  List<String> get segmentPaths {
    if (_segmentPaths is EqualUnmodifiableListView) return _segmentPaths;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_segmentPaths);
  }

  @override
  final bool isMerged;

  @override
  String toString() {
    return 'VideoDownloadModel(id: $id, title: $title, selectedUrls: $selectedUrls, responseMap: $responseMap, headers: $headers, backgroundImageUrl: $backgroundImageUrl, downloadedSized: $downloadedSized, downloadSpeed: $downloadSpeed, downloadProgress: $downloadProgress, downloadStatus: $downloadStatus, modifiedTime: $modifiedTime, taskStatus: $taskStatus, saveDir: $saveDir, segmentPaths: $segmentPaths, isMerged: $isMerged)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoDownloadModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality()
                .equals(other._selectedUrls, _selectedUrls) &&
            const DeepCollectionEquality()
                .equals(other._responseMap, _responseMap) &&
            const DeepCollectionEquality().equals(other._headers, _headers) &&
            (identical(other.backgroundImageUrl, backgroundImageUrl) ||
                other.backgroundImageUrl == backgroundImageUrl) &&
            (identical(other.downloadedSized, downloadedSized) ||
                other.downloadedSized == downloadedSized) &&
            (identical(other.downloadSpeed, downloadSpeed) ||
                other.downloadSpeed == downloadSpeed) &&
            (identical(other.downloadProgress, downloadProgress) ||
                other.downloadProgress == downloadProgress) &&
            (identical(other.downloadStatus, downloadStatus) ||
                other.downloadStatus == downloadStatus) &&
            (identical(other.modifiedTime, modifiedTime) ||
                other.modifiedTime == modifiedTime) &&
            const DeepCollectionEquality()
                .equals(other._taskStatus, _taskStatus) &&
            (identical(other.saveDir, saveDir) || other.saveDir == saveDir) &&
            const DeepCollectionEquality()
                .equals(other._segmentPaths, _segmentPaths) &&
            (identical(other.isMerged, isMerged) ||
                other.isMerged == isMerged));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      const DeepCollectionEquality().hash(_selectedUrls),
      const DeepCollectionEquality().hash(_responseMap),
      const DeepCollectionEquality().hash(_headers),
      backgroundImageUrl,
      downloadedSized,
      downloadSpeed,
      downloadProgress,
      downloadStatus,
      modifiedTime,
      const DeepCollectionEquality().hash(_taskStatus),
      saveDir,
      const DeepCollectionEquality().hash(_segmentPaths),
      isMerged);

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
      required final Map<String, String?> selectedUrls,
      required final Map<String, dynamic> responseMap,
      required final Map<String, String> headers,
      required final String backgroundImageUrl,
      required final double downloadedSized,
      required final double downloadSpeed,
      required final double downloadProgress,
      required final DownloadTaskStatus downloadStatus,
      required final DateTime modifiedTime,
      required final Map<String, TaskInfo> taskStatus,
      required final String saveDir,
      required final List<String> segmentPaths,
      required final bool isMerged}) = _$VideoDownloadModelImpl;

  @override
  String get id;
  @override
  String get title;
  @override
  Map<String, String?> get selectedUrls;
  @override
  Map<String, dynamic> get responseMap;
  @override
  Map<String, String> get headers;
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
  DateTime get modifiedTime;
  @override
  Map<String, TaskInfo> get taskStatus;
  @override
  String get saveDir;
  @override
  List<String> get segmentPaths;
  @override
  bool get isMerged;
  @override
  @JsonKey(ignore: true)
  _$$VideoDownloadModelImplCopyWith<_$VideoDownloadModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
