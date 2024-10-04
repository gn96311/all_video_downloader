// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'internet_bookmark.state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$InternetBookmarkState {
  List<InternetBookmarkModel> get bookmarkList =>
      throw _privateConstructorUsedError;
  ErrorResponse get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InternetBookmarkStateCopyWith<InternetBookmarkState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InternetBookmarkStateCopyWith<$Res> {
  factory $InternetBookmarkStateCopyWith(InternetBookmarkState value,
          $Res Function(InternetBookmarkState) then) =
      _$InternetBookmarkStateCopyWithImpl<$Res, InternetBookmarkState>;
  @useResult
  $Res call({List<InternetBookmarkModel> bookmarkList, ErrorResponse error});
}

/// @nodoc
class _$InternetBookmarkStateCopyWithImpl<$Res,
        $Val extends InternetBookmarkState>
    implements $InternetBookmarkStateCopyWith<$Res> {
  _$InternetBookmarkStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookmarkList = null,
    Object? error = null,
  }) {
    return _then(_value.copyWith(
      bookmarkList: null == bookmarkList
          ? _value.bookmarkList
          : bookmarkList // ignore: cast_nullable_to_non_nullable
              as List<InternetBookmarkModel>,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ErrorResponse,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InternetBookmarkStateImplCopyWith<$Res>
    implements $InternetBookmarkStateCopyWith<$Res> {
  factory _$$InternetBookmarkStateImplCopyWith(
          _$InternetBookmarkStateImpl value,
          $Res Function(_$InternetBookmarkStateImpl) then) =
      __$$InternetBookmarkStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<InternetBookmarkModel> bookmarkList, ErrorResponse error});
}

/// @nodoc
class __$$InternetBookmarkStateImplCopyWithImpl<$Res>
    extends _$InternetBookmarkStateCopyWithImpl<$Res,
        _$InternetBookmarkStateImpl>
    implements _$$InternetBookmarkStateImplCopyWith<$Res> {
  __$$InternetBookmarkStateImplCopyWithImpl(_$InternetBookmarkStateImpl _value,
      $Res Function(_$InternetBookmarkStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookmarkList = null,
    Object? error = null,
  }) {
    return _then(_$InternetBookmarkStateImpl(
      bookmarkList: null == bookmarkList
          ? _value._bookmarkList
          : bookmarkList // ignore: cast_nullable_to_non_nullable
              as List<InternetBookmarkModel>,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ErrorResponse,
    ));
  }
}

/// @nodoc

class _$InternetBookmarkStateImpl implements _InternetBookmarkState {
  const _$InternetBookmarkStateImpl(
      {final List<InternetBookmarkModel> bookmarkList =
          const <InternetBookmarkModel>[],
      this.error = const ErrorResponse()})
      : _bookmarkList = bookmarkList;

  final List<InternetBookmarkModel> _bookmarkList;
  @override
  @JsonKey()
  List<InternetBookmarkModel> get bookmarkList {
    if (_bookmarkList is EqualUnmodifiableListView) return _bookmarkList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bookmarkList);
  }

  @override
  @JsonKey()
  final ErrorResponse error;

  @override
  String toString() {
    return 'InternetBookmarkState(bookmarkList: $bookmarkList, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InternetBookmarkStateImpl &&
            const DeepCollectionEquality()
                .equals(other._bookmarkList, _bookmarkList) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_bookmarkList), error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InternetBookmarkStateImplCopyWith<_$InternetBookmarkStateImpl>
      get copyWith => __$$InternetBookmarkStateImplCopyWithImpl<
          _$InternetBookmarkStateImpl>(this, _$identity);
}

abstract class _InternetBookmarkState implements InternetBookmarkState {
  const factory _InternetBookmarkState(
      {final List<InternetBookmarkModel> bookmarkList,
      final ErrorResponse error}) = _$InternetBookmarkStateImpl;

  @override
  List<InternetBookmarkModel> get bookmarkList;
  @override
  ErrorResponse get error;
  @override
  @JsonKey(ignore: true)
  _$$InternetBookmarkStateImplCopyWith<_$InternetBookmarkStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
