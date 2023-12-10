// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_data.freezed.dart';
part 'user_data.g.dart';

@freezed
class UserData with _$UserData {
  const factory UserData({
    required String firebase_cli_token,
    required int id,
    required String app_store_connect_issuer_id,
    required String app_store_connect_key_id,
    required String app_store_connect_p8,
    required String user_id,
    required String github_repository_url,
    required String app_name,
    required String firebase_app_id_ios,
    required String firebase_app_id_android,
    required int ios_build_number,
    required int android_build_number,
    required List<String>? firebase_app_distribution_testers,
    required String? android_key_properties_base64,
    required String? android_key_jks_base64,
    required String? build_certificate_base64,
    required String? build_provision_profile_base64,
    required List<String>? trigger_branches,
    required List<Distribution>? distribution,
    required String? build_provisioning_profile_adhoc_base64,
    required String? export_options_adhoc,
    required String? export_options_app_store,
    required Map<String, String>? service_account,
    required String? service_account_json_base64,
    required String? package_name,
    required String? fad_service_account_base64,
    required String pubspec_yaml_name,
  }) = _UserData;
  factory UserData.fromJson(Map<String, Object?> json) =>
      _$UserDataFromJson(json);
}

@freezed
class Distribution with _$Distribution {
  const factory Distribution({
    required String platform,
    required String base_branch,
    required String distribution,
  }) = _Distribution;
  factory Distribution.fromJson(Map<String, Object?> json) =>
      _$DistributionFromJson(json);
}
