// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'internet_history.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$InternetHistoryModel {
  String get VisitedTime => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get faviconPath => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InternetHistoryModelCopyWith<InternetHistoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InternetHistoryModelCopyWith<$Res> {
  factory $InternetHistoryModelCopyWith(InternetHistoryModel value,
          $Res Function(InternetHistoryModel) then) =
      _$InternetHistoryModelCopyWithImpl<$Res, InternetHistoryModel>;
  @useResult
  $Res call({String VisitedTime, String url, String faviconPath, String title});
}

/// @nodoc
class _$InternetHistoryModelCopyWithImpl<$Res,
        $Val extends InternetHistoryModel>
    implements $InternetHistoryModelCopyWith<$Res> {
  _$InternetHistoryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? VisitedTime = null,
    Object? url = null,
    Object? faviconPath = null,
    Object? title = null,
  }) {
    return _then(_value.copyWith(
      VisitedTime: null == VisitedTime
          ? _value.VisitedTime
          : VisitedTime // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      faviconPath: null == faviconPath
          ? _value.faviconPath
          : faviconPath // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InternetHistoryModelImplCopyWith<$Res>
    implements $InternetHistoryModelCopyWith<$Res> {
  factory _$$InternetHistoryModelImplCopyWith(_$InternetHistoryModelImpl value,
          $Res Function(_$InternetHistoryModelImpl) then) =
      __$$InternetHistoryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String VisitedTime, String url, String faviconPath, String title});
}

/// @nodoc
class __$$InternetHistoryModelImplCopyWithImpl<$Res>
    extends _$InternetHistoryModelCopyWithImpl<$Res, _$InternetHistoryModelImpl>
    implements _$$InternetHistoryModelImplCopyWith<$Res> {
  __$$InternetHistoryModelImplCopyWithImpl(_$InternetHistoryModelImpl _value,
      $Res Function(_$InternetHistoryModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? VisitedTime = null,
    Object? url = null,
    Object? faviconPath = null,
    Object? title = null,
  }) {
    return _then(_$InternetHistoryModelImpl(
      VisitedTime: null == VisitedTime
          ? _value.VisitedTime
          : VisitedTime // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      faviconPath: null == faviconPath
          ? _value.faviconPath
          : faviconPath // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$InternetHistoryModelImpl implements _InternetHistoryModel {
  const _$InternetHistoryModelImpl(
      {required this.VisitedTime,
      required this.url,
      required this.faviconPath,
      required this.title});

  @override
  final String VisitedTime;
  @override
  final String url;
  @override
  final String faviconPath;
  @override
  final String title;

  @override
  String toString() {
    return 'InternetHistoryModel(VisitedTime: $VisitedTime, url: $url, faviconPath: $faviconPath, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InternetHistoryModelImpl &&
            (identical(other.VisitedTime, VisitedTime) ||
                other.VisitedTime == VisitedTime) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.faviconPath, faviconPath) ||
                other.faviconPath == faviconPath) &&
            (identical(other.title, title) || other.title == title));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, VisitedTime, url, faviconPath, title);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InternetHistoryModelImplCopyWith<_$InternetHistoryModelImpl>
      get copyWith =>
          __$$InternetHistoryModelImplCopyWithImpl<_$InternetHistoryModelImpl>(
              this, _$identity);
}

abstract class _InternetHistoryModel implements InternetHistoryModel {
  const factory _InternetHistoryModel(
      {required final String VisitedTime,
      required final String url,
      required final String faviconPath,
      required final String title}) = _$InternetHistoryModelImpl;

  @override
  String get VisitedTime;
  @override
  String get url;
  @override
  String get faviconPath;
  @override
  String get title;
  @override
  @JsonKey(ignore: true)
  _$$InternetHistoryModelImplCopyWith<_$InternetHistoryModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
