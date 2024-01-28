import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:openci_dashboard/src/features/top/domain/user_data.dart';

part 'show_build_logs.freezed.dart';
part 'show_build_logs.g.dart';

@freezed
class ShowBuildLogs with _$ShowBuildLogs {
  const factory ShowBuildLogs({
    @Default(['test', 'test2']) List<String> joinedOrgs,
    String? selectedOrg,
    UserData? userData,
  }) = _ShowBuildLogs;
  factory ShowBuildLogs.fromJson(Map<String, Object?> json) =>
      _$ShowBuildLogsFromJson(json);
}
