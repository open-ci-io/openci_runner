import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openci_dashboard/src/features/top/domain/user_data.dart';
import 'package:openci_dashboard/src/features/edit_build_info/presentation/edit_build_info_controller.dart';

class EditBuildInfoPage extends ConsumerWidget {
  const EditBuildInfoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(editBuildInfoControllerProvider);
    final controller = ref.watch(editBuildInfoControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Your Build Info'),
        backgroundColor: Colors.amber,
      ),
      body: state.when(
        data: (data) {
          final userData = data.userData;
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  DropdownButton<String>(
                    hint: const Text('Please choose your org'),
                    value: data.selectedOrg,
                    onChanged: (newValue) async {
                      if (newValue != null) {
                        controller.updateOrg(newValue);
                        final data = await controller.fetchUserData();
                        if (data != null) {
                          controller.updateUserState(data);
                        }
                      }
                    },
                    items: data.joinedOrgs
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  if (userData != null) ...list(userData, controller),
                ],
              ),
            ),
          );
        },
        error: (e, s) => Text(e.toString()),
        loading: () => const CircularProgressIndicator.adaptive(),
      ),
    );
  }

  List<Widget> list(UserData userData, EditBuildInfoController controller) {
    return [
      TextFormField(
        initialValue: userData.androidBuildNumber.toString(),
        decoration: const InputDecoration(
          labelText: 'androidBuildNumber',
          suffixIcon: Icon(Icons.edit),
        ),
        onChanged: controller.updateAndroidBuildNumber,
      ),
      TextFormField(
        initialValue: userData.androidKeyJks.toString(),
        decoration: const InputDecoration(
          labelText: 'androidKeyJks',
          suffixIcon: Icon(Icons.edit),
        ),
        onChanged: controller.updateAndroidKeyJks,
      ),
      TextFormField(
        initialValue: userData.androidKeyProperties.toString(),
        decoration: const InputDecoration(
          labelText: 'androidKeyProperties',
          suffixIcon: Icon(Icons.edit),
        ),
        onChanged: controller.updateAndroidKeyProperties,
      ),
      TextFormField(
        initialValue: userData.appName.toString(),
        decoration: const InputDecoration(
          labelText: 'appName',
          suffixIcon: Icon(Icons.edit),
        ),
        onChanged: controller.updateAppName,
      ),
      TextFormField(
        initialValue: userData.appStoreConnectIssuerId.toString(),
        decoration: const InputDecoration(
          labelText: 'appStoreConnectIssuerId',
          suffixIcon: Icon(Icons.edit),
        ),
        onChanged: controller.updateAppStoreConnectIssuerId,
      ),
      TextFormField(
        initialValue: userData.appStoreConnectKeyId.toString(),
        decoration: const InputDecoration(
          labelText: 'appStoreConnectKeyId',
          suffixIcon: Icon(Icons.edit),
        ),
        onChanged: controller.updateAppStoreConnectKeyId,
      ),
      TextFormField(
        initialValue: userData.appStoreConnectP8.toString(),
        decoration: const InputDecoration(
          labelText: 'appStoreConnectP8',
          suffixIcon: Icon(Icons.edit),
        ),
        onChanged: controller.updateAppStoreConnectP8,
      ),
      TextFormField(
        initialValue:
            userData.firebaseAppDistributionServiceAccountJson.toString(),
        decoration: const InputDecoration(
          labelText: 'firebaseAppDistributionServiceAccountJson',
          suffixIcon: Icon(Icons.edit),
        ),
        onChanged: controller.updateFirebaseAppDistributionServiceAccountJson,
      ),
      TextFormField(
        initialValue: userData.firebaseAppDistributionTesters.toString(),
        decoration: const InputDecoration(
          labelText: 'firebaseAppDistributionTesters',
          suffixIcon: Icon(Icons.edit),
        ),
        onChanged: controller.updateFirebaseAppDistributionTesters,
      ),
      TextFormField(
        initialValue: userData.firebaseAppIdAndroid.toString(),
        decoration: const InputDecoration(
          labelText: 'firebaseAppIdAndroid',
          suffixIcon: Icon(Icons.edit),
        ),
        onChanged: controller.updateFirebaseAppIdAndroid,
      ),
      TextFormField(
        initialValue: userData.firebaseAppIdIos.toString(),
        decoration: const InputDecoration(
          labelText: 'firebaseAppIdIos',
          suffixIcon: Icon(Icons.edit),
        ),
        onChanged: controller.updateFirebaseAppIdIos,
      ),
      TextFormField(
        initialValue: userData.firebaseCLIToken.toString(),
        decoration: const InputDecoration(
          labelText: 'firebaseCLIToken',
          suffixIcon: Icon(Icons.edit),
        ),
        onChanged: controller.updateFirebaseCLIToken,
      ),
      TextFormField(
        initialValue: userData.githubRepositoryUrl.toString(),
        decoration: const InputDecoration(
          labelText: 'githubRepositoryUrl',
          suffixIcon: Icon(Icons.edit),
        ),
        onChanged: controller.updateGithubRepositoryUrl,
      ),
      TextFormField(
        initialValue: userData.iosBuildNumber.toString(),
        decoration: const InputDecoration(
          labelText: 'iosBuildNumber',
          suffixIcon: Icon(Icons.edit),
        ),
        onChanged: controller.updateIosBuildNumber,
      ),
      TextFormField(
        initialValue: userData.pubspecYamlName.toString(),
        decoration: const InputDecoration(
          labelText: 'pubspecYamlName',
          suffixIcon: Icon(Icons.edit),
        ),
        onChanged: controller.updatePubspecYamlName,
      ),
      TextFormField(
        initialValue: userData.serviceAccountJson.toString(),
        decoration: const InputDecoration(
          labelText: 'serviceAccountJson',
          suffixIcon: Icon(Icons.edit),
        ),
        onChanged: controller.updateServiceAccountJson,
      ),
      TextFormField(
        initialValue: userData.triggerBranches.toString(),
        decoration: const InputDecoration(
          labelText: 'triggerBranches',
          suffixIcon: Icon(Icons.edit),
        ),
        onChanged: controller.updateTriggerBranches,
      ),
      TextFormField(
        initialValue: userData.userId.toString(),
        decoration: const InputDecoration(
          labelText: 'userId',
          suffixIcon: Icon(Icons.edit),
        ),
        onChanged: controller.updateUserId,
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            controller.updateUserDataOnFirestore();
          },
          child: const Text('Save'),
        ),
      )
    ];
  }
}
