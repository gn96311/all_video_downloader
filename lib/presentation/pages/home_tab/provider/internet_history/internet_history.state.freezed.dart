// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'internet_history.state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$InternetHistoryState {
  List<InternetHistoryModel> get historyList =>
      throw _privateConstructorUsedError;
  ErrorResponse get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InternetHistoryStateCopyWith<InternetHistoryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InternetHistoryStateCopyWith<$Res> {
  factory $InternetHistoryStateCopyWith(InternetHistoryState value,
          $Res Function(InternetHistoryState) then) =
      _$InternetHistoryStateCopyWithImpl<$Res, InternetHistoryState>;
  @useResult
  $Res call({List<InternetHistoryModel> historyList, ErrorResponse error});
}

/// @nodoc
class _$InternetHistoryStateCopyWithImpl<$Res,
        $Val extends InternetHistoryState>
    implements $InternetHistoryStateCopyWith<$Res> {
  _$InternetHistoryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? historyList = null,
    Object? error = null,
  }) {
    return _then(_value.copyWith(
      historyList: null == historyList
          ? _value.historyList
          : historyList // ignore: cast_nullable_to_non_nullable
              as List<InternetHistoryModel>,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ErrorResponse,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InternetHistoryStateImplCopyWith<$Res>
    implements $InternetHistoryStateCopyWith<$Res> {
  factory _$$InternetHistoryStateImplCopyWith(_$InternetHistoryStateImpl value,
          $Res Function(_$InternetHistoryStateImpl) then) =
      __$$InternetHistoryStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<InternetHistoryModel> historyList, ErrorResponse error});
}

/// @nodoc
class __$$InternetHistoryStateImplCopyWithImpl<$Res>
    extends _$InternetHistoryStateCopyWithImpl<$Res, _$InternetHistoryStateImpl>
    implements _$$InternetHistoryStateImplCopyWith<$Res> {
  __$$InternetHistoryStateImplCopyWithImpl(_$InternetHistoryStateImpl _value,
      $Res Function(_$InternetHistoryStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? historyList = null,
    Object? error = null,
  }) {
    return _then(_$InternetHistoryStateImpl(
      historyList: null == historyList
          ? _value._historyList
          : historyList // ignore: cast_nullable_to_non_nullable
              as List<InternetHistoryModel>,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ErrorResponse,
    ));
  }
}

/// @nodoc

class _$InternetHistoryStateImpl implements _InternetHistoryState {
  const _$InternetHistoryStateImpl(
      {final List<InternetHistoryModel> historyList =
          const <InternetHistoryModel>[],
      this.error = const ErrorResponse()})
      : _historyList = historyList;

  final List<InternetHistoryModel> _historyList;
  @override
  @JsonKey()
  List<InternetHistoryModel> get historyList {
    if (_historyList is EqualUnmodifiableListView) return _historyList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_historyList);
  }

  @override
  @JsonKey()
  final ErrorResponse error;

  @override
  String toString() {
    return 'InternetHistoryState(historyList: $historyList, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InternetHistoryStateImpl &&
            const DeepCollectionEquality()
                .equals(other._historyList, _historyList) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_historyList), error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InternetHistoryStateImplCopyWith<_$InternetHistoryStateImpl>
      get copyWith =>
          __$$InternetHistoryStateImplCopyWithImpl<_$InternetHistoryStateImpl>(
              this, _$identity);
}

abstract class _InternetHistoryState implements InternetHistoryState {
  const factory _InternetHistoryState(
      {final List<InternetHistoryModel> historyList,
      final ErrorResponse error}) = _$InternetHistoryStateImpl;

  @override
  List<InternetHistoryModel> get historyList;
  @override
  ErrorResponse get error;
  @override
  @JsonKey(ignore: true)
  _$$InternetHistoryStateImplCopyWith<_$InternetHistoryStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
