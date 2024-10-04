// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'internet_bookmark.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$InternetBookmarkModel {
  bool get isImportant => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get faviconPath => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get bookmarkId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InternetBookmarkModelCopyWith<InternetBookmarkModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InternetBookmarkModelCopyWith<$Res> {
  factory $InternetBookmarkModelCopyWith(InternetBookmarkModel value,
          $Res Function(InternetBookmarkModel) then) =
      _$InternetBookmarkModelCopyWithImpl<$Res, InternetBookmarkModel>;
  @useResult
  $Res call(
      {bool isImportant,
      String url,
      String faviconPath,
      String title,
      String bookmarkId});
}

/// @nodoc
class _$InternetBookmarkModelCopyWithImpl<$Res,
        $Val extends InternetBookmarkModel>
    implements $InternetBookmarkModelCopyWith<$Res> {
  _$InternetBookmarkModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isImportant = null,
    Object? url = null,
    Object? faviconPath = null,
    Object? title = null,
    Object? bookmarkId = null,
  }) {
    return _then(_value.copyWith(
      isImportant: null == isImportant
          ? _value.isImportant
          : isImportant // ignore: cast_nullable_to_non_nullable
              as bool,
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
      bookmarkId: null == bookmarkId
          ? _value.bookmarkId
          : bookmarkId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InternetBookmarkModelImplCopyWith<$Res>
    implements $InternetBookmarkModelCopyWith<$Res> {
  factory _$$InternetBookmarkModelImplCopyWith(
          _$InternetBookmarkModelImpl value,
          $Res Function(_$InternetBookmarkModelImpl) then) =
      __$$InternetBookmarkModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isImportant,
      String url,
      String faviconPath,
      String title,
      String bookmarkId});
}

/// @nodoc
class __$$InternetBookmarkModelImplCopyWithImpl<$Res>
    extends _$InternetBookmarkModelCopyWithImpl<$Res,
        _$InternetBookmarkModelImpl>
    implements _$$InternetBookmarkModelImplCopyWith<$Res> {
  __$$InternetBookmarkModelImplCopyWithImpl(_$InternetBookmarkModelImpl _value,
      $Res Function(_$InternetBookmarkModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isImportant = null,
    Object? url = null,
    Object? faviconPath = null,
    Object? title = null,
    Object? bookmarkId = null,
  }) {
    return _then(_$InternetBookmarkModelImpl(
      isImportant: null == isImportant
          ? _value.isImportant
          : isImportant // ignore: cast_nullable_to_non_nullable
              as bool,
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
      bookmarkId: null == bookmarkId
          ? _value.bookmarkId
          : bookmarkId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$InternetBookmarkModelImpl implements _InternetBookmarkModel {
  const _$InternetBookmarkModelImpl(
      {required this.isImportant,
      required this.url,
      required this.faviconPath,
      required this.title,
      required this.bookmarkId});

  @override
  final bool isImportant;
  @override
  final String url;
  @override
  final String faviconPath;
  @override
  final String title;
  @override
  final String bookmarkId;

  @override
  String toString() {
    return 'InternetBookmarkModel(isImportant: $isImportant, url: $url, faviconPath: $faviconPath, title: $title, bookmarkId: $bookmarkId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InternetBookmarkModelImpl &&
            (identical(other.isImportant, isImportant) ||
                other.isImportant == isImportant) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.faviconPath, faviconPath) ||
                other.faviconPath == faviconPath) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.bookmarkId, bookmarkId) ||
                other.bookmarkId == bookmarkId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, isImportant, url, faviconPath, title, bookmarkId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InternetBookmarkModelImplCopyWith<_$InternetBookmarkModelImpl>
      get copyWith => __$$InternetBookmarkModelImplCopyWithImpl<
          _$InternetBookmarkModelImpl>(this, _$identity);
}

abstract class _InternetBookmarkModel implements InternetBookmarkModel {
  const factory _InternetBookmarkModel(
      {required final bool isImportant,
      required final String url,
      required final String faviconPath,
      required final String title,
      required final String bookmarkId}) = _$InternetBookmarkModelImpl;

  @override
  bool get isImportant;
  @override
  String get url;
  @override
  String get faviconPath;
  @override
  String get title;
  @override
  String get bookmarkId;
  @override
  @JsonKey(ignore: true)
  _$$InternetBookmarkModelImplCopyWith<_$InternetBookmarkModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
