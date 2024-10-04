// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'internet_tab.state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$InternetTabState {
  List<InternetTabModel> get tabList => throw _privateConstructorUsedError;
  ErrorResponse get error => throw _privateConstructorUsedError;
  String? get currentTabId => throw _privateConstructorUsedError;
  String? get currentUrl => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InternetTabStateCopyWith<InternetTabState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InternetTabStateCopyWith<$Res> {
  factory $InternetTabStateCopyWith(
          InternetTabState value, $Res Function(InternetTabState) then) =
      _$InternetTabStateCopyWithImpl<$Res, InternetTabState>;
  @useResult
  $Res call(
      {List<InternetTabModel> tabList,
      ErrorResponse error,
      String? currentTabId,
      String? currentUrl});
}

/// @nodoc
class _$InternetTabStateCopyWithImpl<$Res, $Val extends InternetTabState>
    implements $InternetTabStateCopyWith<$Res> {
  _$InternetTabStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tabList = null,
    Object? error = null,
    Object? currentTabId = freezed,
    Object? currentUrl = freezed,
  }) {
    return _then(_value.copyWith(
      tabList: null == tabList
          ? _value.tabList
          : tabList // ignore: cast_nullable_to_non_nullable
              as List<InternetTabModel>,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ErrorResponse,
      currentTabId: freezed == currentTabId
          ? _value.currentTabId
          : currentTabId // ignore: cast_nullable_to_non_nullable
              as String?,
      currentUrl: freezed == currentUrl
          ? _value.currentUrl
          : currentUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InternetTabStateImplCopyWith<$Res>
    implements $InternetTabStateCopyWith<$Res> {
  factory _$$InternetTabStateImplCopyWith(_$InternetTabStateImpl value,
          $Res Function(_$InternetTabStateImpl) then) =
      __$$InternetTabStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<InternetTabModel> tabList,
      ErrorResponse error,
      String? currentTabId,
      String? currentUrl});
}

/// @nodoc
class __$$InternetTabStateImplCopyWithImpl<$Res>
    extends _$InternetTabStateCopyWithImpl<$Res, _$InternetTabStateImpl>
    implements _$$InternetTabStateImplCopyWith<$Res> {
  __$$InternetTabStateImplCopyWithImpl(_$InternetTabStateImpl _value,
      $Res Function(_$InternetTabStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tabList = null,
    Object? error = null,
    Object? currentTabId = freezed,
    Object? currentUrl = freezed,
  }) {
    return _then(_$InternetTabStateImpl(
      tabList: null == tabList
          ? _value._tabList
          : tabList // ignore: cast_nullable_to_non_nullable
              as List<InternetTabModel>,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ErrorResponse,
      currentTabId: freezed == currentTabId
          ? _value.currentTabId
          : currentTabId // ignore: cast_nullable_to_non_nullable
              as String?,
      currentUrl: freezed == currentUrl
          ? _value.currentUrl
          : currentUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$InternetTabStateImpl implements _InternetTabState {
  const _$InternetTabStateImpl(
      {final List<InternetTabModel> tabList = const <InternetTabModel>[],
      this.error = const ErrorResponse(),
      this.currentTabId,
      this.currentUrl})
      : _tabList = tabList;

  final List<InternetTabModel> _tabList;
  @override
  @JsonKey()
  List<InternetTabModel> get tabList {
    if (_tabList is EqualUnmodifiableListView) return _tabList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tabList);
  }

  @override
  @JsonKey()
  final ErrorResponse error;
  @override
  final String? currentTabId;
  @override
  final String? currentUrl;

  @override
  String toString() {
    return 'InternetTabState(tabList: $tabList, error: $error, currentTabId: $currentTabId, currentUrl: $currentUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InternetTabStateImpl &&
            const DeepCollectionEquality().equals(other._tabList, _tabList) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.currentTabId, currentTabId) ||
                other.currentTabId == currentTabId) &&
            (identical(other.currentUrl, currentUrl) ||
                other.currentUrl == currentUrl));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_tabList),
      error,
      currentTabId,
      currentUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InternetTabStateImplCopyWith<_$InternetTabStateImpl> get copyWith =>
      __$$InternetTabStateImplCopyWithImpl<_$InternetTabStateImpl>(
          this, _$identity);
}

abstract class _InternetTabState implements InternetTabState {
  const factory _InternetTabState(
      {final List<InternetTabModel> tabList,
      final ErrorResponse error,
      final String? currentTabId,
      final String? currentUrl}) = _$InternetTabStateImpl;

  @override
  List<InternetTabModel> get tabList;
  @override
  ErrorResponse get error;
  @override
  String? get currentTabId;
  @override
  String? get currentUrl;
  @override
  @JsonKey(ignore: true)
  _$$InternetTabStateImplCopyWith<_$InternetTabStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
