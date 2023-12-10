// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserDataImpl _$$UserDataImplFromJson(Map<String, dynamic> json) =>
    _$UserDataImpl(
      firebase_cli_token: json['firebase_cli_token'] as String,
      id: json['id'] as int,
      app_store_connect_issuer_id:
          json['app_store_connect_issuer_id'] as String,
      app_store_connect_key_id: json['app_store_connect_key_id'] as String,
      app_store_connect_p8: json['app_store_connect_p8'] as String,
      user_id: json['user_id'] as String,
      github_repository_url: json['github_repository_url'] as String,
      app_name: json['app_name'] as String,
      firebase_app_id_ios: json['firebase_app_id_ios'] as String,
      firebase_app_id_android: json['firebase_app_id_android'] as String,
      ios_build_number: json['ios_build_number'] as int,
      android_build_number: json['android_build_number'] as int,
      firebase_app_distribution_testers:
          (json['firebase_app_distribution_testers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      android_key_properties_base64:
          json['android_key_properties_base64'] as String?,
      android_key_jks_base64: json['android_key_jks_base64'] as String?,
      build_certificate_base64: json['build_certificate_base64'] as String?,
      build_provision_profile_base64:
          json['build_provision_profile_base64'] as String?,
      trigger_branches: (json['trigger_branches'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      distribution: (json['distribution'] as List<dynamic>?)
          ?.map((e) => Distribution.fromJson(e as Map<String, dynamic>))
          .toList(),
      build_provisioning_profile_adhoc_base64:
          json['build_provisioning_profile_adhoc_base64'] as String?,
      export_options_adhoc: json['export_options_adhoc'] as String?,
      export_options_app_store: json['export_options_app_store'] as String?,
      service_account: (json['service_account'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      service_account_json_base64:
          json['service_account_json_base64'] as String?,
      package_name: json['package_name'] as String?,
      fad_service_account_base64: json['fad_service_account_base64'] as String?,
      pubspec_yaml_name: json['pubspec_yaml_name'] as String,
    );

Map<String, dynamic> _$$UserDataImplToJson(_$UserDataImpl instance) =>
    <String, dynamic>{
      'firebase_cli_token': instance.firebase_cli_token,
      'id': instance.id,
      'app_store_connect_issuer_id': instance.app_store_connect_issuer_id,
      'app_store_connect_key_id': instance.app_store_connect_key_id,
      'app_store_connect_p8': instance.app_store_connect_p8,
      'user_id': instance.user_id,
      'github_repository_url': instance.github_repository_url,
      'app_name': instance.app_name,
      'firebase_app_id_ios': instance.firebase_app_id_ios,
      'firebase_app_id_android': instance.firebase_app_id_android,
      'ios_build_number': instance.ios_build_number,
      'android_build_number': instance.android_build_number,
      'firebase_app_distribution_testers':
          instance.firebase_app_distribution_testers,
      'android_key_properties_base64': instance.android_key_properties_base64,
      'android_key_jks_base64': instance.android_key_jks_base64,
      'build_certificate_base64': instance.build_certificate_base64,
      'build_provision_profile_base64': instance.build_provision_profile_base64,
      'trigger_branches': instance.trigger_branches,
      'distribution': instance.distribution,
      'build_provisioning_profile_adhoc_base64':
          instance.build_provisioning_profile_adhoc_base64,
      'export_options_adhoc': instance.export_options_adhoc,
      'export_options_app_store': instance.export_options_app_store,
      'service_account': instance.service_account,
      'service_account_json_base64': instance.service_account_json_base64,
      'package_name': instance.package_name,
      'fad_service_account_base64': instance.fad_service_account_base64,
      'pubspec_yaml_name': instance.pubspec_yaml_name,
    };

_$DistributionImpl _$$DistributionImplFromJson(Map<String, dynamic> json) =>
    _$DistributionImpl(
      platform: json['platform'] as String,
      base_branch: json['base_branch'] as String,
      distribution: json['distribution'] as String,
    );

Map<String, dynamic> _$$DistributionImplToJson(_$DistributionImpl instance) =>
    <String, dynamic>{
      'platform': instance.platform,
      'base_branch': instance.base_branch,
      'distribution': instance.distribution,
    };
