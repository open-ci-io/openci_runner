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
  String get buildBranch => throw _privateConstructorUsedError;
  String get documentId => throw _privateConstructorUsedError;
  String get githubRepositoryUrl => throw _privateConstructorUsedError;
  String get baseBranch => throw _privateConstructorUsedError;
  String get githubPAT => throw _privateConstructorUsedError;

  ///
  TargetPlatform get platform => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;

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
      {String buildBranch,
      String documentId,
      String githubRepositoryUrl,
      String baseBranch,
      String githubPAT,
      TargetPlatform platform,
      String userId});
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
    Object? buildBranch = null,
    Object? documentId = null,
    Object? githubRepositoryUrl = null,
    Object? baseBranch = null,
    Object? githubPAT = null,
    Object? platform = null,
    Object? userId = null,
  }) {
    return _then(_value.copyWith(
      buildBranch: null == buildBranch
          ? _value.buildBranch
          : buildBranch // ignore: cast_nullable_to_non_nullable
              as String,
      documentId: null == documentId
          ? _value.documentId
          : documentId // ignore: cast_nullable_to_non_nullable
              as String,
      githubRepositoryUrl: null == githubRepositoryUrl
          ? _value.githubRepositoryUrl
          : githubRepositoryUrl // ignore: cast_nullable_to_non_nullable
              as String,
      baseBranch: null == baseBranch
          ? _value.baseBranch
          : baseBranch // ignore: cast_nullable_to_non_nullable
              as String,
      githubPAT: null == githubPAT
          ? _value.githubPAT
          : githubPAT // ignore: cast_nullable_to_non_nullable
              as String,
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as TargetPlatform,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
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
      {String buildBranch,
      String documentId,
      String githubRepositoryUrl,
      String baseBranch,
      String githubPAT,
      TargetPlatform platform,
      String userId});
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
    Object? buildBranch = null,
    Object? documentId = null,
    Object? githubRepositoryUrl = null,
    Object? baseBranch = null,
    Object? githubPAT = null,
    Object? platform = null,
    Object? userId = null,
  }) {
    return _then(_$JobDataImpl(
      buildBranch: null == buildBranch
          ? _value.buildBranch
          : buildBranch // ignore: cast_nullable_to_non_nullable
              as String,
      documentId: null == documentId
          ? _value.documentId
          : documentId // ignore: cast_nullable_to_non_nullable
              as String,
      githubRepositoryUrl: null == githubRepositoryUrl
          ? _value.githubRepositoryUrl
          : githubRepositoryUrl // ignore: cast_nullable_to_non_nullable
              as String,
      baseBranch: null == baseBranch
          ? _value.baseBranch
          : baseBranch // ignore: cast_nullable_to_non_nullable
              as String,
      githubPAT: null == githubPAT
          ? _value.githubPAT
          : githubPAT // ignore: cast_nullable_to_non_nullable
              as String,
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as TargetPlatform,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$JobDataImpl implements _JobData {
  const _$JobDataImpl(
      {required this.buildBranch,
      required this.documentId,
      required this.githubRepositoryUrl,
      required this.baseBranch,
      required this.githubPAT,
      required this.platform,
      required this.userId});

  factory _$JobDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$JobDataImplFromJson(json);

  @override
  final String buildBranch;
  @override
  final String documentId;
  @override
  final String githubRepositoryUrl;
  @override
  final String baseBranch;
  @override
  final String githubPAT;

  ///
  @override
  final TargetPlatform platform;
  @override
  final String userId;

  @override
  String toString() {
    return 'JobData(buildBranch: $buildBranch, documentId: $documentId, githubRepositoryUrl: $githubRepositoryUrl, baseBranch: $baseBranch, githubPAT: $githubPAT, platform: $platform, userId: $userId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JobDataImpl &&
            (identical(other.buildBranch, buildBranch) ||
                other.buildBranch == buildBranch) &&
            (identical(other.documentId, documentId) ||
                other.documentId == documentId) &&
            (identical(other.githubRepositoryUrl, githubRepositoryUrl) ||
                other.githubRepositoryUrl == githubRepositoryUrl) &&
            (identical(other.baseBranch, baseBranch) ||
                other.baseBranch == baseBranch) &&
            (identical(other.githubPAT, githubPAT) ||
                other.githubPAT == githubPAT) &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, buildBranch, documentId,
      githubRepositoryUrl, baseBranch, githubPAT, platform, userId);

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
      {required final String buildBranch,
      required final String documentId,
      required final String githubRepositoryUrl,
      required final String baseBranch,
      required final String githubPAT,
      required final TargetPlatform platform,
      required final String userId}) = _$JobDataImpl;

  factory _JobData.fromJson(Map<String, dynamic> json) = _$JobDataImpl.fromJson;

  @override
  String get buildBranch;
  @override
  String get documentId;
  @override
  String get githubRepositoryUrl;
  @override
  String get baseBranch;
  @override
  String get githubPAT;
  @override

  ///
  TargetPlatform get platform;
  @override
  String get userId;
  @override
  @JsonKey(ignore: true)
  _$$JobDataImplCopyWith<_$JobDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
