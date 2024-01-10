import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:openci_dashboard/src/features/top/domain/top.dart';
import 'package:openci_dashboard/src/features/top/domain/user_data.dart';
import 'package:openci_dashboard/src/utilities/riverpod/get_previous_value.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'top_controller.g.dart';

@riverpod
class TopController extends _$TopController {
  @override
  Future<Top> build() async {
    return Top(
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

  Future<void> updateUserDataOnFirestore() async {
    final previousValue = getPreviousValue(state);

    final qs = await FirebaseFirestore.instance
        .collection('users')
        .where('users', arrayContains: currentUserId)
        .where('orgName', isEqualTo: previousValue.selectedOrg)
        .get();
    final docs = qs.docs.first;
    print('data: ${previousValue.userData!.toJson()}');
    await docs.reference.update(previousValue.userData!.toJson());
  }

  Future<void> updateUserState(UserData userData) async {
    final previousValue = getPreviousValue(state);
    state = AsyncData(previousValue.copyWith(userData: userData));
  }

  Future<void> updateAndroidBuildNumber(String newValue) async {
    final previousValue = getPreviousValue(state);
    state = AsyncData(
      previousValue.copyWith.userData!(androidBuildNumber: int.parse(newValue)),
    );
  }

  Future<void> updateAndroidKeyJks(String newValue) async {
    final previousValue = getPreviousValue(state);
    state = AsyncData(
      previousValue.copyWith.userData!(androidKeyJks: newValue),
    );
  }

  Future<void> updateAndroidKeyProperties(String newValue) async {
    final previousValue = getPreviousValue(state);
    state = AsyncData(
      previousValue.copyWith.userData!(androidKeyProperties: newValue),
    );
  }

  Future<void> updateAppName(String newValue) async {
    final previousValue = getPreviousValue(state);
    state = AsyncData(
      previousValue.copyWith.userData!(appName: newValue),
    );
  }

  Future<void> updateAppStoreConnectIssuerId(String newValue) async {
    final previousValue = getPreviousValue(state);
    state = AsyncData(
      previousValue.copyWith.userData!(appStoreConnectIssuerId: newValue),
    );
  }

  Future<void> updateAppStoreConnectKeyId(String newValue) async {
    final previousValue = getPreviousValue(state);
    state = AsyncData(
      previousValue.copyWith.userData!(appStoreConnectKeyId: newValue),
    );
  }

  Future<void> updateAppStoreConnectP8(String newValue) async {
    final previousValue = getPreviousValue(state);
    state = AsyncData(
      previousValue.copyWith.userData!(appStoreConnectP8: newValue),
    );
  }

  Future<void> updateFirebaseAppDistributionServiceAccountJson(
      String newValue) async {
    final previousValue = getPreviousValue(state);
    state = AsyncData(
      previousValue.copyWith.userData!(
          firebaseAppDistributionServiceAccountJson: newValue),
    );
  }

  Future<void> updateFirebaseAppDistributionTesters(String newValue) async {
    final previousValue = getPreviousValue(state);
    state = AsyncData(
      previousValue.copyWith.userData!(
          firebaseAppDistributionTesters:
              List<String>.from(json.decode(newValue))),
    );
  }

  Future<void> updateFirebaseAppIdAndroid(String newValue) async {
    final previousValue = getPreviousValue(state);
    state = AsyncData(
      previousValue.copyWith.userData!(firebaseAppIdAndroid: newValue),
    );
  }

  Future<void> updateFirebaseAppIdIos(String newValue) async {
    final previousValue = getPreviousValue(state);
    state = AsyncData(
      previousValue.copyWith.userData!(firebaseAppIdIos: newValue),
    );
  }

  Future<void> updateFirebaseCLIToken(String newValue) async {
    final previousValue = getPreviousValue(state);
    state = AsyncData(
      previousValue.copyWith.userData!(firebaseCLIToken: newValue),
    );
  }

  Future<void> updateGithubRepositoryUrl(String newValue) async {
    final previousValue = getPreviousValue(state);
    state = AsyncData(
      previousValue.copyWith.userData!(githubRepositoryUrl: newValue),
    );
  }

  Future<void> updateIosBuildNumber(String newValue) async {
    final previousValue = getPreviousValue(state);
    state = AsyncData(
      previousValue.copyWith.userData!(iosBuildNumber: int.parse(newValue)),
    );
  }

  Future<void> updatePubspecYamlName(String newValue) async {
    final previousValue = getPreviousValue(state);
    state = AsyncData(
      previousValue.copyWith.userData!(pubspecYamlName: newValue),
    );
  }

  Future<void> updateServiceAccountJson(String newValue) async {
    final previousValue = getPreviousValue(state);
    state = AsyncData(
      previousValue.copyWith.userData!(serviceAccountJson: newValue),
    );
  }

  Future<void> updateTriggerBranches(String newValue) async {
    final previousValue = getPreviousValue(state);
    state = AsyncData(
      previousValue.copyWith.userData!(
          triggerBranches: List<String>.from(json.decode(newValue))),
    );
  }

  Future<void> updateUserId(String newValue) async {
    final previousValue = getPreviousValue(state);
    state = AsyncData(
      previousValue.copyWith.userData!(userId: newValue),
    );
  }
}
