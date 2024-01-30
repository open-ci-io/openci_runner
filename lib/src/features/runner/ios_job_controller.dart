// Business logic after SSH connection to macOS VM
import 'package:dart_firebase_admin/firestore.dart';
import 'package:dartssh2/dartssh2.dart';
import 'package:openci_runner/src/features/job/domain/job_data.dart';
import 'package:openci_runner/src/features/runner/runner_command.dart';
import 'package:openci_runner/src/features/user/domain/user_data.dart';
import 'package:openci_runner/src/features/vm/controller/vm_controller.dart';
import 'package:openci_runner/src/services/ssh/ssh_service.dart';
import 'package:openci_runner/src/utilities/github/github_service.dart';
import 'package:uuid/uuid.dart';

class IosJobController {
  IosJobController({
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

  Future<bool> shellV2(
    String command,
  ) async {
    final sessionResult = await sshService.runV2(
      sshClient,
      command,
    );
    // TODO save command, stdout, stderr, exitcode to Firestore
    final logDocumentId = const Uuid().v4();
    await firestore
        .collection(jobsPath)
        .doc(jobData.documentId)
        .collection('logs')
        .doc(logDocumentId)
        .set({
      'command': command,
      'stdout': sessionResult.sessionStdout,
      'stderr': sessionResult.sessionStderr,
      'exitCode': sessionResult.sessionExitCode,
      'createdAt': FieldValue.serverTimestamp,
    });

    print('jobDocId: ${jobData.documentId}, logsDocId: $logDocumentId');

    final exitCode = sessionResult.sessionExitCode;
    if (exitCode == 0) {
      return true;
    } else {
      await firestore.collection(jobsPath).doc(jobData.documentId).update({
        'failure.android': true,
      });
      await vmController.stopVM;
      return false;
    }
  }

  Future<bool> shellV2Pure(
    String command,
  ) async {
    final sessionResult = await sshService.runV2(
      sshClient,
      command,
    );
    // TODO save command, stdout, stderr, exitcode to Firestore
    final logDocumentId = const Uuid().v4();
    await firestore
        .collection(jobsPath)
        .doc(jobData.documentId)
        .collection('logs')
        .doc(logDocumentId)
        .set({
      'command': command,
      'stdout': sessionResult.sessionStdout,
      'stderr': sessionResult.sessionStderr,
      'exitCode': sessionResult.sessionExitCode,
      'createdAt': FieldValue.serverTimestamp,
    });

    print('jobDocId: ${jobData.documentId}, logsDocId: $logDocumentId');

    final exitCode = sessionResult.sessionExitCode;
    if (exitCode == 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> get cloneRepository =>
      shellV2(gitHubService.clone(job: jobData, url: _githubUrl));

  String get _githubUrl => gitHubService.convertUrl(
        userData.githubRepositoryUrl,
        jobData.githubPAT,
      );

  Future<bool> get importServiceAccountJson async => shellV2(
        'cd ~/Downloads/${userData.appName} && echo "${userData.serviceAccountJson}" | base64 -d > service_account.json;',
      );

  Future<bool> get importKeyJks async {
    final res = await shellV2Pure(
      'cd ~/Downloads/${userData.appName}/${userData.keyJksFilePath}',
    );
    if (res == false) {
      await shellV2(
        'mkdir -p ~/Downloads/${userData.appName}/${userData.keyJksFilePath}',
      );
    }
    return shellV2(
      "cd ~/Downloads/${userData.appName}/${userData.keyJksFilePath} && echo '${userData.androidKeyJks}' | base64 --decode > ${userData.keyJksFileName}.jks;",
    );
  }

  Future<bool> get importKeyProperties async => shellV2(
        "cd ~/Downloads/${userData.appName}/android && echo '${userData.androidKeyProperties}' | base64 --decode > key.properties;",
      );

  Future<bool> get checkFlutterVersion async => shellV2(
        '$_loadZshrcAndCdAppDir && flutter --version',
      );

  Future<bool> get flutterClean async => shellV2(
        '$_loadZshrcAndCdAppDir && $flutterCommand clean && $flutterCommand pub get && $flutterCommand doctor -v;',
      );

  Future<bool> get changeFlutterVersion async => shellV2(
        '$_loadZshrc && cd /Users/admin/flutter && git checkout ${userData.flutterVersion}',
      );

  Future<bool> get buildApk async {
    if (distribution.flavor == Flavor.prod) {
      return shellV2(
        '$_loadZshrcAndCdAppDir && $pathAndroidSDK && flutter --version && $flutterCommand build apk --build-number=${userData.androidBuildNumber} --flavor prod --dart-define=FLAVOR=prod -t lib/${userData.entryPoint};',
      );
    }
    if (distribution.flavor == Flavor.dev) {
      return shellV2(
        '$_loadZshrcAndCdAppDir && $pathAndroidSDK && flutter --version && $flutterCommand build apk --build-number=${userData.androidBuildNumber} --flavor dev --dart-define=FLAVOR=dev -t lib/${userData.entryPoint};',
      );
    }
    if (distribution.flavor == Flavor.none) {
      return shellV2(
        '$_loadZshrcAndCdAppDir && $pathAndroidSDK && $flutterCommand build apk --build-number=${userData.androidBuildNumber};',
      );
    }
    return shellV2(
      '$_loadZshrcAndCdAppDir && $pathAndroidSDK && $flutterCommand build apk --build-number=${userData.androidBuildNumber};',
    );
  }

  String get apkPath {
    if (distribution.flavor == Flavor.prod) {
      return '/Users/admin/Downloads/${userData.appName}/build/app/outputs/flutter-apk/app-prod-release.apk';
    }
    if (distribution.flavor == Flavor.dev) {
      return '/Users/admin/Downloads/${userData.appName}/build/app/outputs/flutter-apk/app-dev-release.apk';
    }
    if (distribution.flavor == Flavor.none) {
      return '/Users/admin/Downloads/${userData.appName}/build/app/outputs/flutter-apk/app-release.apk';
    }
    return '/Users/admin/Downloads/${userData.appName}/build/app/outputs/flutter-apk/app-release.apk';
  }

  Future<bool> get uploadApkToFAD async => shellV2(
        '''
$_loadZshrcAndCdAppDir;
export GOOGLE_APPLICATION_CREDENTIALS="/Users/admin/Downloads/${userData.appName}/service_account.json";
firebase appdistribution:distribute "$apkPath" --app "${userData.firebaseAppIdAndroid}" --groups "${userData.testerGroups.join(', ')}"; 
''',
      );

  String get _loadZshrcAndCdAppDir =>
      'source ~/.zshrc && cd ~/Downloads/${userData.appName}';

  String get _loadZshrc => 'source ~/.zshrc';

  String get pathAndroidSDK =>
      'export ANDROID_SDK_ROOT=/Users/admin/android-sdk';

  String get flutterCommand => 'flutter';
}
