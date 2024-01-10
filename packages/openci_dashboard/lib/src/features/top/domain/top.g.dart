// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TopImpl _$$TopImplFromJson(Map<String, dynamic> json) => _$TopImpl(
      androidBuildNumber: json['androidBuildNumber'] as int? ?? 0,
      joinedOrgs: (json['joinedOrgs'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const ['test', 'test2'],
      selectedOrg: json['selectedOrg'] as String?,
      userData: json['userData'] == null
          ? null
          : UserData.fromJson(json['userData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TopImplToJson(_$TopImpl instance) => <String, dynamic>{
      'androidBuildNumber': instance.androidBuildNumber,
      'joinedOrgs': instance.joinedOrgs,
      'selectedOrg': instance.selectedOrg,
      'userData': instance.userData,
    };
