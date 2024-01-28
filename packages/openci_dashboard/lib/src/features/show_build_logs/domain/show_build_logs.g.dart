// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_build_logs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShowBuildLogsImpl _$$ShowBuildLogsImplFromJson(Map<String, dynamic> json) =>
    _$ShowBuildLogsImpl(
      joinedOrgs: (json['joinedOrgs'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const ['test', 'test2'],
      selectedOrg: json['selectedOrg'] as String?,
      userData: json['userData'] == null
          ? null
          : UserData.fromJson(json['userData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ShowBuildLogsImplToJson(_$ShowBuildLogsImpl instance) =>
    <String, dynamic>{
      'joinedOrgs': instance.joinedOrgs,
      'selectedOrg': instance.selectedOrg,
      'userData': instance.userData,
    };
