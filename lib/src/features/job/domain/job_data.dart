// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_data.freezed.dart';
part 'job_data.g.dart';

@freezed
class JobData with _$JobData {
  const factory JobData({
    required int id,
    required String build_branch,
    required String user_id,
    required String github_repository_url,
    required String base_branch,
    required String github_personal_access_token,
  }) = _JobData;
  factory JobData.fromJson(Map<String, Object?> json) =>
      _$JobDataFromJson(json);
}
