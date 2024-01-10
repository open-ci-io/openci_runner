// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'top.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Top _$TopFromJson(Map<String, dynamic> json) {
  return _Top.fromJson(json);
}

/// @nodoc
mixin _$Top {
  int get androidBuildNumber => throw _privateConstructorUsedError;
  List<String> get joinedOrgs => throw _privateConstructorUsedError;
  String? get selectedOrg => throw _privateConstructorUsedError;
  UserData? get userData => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TopCopyWith<Top> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopCopyWith<$Res> {
  factory $TopCopyWith(Top value, $Res Function(Top) then) =
      _$TopCopyWithImpl<$Res, Top>;
  @useResult
  $Res call(
      {int androidBuildNumber,
      List<String> joinedOrgs,
      String? selectedOrg,
      UserData? userData});

  $UserDataCopyWith<$Res>? get userData;
}

/// @nodoc
class _$TopCopyWithImpl<$Res, $Val extends Top> implements $TopCopyWith<$Res> {
  _$TopCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? androidBuildNumber = null,
    Object? joinedOrgs = null,
    Object? selectedOrg = freezed,
    Object? userData = freezed,
  }) {
    return _then(_value.copyWith(
      androidBuildNumber: null == androidBuildNumber
          ? _value.androidBuildNumber
          : androidBuildNumber // ignore: cast_nullable_to_non_nullable
              as int,
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
abstract class _$$TopImplCopyWith<$Res> implements $TopCopyWith<$Res> {
  factory _$$TopImplCopyWith(_$TopImpl value, $Res Function(_$TopImpl) then) =
      __$$TopImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int androidBuildNumber,
      List<String> joinedOrgs,
      String? selectedOrg,
      UserData? userData});

  @override
  $UserDataCopyWith<$Res>? get userData;
}

/// @nodoc
class __$$TopImplCopyWithImpl<$Res> extends _$TopCopyWithImpl<$Res, _$TopImpl>
    implements _$$TopImplCopyWith<$Res> {
  __$$TopImplCopyWithImpl(_$TopImpl _value, $Res Function(_$TopImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? androidBuildNumber = null,
    Object? joinedOrgs = null,
    Object? selectedOrg = freezed,
    Object? userData = freezed,
  }) {
    return _then(_$TopImpl(
      androidBuildNumber: null == androidBuildNumber
          ? _value.androidBuildNumber
          : androidBuildNumber // ignore: cast_nullable_to_non_nullable
              as int,
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
class _$TopImpl implements _Top {
  const _$TopImpl(
      {this.androidBuildNumber = 0,
      final List<String> joinedOrgs = const ['test', 'test2'],
      this.selectedOrg,
      this.userData})
      : _joinedOrgs = joinedOrgs;

  factory _$TopImpl.fromJson(Map<String, dynamic> json) =>
      _$$TopImplFromJson(json);

  @override
  @JsonKey()
  final int androidBuildNumber;
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
    return 'Top(androidBuildNumber: $androidBuildNumber, joinedOrgs: $joinedOrgs, selectedOrg: $selectedOrg, userData: $userData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TopImpl &&
            (identical(other.androidBuildNumber, androidBuildNumber) ||
                other.androidBuildNumber == androidBuildNumber) &&
            const DeepCollectionEquality()
                .equals(other._joinedOrgs, _joinedOrgs) &&
            (identical(other.selectedOrg, selectedOrg) ||
                other.selectedOrg == selectedOrg) &&
            (identical(other.userData, userData) ||
                other.userData == userData));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, androidBuildNumber,
      const DeepCollectionEquality().hash(_joinedOrgs), selectedOrg, userData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TopImplCopyWith<_$TopImpl> get copyWith =>
      __$$TopImplCopyWithImpl<_$TopImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TopImplToJson(
      this,
    );
  }
}

abstract class _Top implements Top {
  const factory _Top(
      {final int androidBuildNumber,
      final List<String> joinedOrgs,
      final String? selectedOrg,
      final UserData? userData}) = _$TopImpl;

  factory _Top.fromJson(Map<String, dynamic> json) = _$TopImpl.fromJson;

  @override
  int get androidBuildNumber;
  @override
  List<String> get joinedOrgs;
  @override
  String? get selectedOrg;
  @override
  UserData? get userData;
  @override
  @JsonKey(ignore: true)
  _$$TopImplCopyWith<_$TopImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
