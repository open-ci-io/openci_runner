// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JobDataImpl _$$JobDataImplFromJson(Map<String, dynamic> json) =>
    _$JobDataImpl(
      buildBranch: json['buildBranch'] as String,
      documentId: json['documentId'] as String,
      githubRepositoryUrl: json['githubRepositoryUrl'] as String,
      baseBranch: json['baseBranch'] as String,
      githubPAT: json['githubPAT'] as String,
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$$JobDataImplToJson(_$JobDataImpl instance) =>
    <String, dynamic>{
      'buildBranch': instance.buildBranch,
      'documentId': instance.documentId,
      'githubRepositoryUrl': instance.githubRepositoryUrl,
      'baseBranch': instance.baseBranch,
      'githubPAT': instance.githubPAT,
      'userId': instance.userId,
    };
