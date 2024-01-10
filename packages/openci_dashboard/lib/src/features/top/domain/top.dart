import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:openci_dashboard/src/features/top/domain/user_data.dart';

part 'top.freezed.dart';
part 'top.g.dart';

@freezed
class Top with _$Top {
  const factory Top({
    @Default(0) int androidBuildNumber,
    @Default(['test', 'test2']) List<String> joinedOrgs,
    String? selectedOrg,
    UserData? userData,
  }) = _Top;
  factory Top.fromJson(Map<String, Object?> json) => _$TopFromJson(json);
}
