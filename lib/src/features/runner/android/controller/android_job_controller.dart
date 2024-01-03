// Business logic after SSH connection to macOS VM
import 'package:dart_firebase_admin/firestore.dart';
import 'package:dartssh2/dartssh2.dart';
import 'package:openci_runner/src/features/job/domain/job_data.dart';
import 'package:openci_runner/src/features/user/domain/user_data.dart';
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
  });

  final SSHService sshService;
  final SSHClient sshClient;
  final JobData jobData;
  final GitHubService gitHubService;
  final UserData userData;
  final Firestore firestore;

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
    }
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
    }
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

  Future<bool> get flutterClean async => shellV2(
        'source ~/.zshrc && cd Downloads/${userData.appName} && flutter clean && flutter pub get;',
      );

  Future<bool> get buildApk async => shell(
        'source ~/.zshrc && cd ~/Downloads/${userData.appName} && export ANDROID_SDK_ROOT=/Users/admin/android-sdk && flutter build apk --build-number=${userData.androidBuildNumber} --flavor prod --dart-define=FLAVOR=prod;',
      );

  String get prodApkPath =>
      '/Users/admin/Downloads/${userData.appName}/build/app/outputs/flutter-apk/app-prod-release.apk';

  Future<bool> get uploadApkToPlayStore async => shell(
        '''
source ~/.zshrc;
cd ~/Downloads/${userData.appName}
firebase --token "${userData.firebaseCLIToken}" appdistribution:distribute "$prodApkPath" --app "${userData.firebaseAppIdAndroid}";
''',
      );
}
