// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

JobData _$JobDataFromJson(Map<String, dynamic> json) {
  return _JobData.fromJson(json);
}

/// @nodoc
mixin _$JobData {
  int get id => throw _privateConstructorUsedError;
  String get build_branch => throw _privateConstructorUsedError;
  String get user_id => throw _privateConstructorUsedError;
  String get github_repository_url => throw _privateConstructorUsedError;
  String get base_branch => throw _privateConstructorUsedError;
  String get github_personal_access_token => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JobDataCopyWith<JobData> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JobDataCopyWith<$Res> {
  factory $JobDataCopyWith(JobData value, $Res Function(JobData) then) =
      _$JobDataCopyWithImpl<$Res, JobData>;
  @useResult
  $Res call(
      {int id,
      String build_branch,
      String user_id,
      String github_repository_url,
      String base_branch,
      String github_personal_access_token});
}

/// @nodoc
class _$JobDataCopyWithImpl<$Res, $Val extends JobData>
    implements $JobDataCopyWith<$Res> {
  _$JobDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? build_branch = null,
    Object? user_id = null,
    Object? github_repository_url = null,
    Object? base_branch = null,
    Object? github_personal_access_token = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      build_branch: null == build_branch
          ? _value.build_branch
          : build_branch // ignore: cast_nullable_to_non_nullable
              as String,
      user_id: null == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String,
      github_repository_url: null == github_repository_url
          ? _value.github_repository_url
          : github_repository_url // ignore: cast_nullable_to_non_nullable
              as String,
      base_branch: null == base_branch
          ? _value.base_branch
          : base_branch // ignore: cast_nullable_to_non_nullable
              as String,
      github_personal_access_token: null == github_personal_access_token
          ? _value.github_personal_access_token
          : github_personal_access_token // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$JobDataImplCopyWith<$Res> implements $JobDataCopyWith<$Res> {
  factory _$$JobDataImplCopyWith(
          _$JobDataImpl value, $Res Function(_$JobDataImpl) then) =
      __$$JobDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String build_branch,
      String user_id,
      String github_repository_url,
      String base_branch,
      String github_personal_access_token});
}

/// @nodoc
class __$$JobDataImplCopyWithImpl<$Res>
    extends _$JobDataCopyWithImpl<$Res, _$JobDataImpl>
    implements _$$JobDataImplCopyWith<$Res> {
  __$$JobDataImplCopyWithImpl(
      _$JobDataImpl _value, $Res Function(_$JobDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? build_branch = null,
    Object? user_id = null,
    Object? github_repository_url = null,
    Object? base_branch = null,
    Object? github_personal_access_token = null,
  }) {
    return _then(_$JobDataImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      build_branch: null == build_branch
          ? _value.build_branch
          : build_branch // ignore: cast_nullable_to_non_nullable
              as String,
      user_id: null == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String,
      github_repository_url: null == github_repository_url
          ? _value.github_repository_url
          : github_repository_url // ignore: cast_nullable_to_non_nullable
              as String,
      base_branch: null == base_branch
          ? _value.base_branch
          : base_branch // ignore: cast_nullable_to_non_nullable
              as String,
      github_personal_access_token: null == github_personal_access_token
          ? _value.github_personal_access_token
          : github_personal_access_token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$JobDataImpl implements _JobData {
  const _$JobDataImpl(
      {required this.id,
      required this.build_branch,
      required this.user_id,
      required this.github_repository_url,
      required this.base_branch,
      required this.github_personal_access_token});

  factory _$JobDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$JobDataImplFromJson(json);

  @override
  final int id;
  @override
  final String build_branch;
  @override
  final String user_id;
  @override
  final String github_repository_url;
  @override
  final String base_branch;
  @override
  final String github_personal_access_token;

  @override
  String toString() {
    return 'JobData(id: $id, build_branch: $build_branch, user_id: $user_id, github_repository_url: $github_repository_url, base_branch: $base_branch, github_personal_access_token: $github_personal_access_token)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JobDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.build_branch, build_branch) ||
                other.build_branch == build_branch) &&
            (identical(other.user_id, user_id) || other.user_id == user_id) &&
            (identical(other.github_repository_url, github_repository_url) ||
                other.github_repository_url == github_repository_url) &&
            (identical(other.base_branch, base_branch) ||
                other.base_branch == base_branch) &&
            (identical(other.github_personal_access_token,
                    github_personal_access_token) ||
                other.github_personal_access_token ==
                    github_personal_access_token));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, build_branch, user_id,
      github_repository_url, base_branch, github_personal_access_token);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JobDataImplCopyWith<_$JobDataImpl> get copyWith =>
      __$$JobDataImplCopyWithImpl<_$JobDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JobDataImplToJson(
      this,
    );
  }
}

abstract class _JobData implements JobData {
  const factory _JobData(
      {required final int id,
      required final String build_branch,
      required final String user_id,
      required final String github_repository_url,
      required final String base_branch,
      required final String github_personal_access_token}) = _$JobDataImpl;

  factory _JobData.fromJson(Map<String, dynamic> json) = _$JobDataImpl.fromJson;

  @override
  int get id;
  @override
  String get build_branch;
  @override
  String get user_id;
  @override
  String get github_repository_url;
  @override
  String get base_branch;
  @override
  String get github_personal_access_token;
  @override
  @JsonKey(ignore: true)
  _$$JobDataImplCopyWith<_$JobDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
