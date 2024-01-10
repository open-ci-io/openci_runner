import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_data.freezed.dart';
part 'user_data.g.dart';

@freezed
class UserData with _$UserData {
  const factory UserData({
    required int? androidBuildNumber,
    required String? androidKeyJks,
    required String? androidKeyProperties,
    required String? appName,
    required String? appStoreConnectIssuerId,
    required String? appStoreConnectKeyId,
    required String? appStoreConnectP8,
    required String? firebaseAppDistributionServiceAccountJson,
    required List<String>? firebaseAppDistributionTesters,
    required String? firebaseAppIdAndroid,
    required String? firebaseAppIdIos,
    required String? firebaseCLIToken,
    required String? githubRepositoryUrl,
    required int? iosBuildNumber,
    required String? pubspecYamlName,
    required String? serviceAccountJson,
    required List<String>? triggerBranches,
    required String? userId,
  }) = _UserData;
  factory UserData.fromJson(Map<String, Object?> json) =>
      _$UserDataFromJson(json);
}
