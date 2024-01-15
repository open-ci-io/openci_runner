// Business logic after SSH connection to macOS VM
import 'package:dart_firebase_admin/firestore.dart';
import 'package:dartssh2/dartssh2.dart';
import 'package:openci_runner/src/features/job/domain/job_data.dart';
import 'package:openci_runner/src/features/user/domain/user_data.dart';
import 'package:openci_runner/src/features/vm/controller/vm_controller.dart';
import 'package:openci_runner/src/services/ssh/ssh_service.dart';
import 'package:openci_runner/src/utilities/github/github_service.dart';

class AndroidJobController {
  AndroidJobController({
    required this.sshService,
    required this.sshClient,
    required this.jobData,
    required this.gitHubService,
    required this.userData,
    required this.firestore,
    required this.distribution,
    required this.vmController,
  });

  final SSHService sshService;
  final SSHClient sshClient;
  final JobData jobData;
  final GitHubService gitHubService;
  final UserData userData;
  final Firestore firestore;
  final Distribution distribution;
  final VMController vmController;

  Future<bool> shell(
    String command,
  ) async {
    final result = await sshService.shell(
      command,
      sshClient,
    );
    if (result == false) {
      await firestore.collection('jobs').doc(jobData.documentId).update({
        'failure.android': true,
      });
      await vmController.stopVM;
    }
    return result;
  }

  Future<bool> shellForce(
    String command,
  ) async {
    final result = await sshService.shell(
      command,
      sshClient,
    );
    return result;
  }

  Future<bool> shellV2(
    String command,
  ) async {
    final result = await sshService.run(
      sshClient,
      command,
    );
    if (result == false) {
      await firestore.collection('jobs').doc(jobData.documentId).update({
        'failure.android': true,
      });
      await vmController.stopVM;
    }
    return result;
  }

  Future<bool> shellV2Force(
    String command,
  ) async {
    final result = await sshService.run(
      sshClient,
      command,
    );
    return result;
  }

  Future<bool> get cloneRepository =>
      shell(gitHubService.clone(job: jobData, url: _githubUrl));

  String get _githubUrl => gitHubService.convertUrl(
        userData.githubRepositoryUrl,
        jobData.githubPAT,
      );

  Future<bool> get importServiceAccountJson async => shellV2(
        'cd ~/Downloads/${userData.appName} && echo "${userData.serviceAccountJson}" | base64 -d > service_account.json;',
      );

  Future<bool> get importKeyJks async => shellV2(
        "cd ~/Downloads/${userData.appName}/android/app && echo '${userData.androidKeyJks}' | base64 --decode > key.jks;",
      );

  Future<bool> get importKeyProperties async => shellV2(
        "cd ~/Downloads/${userData.appName}/android && echo '${userData.androidKeyProperties}' | base64 --decode > key.properties;",
      );

  Future<bool> get checkFlutterVersion async => shell(
        '$_loadZshrcAndCdAppDir && flutter --version',
      );

  Future<bool> get flutterClean async => shellV2(
        '$_loadZshrcAndCdAppDir && $flutterCommand clean && $flutterCommand pub get && $flutterCommand doctor -v;',
      );

  Future<bool> get changeFlutterVersion async => shell(
        '$_loadZshrc && cd /Users/admin/flutter && git checkout ${userData.flutterVersion}',
      );

  Future<bool> get buildApk async {
    if (distribution.flavor == Flavor.prod) {
      return shell(
        '$_loadZshrcAndCdAppDir && $pathAndroidSDK && flutter --version && $flutterCommand build apk --build-number=${userData.androidBuildNumber} --flavor prod --dart-define=FLAVOR=prod -t lib/${userData.entryPoint};',
      );
    }
    if (distribution.flavor == Flavor.none) {
      return shell(
        '$_loadZshrcAndCdAppDir && $pathAndroidSDK && $flutterCommand build apk --build-number=${userData.androidBuildNumber};',
      );
    }
    return shell(
      '$_loadZshrcAndCdAppDir && $pathAndroidSDK && $flutterCommand build apk --build-number=${userData.androidBuildNumber};',
    );
  }

  String get apkPath {
    if (distribution.flavor == Flavor.prod) {
      return '/Users/admin/Downloads/${userData.appName}/build/app/outputs/flutter-apk/app-prod-release.apk';
    }
    if (distribution.flavor == Flavor.none) {
      return '/Users/admin/Downloads/${userData.appName}/build/app/outputs/flutter-apk/app-release.apk';
    }
    return '/Users/admin/Downloads/${userData.appName}/build/app/outputs/flutter-apk/app-release.apk';
  }

  Future<bool> get uploadApkToPlayStore async => shell(
        '''
$_loadZshrcAndCdAppDir;
firebase --token "${userData.firebaseCLIToken}" appdistribution:distribute "$apkPath" --app "${userData.firebaseAppIdAndroid}";
''',
      );

  String get _loadZshrcAndCdAppDir =>
      'source ~/.zshrc && cd ~/Downloads/${userData.appName}';

  String get _loadZshrc => 'source ~/.zshrc';

  String get pathAndroidSDK =>
      'export ANDROID_SDK_ROOT=/Users/admin/android-sdk';

  String get flutterCommand => 'flutter';
}
