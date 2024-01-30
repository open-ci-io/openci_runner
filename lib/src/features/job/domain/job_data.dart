import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_data.freezed.dart';
part 'job_data.g.dart';

@freezed
class JobData with _$JobData {
  const factory JobData({
    required String buildBranch,
    required String documentId,
    required String githubRepositoryUrl,
    required String baseBranch,
    required String githubPAT,

    ///
    required TargetPlatform platform,
    required String userId,
  }) = _JobData;

  factory JobData.fromJson(Map<String, Object?> json) =>
      _$JobDataFromJson(json);
}

enum TargetPlatform {
  android,
  ios,
}
