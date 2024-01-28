// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'show_build_logs.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ShowBuildLogs _$ShowBuildLogsFromJson(Map<String, dynamic> json) {
  return _ShowBuildLogs.fromJson(json);
}

/// @nodoc
mixin _$ShowBuildLogs {
  List<String> get joinedOrgs => throw _privateConstructorUsedError;
  String? get selectedOrg => throw _privateConstructorUsedError;
  UserData? get userData => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShowBuildLogsCopyWith<ShowBuildLogs> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShowBuildLogsCopyWith<$Res> {
  factory $ShowBuildLogsCopyWith(
          ShowBuildLogs value, $Res Function(ShowBuildLogs) then) =
      _$ShowBuildLogsCopyWithImpl<$Res, ShowBuildLogs>;
  @useResult
  $Res call({List<String> joinedOrgs, String? selectedOrg, UserData? userData});

  $UserDataCopyWith<$Res>? get userData;
}

/// @nodoc
class _$ShowBuildLogsCopyWithImpl<$Res, $Val extends ShowBuildLogs>
    implements $ShowBuildLogsCopyWith<$Res> {
  _$ShowBuildLogsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? joinedOrgs = null,
    Object? selectedOrg = freezed,
    Object? userData = freezed,
  }) {
    return _then(_value.copyWith(
      joinedOrgs: null == joinedOrgs
          ? _value.joinedOrgs
          : joinedOrgs // ignore: cast_nullable_to_non_nullable
              as List<String>,
      selectedOrg: freezed == selectedOrg
          ? _value.selectedOrg
          : selectedOrg // ignore: cast_nullable_to_non_nullable
              as String?,
      userData: freezed == userData
          ? _value.userData
          : userData // ignore: cast_nullable_to_non_nullable
              as UserData?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserDataCopyWith<$Res>? get userData {
    if (_value.userData == null) {
      return null;
    }

    return $UserDataCopyWith<$Res>(_value.userData!, (value) {
      return _then(_value.copyWith(userData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ShowBuildLogsImplCopyWith<$Res>
    implements $ShowBuildLogsCopyWith<$Res> {
  factory _$$ShowBuildLogsImplCopyWith(
          _$ShowBuildLogsImpl value, $Res Function(_$ShowBuildLogsImpl) then) =
      __$$ShowBuildLogsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> joinedOrgs, String? selectedOrg, UserData? userData});

  @override
  $UserDataCopyWith<$Res>? get userData;
}

/// @nodoc
class __$$ShowBuildLogsImplCopyWithImpl<$Res>
    extends _$ShowBuildLogsCopyWithImpl<$Res, _$ShowBuildLogsImpl>
    implements _$$ShowBuildLogsImplCopyWith<$Res> {
  __$$ShowBuildLogsImplCopyWithImpl(
      _$ShowBuildLogsImpl _value, $Res Function(_$ShowBuildLogsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? joinedOrgs = null,
    Object? selectedOrg = freezed,
    Object? userData = freezed,
  }) {
    return _then(_$ShowBuildLogsImpl(
      joinedOrgs: null == joinedOrgs
          ? _value._joinedOrgs
          : joinedOrgs // ignore: cast_nullable_to_non_nullable
              as List<String>,
      selectedOrg: freezed == selectedOrg
          ? _value.selectedOrg
          : selectedOrg // ignore: cast_nullable_to_non_nullable
              as String?,
      userData: freezed == userData
          ? _value.userData
          : userData // ignore: cast_nullable_to_non_nullable
              as UserData?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShowBuildLogsImpl implements _ShowBuildLogs {
  const _$ShowBuildLogsImpl(
      {final List<String> joinedOrgs = const ['test', 'test2'],
      this.selectedOrg,
      this.userData})
      : _joinedOrgs = joinedOrgs;

  factory _$ShowBuildLogsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShowBuildLogsImplFromJson(json);

  final List<String> _joinedOrgs;
  @override
  @JsonKey()
  List<String> get joinedOrgs {
    if (_joinedOrgs is EqualUnmodifiableListView) return _joinedOrgs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_joinedOrgs);
  }

  @override
  final String? selectedOrg;
  @override
  final UserData? userData;

  @override
  String toString() {
    return 'ShowBuildLogs(joinedOrgs: $joinedOrgs, selectedOrg: $selectedOrg, userData: $userData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShowBuildLogsImpl &&
            const DeepCollectionEquality()
                .equals(other._joinedOrgs, _joinedOrgs) &&
            (identical(other.selectedOrg, selectedOrg) ||
                other.selectedOrg == selectedOrg) &&
            (identical(other.userData, userData) ||
                other.userData == userData));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_joinedOrgs), selectedOrg, userData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShowBuildLogsImplCopyWith<_$ShowBuildLogsImpl> get copyWith =>
      __$$ShowBuildLogsImplCopyWithImpl<_$ShowBuildLogsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShowBuildLogsImplToJson(
      this,
    );
  }
}

abstract class _ShowBuildLogs implements ShowBuildLogs {
  const factory _ShowBuildLogs(
      {final List<String> joinedOrgs,
      final String? selectedOrg,
      final UserData? userData}) = _$ShowBuildLogsImpl;

  factory _ShowBuildLogs.fromJson(Map<String, dynamic> json) =
      _$ShowBuildLogsImpl.fromJson;

  @override
  List<String> get joinedOrgs;
  @override
  String? get selectedOrg;
  @override
  UserData? get userData;
  @override
  @JsonKey(ignore: true)
  _$$ShowBuildLogsImplCopyWith<_$ShowBuildLogsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
