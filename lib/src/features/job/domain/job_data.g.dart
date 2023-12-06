// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JobDataImpl _$$JobDataImplFromJson(Map<String, dynamic> json) =>
    _$JobDataImpl(
      id: json['id'] as int,
      build_branch: json['build_branch'] as String,
      user_id: json['user_id'] as String,
      github_repository_url: json['github_repository_url'] as String,
      base_branch: json['base_branch'] as String,
      github_personal_access_token:
          json['github_personal_access_token'] as String,
    );

Map<String, dynamic> _$$JobDataImplToJson(_$JobDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'build_branch': instance.build_branch,
      'user_id': instance.user_id,
      'github_repository_url': instance.github_repository_url,
      'base_branch': instance.base_branch,
      'github_personal_access_token': instance.github_personal_access_token,
    };
