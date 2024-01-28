import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:openci_dashboard/src/features/top/domain/user_data.dart';

part 'edit_build_info.freezed.dart';
part 'edit_build_info.g.dart';

@freezed
class EditBuildInfo with _$EditBuildInfo {
  const factory EditBuildInfo({
    @Default(0) int androidBuildNumber,
    @Default(['test', 'test2']) List<String> joinedOrgs,
    String? selectedOrg,
    UserData? userData,
  }) = _Top;
  factory EditBuildInfo.fromJson(Map<String, Object?> json) =>
      _$EditBuildInfoFromJson(json);
}
