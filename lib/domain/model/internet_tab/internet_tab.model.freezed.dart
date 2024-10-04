// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'internet_tab.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$InternetTabModel {
  String get tabId => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get faviconPath => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InternetTabModelCopyWith<InternetTabModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InternetTabModelCopyWith<$Res> {
  factory $InternetTabModelCopyWith(
          InternetTabModel value, $Res Function(InternetTabModel) then) =
      _$InternetTabModelCopyWithImpl<$Res, InternetTabModel>;
  @useResult
  $Res call({String tabId, String url, String faviconPath, String title});
}

/// @nodoc
class _$InternetTabModelCopyWithImpl<$Res, $Val extends InternetTabModel>
    implements $InternetTabModelCopyWith<$Res> {
  _$InternetTabModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tabId = null,
    Object? url = null,
    Object? faviconPath = null,
    Object? title = null,
  }) {
    return _then(_value.copyWith(
      tabId: null == tabId
          ? _value.tabId
          : tabId // ignore: cast_nullable_to_non_nullable
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
abstract class _$$InternetTabModelImplCopyWith<$Res>
    implements $InternetTabModelCopyWith<$Res> {
  factory _$$InternetTabModelImplCopyWith(_$InternetTabModelImpl value,
          $Res Function(_$InternetTabModelImpl) then) =
      __$$InternetTabModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String tabId, String url, String faviconPath, String title});
}

/// @nodoc
class __$$InternetTabModelImplCopyWithImpl<$Res>
    extends _$InternetTabModelCopyWithImpl<$Res, _$InternetTabModelImpl>
    implements _$$InternetTabModelImplCopyWith<$Res> {
  __$$InternetTabModelImplCopyWithImpl(_$InternetTabModelImpl _value,
      $Res Function(_$InternetTabModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tabId = null,
    Object? url = null,
    Object? faviconPath = null,
    Object? title = null,
  }) {
    return _then(_$InternetTabModelImpl(
      tabId: null == tabId
          ? _value.tabId
          : tabId // ignore: cast_nullable_to_non_nullable
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

class _$InternetTabModelImpl implements _InternetTabModel {
  const _$InternetTabModelImpl(
      {required this.tabId,
      required this.url,
      required this.faviconPath,
      required this.title});

  @override
  final String tabId;
  @override
  final String url;
  @override
  final String faviconPath;
  @override
  final String title;

  @override
  String toString() {
    return 'InternetTabModel(tabId: $tabId, url: $url, faviconPath: $faviconPath, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InternetTabModelImpl &&
            (identical(other.tabId, tabId) || other.tabId == tabId) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.faviconPath, faviconPath) ||
                other.faviconPath == faviconPath) &&
            (identical(other.title, title) || other.title == title));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tabId, url, faviconPath, title);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InternetTabModelImplCopyWith<_$InternetTabModelImpl> get copyWith =>
      __$$InternetTabModelImplCopyWithImpl<_$InternetTabModelImpl>(
          this, _$identity);
}

abstract class _InternetTabModel implements InternetTabModel {
  const factory _InternetTabModel(
      {required final String tabId,
      required final String url,
      required final String faviconPath,
      required final String title}) = _$InternetTabModelImpl;

  @override
  String get tabId;
  @override
  String get url;
  @override
  String get faviconPath;
  @override
  String get title;
  @override
  @JsonKey(ignore: true)
  _$$InternetTabModelImplCopyWith<_$InternetTabModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
