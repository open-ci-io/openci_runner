import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:openci_dashboard/src/features/show_build_logs/domain/show_build_logs.dart';
import 'package:openci_dashboard/src/features/top/domain/user_data.dart';
import 'package:openci_dashboard/src/utilities/riverpod/get_previous_value.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'show_build_logs_controller.g.dart';

@riverpod
class ShowBuildLogsController extends _$ShowBuildLogsController {
  @override
  Future<ShowBuildLogs> build() async {
    return ShowBuildLogs(
      joinedOrgs: await _fetchOrgNameList(),
    );
  }

  String get currentUserId {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    if (currentUserId == null) {
      throw Exception('current user is null');
    }
    return currentUserId;
  }

  Future<void> updateUserState(UserData userData) async {
    final previousValue = getPreviousValue(state);
    state = AsyncData(previousValue.copyWith(userData: userData));
  }

  Future<UserData?> fetchUserData() async {
    final previousValue = getPreviousValue(state);

    final qs = await FirebaseFirestore.instance
        .collection('users')
        .where('users', arrayContains: currentUserId)
        .where('orgName', isEqualTo: previousValue.selectedOrg)
        .get();
    final docs = qs.docs.first;
    final map = docs.data();
    return UserData.fromJson(map);
  }

  Future<List<String>> _fetchOrgNameList() async {
    final qs = await FirebaseFirestore.instance
        .collection('users')
        .where('users', arrayContains: currentUserId)
        .get();
    final joinedOrgs = <String>[];
    if (qs.docs.isEmpty) {
      return joinedOrgs;
    }
    for (final docs in qs.docs) {
      final orgName = docs.data()['orgName'];
      joinedOrgs.add(orgName);
    }

    return joinedOrgs;
  }

  Future<void> updateOrg(String value) async {
    state = AsyncData(getPreviousValue(state).copyWith(selectedOrg: value));
  }
}

@riverpod
Future<dynamic> fetchBuildList(FetchBuildListRef ref, String userId) async {
  final controller = ref.watch(showBuildLogsControllerProvider.notifier);
  print('currentUserId: ${controller.currentUserId}');
  QuerySnapshot<Map<String, dynamic>>? qs;

  qs = await FirebaseFirestore.instance
      .collection('jobs')
      .where('users', arrayContains: 'X8gUzt57XESO0QCy6RCbibaMDUs1')
      .where('userId', isEqualTo: userId)
      .get();
  final buildList = <dynamic>[];
  for (final docs in qs.docs) {
    final map = docs.data();
    buildList.add(map);
  }
  return buildList;
}
