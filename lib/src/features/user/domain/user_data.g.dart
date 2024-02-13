// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserDataImpl _$$UserDataImplFromJson(Map<String, dynamic> json) =>
    _$UserDataImpl(
      androidBuildNumber: json['androidBuildNumber'] as int,
      androidKeyJks: json['androidKeyJks'] as String,
      androidKeyProperties: json['androidKeyProperties'] as String,
      androidTesterGroups: (json['androidTesterGroups'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      appName: json['appName'] as String,
      appStoreConnectIssuerId: json['appStoreConnectIssuerId'] as String?,
      appStoreConnectKeyId: json['appStoreConnectKeyId'] as String?,
      appStoreConnectP8: json['appStoreConnectP8'] as String?,
      entryPoint: json['entryPoint'] as String,
      firebaseAppDistributionTesters:
          (json['firebaseAppDistributionTesters'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      firebaseAppIdAndroid: json['firebaseAppIdAndroid'] as String,
      firebaseAppIdIos: json['firebaseAppIdIos'] as String?,
      flutterVersion: json['flutterVersion'] as String,
      githubRepositoryUrl: json['githubRepositoryUrl'] as String,
      iosBuildNumber: json['iosBuildNumber'] as int,
      iosTesterGroups: (json['iosTesterGroups'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      keyJksFilePath: json['keyJksFilePath'] as String,
      keyJksFileName: json['keyJksFileName'] as String,
      pubspecYamlName: json['pubspecYamlName'] as String,
      serviceAccountJson: json['serviceAccountJson'] as String,
      triggerBranches: (json['triggerBranches'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      userId: json['userId'] as String,
      exportOptionsAdhoc: json['exportOptionsAdhoc'] as String?,
      buildProvisioningProfileBase64:
          json['buildProvisioningProfileBase64'] as String?,
      buildCertificateBase64: json['buildCertificateBase64'] as String?,
    );

Map<String, dynamic> _$$UserDataImplToJson(_$UserDataImpl instance) =>
    <String, dynamic>{
      'androidBuildNumber': instance.androidBuildNumber,
      'androidKeyJks': instance.androidKeyJks,
      'androidKeyProperties': instance.androidKeyProperties,
      'androidTesterGroups': instance.androidTesterGroups,
      'appName': instance.appName,
      'appStoreConnectIssuerId': instance.appStoreConnectIssuerId,
      'appStoreConnectKeyId': instance.appStoreConnectKeyId,
      'appStoreConnectP8': instance.appStoreConnectP8,
      'entryPoint': instance.entryPoint,
      'firebaseAppDistributionTesters': instance.firebaseAppDistributionTesters,
      'firebaseAppIdAndroid': instance.firebaseAppIdAndroid,
      'firebaseAppIdIos': instance.firebaseAppIdIos,
      'flutterVersion': instance.flutterVersion,
      'githubRepositoryUrl': instance.githubRepositoryUrl,
      'iosBuildNumber': instance.iosBuildNumber,
      'iosTesterGroups': instance.iosTesterGroups,
      'keyJksFilePath': instance.keyJksFilePath,
      'keyJksFileName': instance.keyJksFileName,
      'pubspecYamlName': instance.pubspecYamlName,
      'serviceAccountJson': instance.serviceAccountJson,
      'triggerBranches': instance.triggerBranches,
      'userId': instance.userId,
      'exportOptionsAdhoc': instance.exportOptionsAdhoc,
      'buildProvisioningProfileBase64': instance.buildProvisioningProfileBase64,
      'buildCertificateBase64': instance.buildCertificateBase64,
    };

_$DistributionImpl _$$DistributionImplFromJson(Map<String, dynamic> json) =>
    _$DistributionImpl(
      platform: json['platform'] as String,
      baseBranch: json['baseBranch'] as String,
      distribution: json['distribution'] as String,
      flavor: $enumDecode(_$FlavorEnumMap, json['flavor']),
    );

Map<String, dynamic> _$$DistributionImplToJson(_$DistributionImpl instance) =>
    <String, dynamic>{
      'platform': instance.platform,
      'baseBranch': instance.baseBranch,
      'distribution': instance.distribution,
      'flavor': _$FlavorEnumMap[instance.flavor],
    };

const _$FlavorEnumMap = {
  Flavor.none: 'none',
  Flavor.dev: 'dev',
  Flavor.stage: 'stage',
  Flavor.prod: 'prod',
};
