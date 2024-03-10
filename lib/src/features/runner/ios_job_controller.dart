// Business logic after SSH connection to macOS VM
// ignore_for_file: lines_longer_than_80_chars

import 'package:dart_firebase_admin/firestore.dart';
import 'package:dartssh2/dartssh2.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:openci_runner/src/features/job/domain/job_data.dart';
import 'package:openci_runner/src/features/runner/runner_command.dart';
import 'package:openci_runner/src/features/user/domain/user_data.dart';
import 'package:openci_runner/src/features/vm/controller/vm_controller.dart';
import 'package:openci_runner/src/services/macos/directory_paths.dart';
import 'package:openci_runner/src/services/ssh/domain/session_result.dart';
import 'package:openci_runner/src/services/ssh/ssh_service.dart';
import 'package:openci_runner/src/utilities/github/github_service.dart';
import 'package:uuid/uuid.dart';

part 'ios_job_controller.freezed.dart';

@freezed
class ShellResult with _$ShellResult {
  const factory ShellResult({
    required bool result,
    required SessionResult sessionResult,
  }) = _ShellResult;
}

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

  Future<ShellResult> shellV2(
    String command,
  ) async {
    final sessionResult = await sshService.runV2(
      sshClient,
      command,
    );
    // TODO(mafreud): save command, stdout, stderr, exitCode to Firestore
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

    final exitCode = sessionResult.sessionExitCode;
    if (exitCode == 0) {
      return ShellResult(result: true, sessionResult: sessionResult);
    } else {
      await firestore.collection(jobsPath).doc(jobData.documentId).update({
        'failure': true,
      });
      await vmController.stopVM;
      return ShellResult(result: false, sessionResult: sessionResult);
    }
  }

  Future<bool> shellV2WithResult(
    String command,
  ) async {
    final result = await shellV2(command);
    return result.result;
  }

  Future<bool> shellV2Pure(
    String command,
  ) async {
    final sessionResult = await sshService.runV2(
      sshClient,
      command,
    );
    // TODO(mafreud): save command, stdout, stderr, exitCode to Firestore
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

    final exitCode = sessionResult.sessionExitCode;
    if (exitCode == 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> get runCustomScript async => shellV2WithResult('''
source ~/.zshrc;
cd Downloads/${userData.appName};
flutter pub get;
cd ios;
rm -rf Pods;
pod --version;
pod repo update;
pod install;
''');

  Future<bool> get uploadApkToFAD async {
    final apkPath = await dynamicApkPath;
    return shellV2WithResult(
      '''
$_loadZshrcAndCdAppDir;
export GOOGLE_APPLICATION_CREDENTIALS="/Users/admin/Downloads/${userData.appName}/service_account.json";
firebase appdistribution:distribute "$apkPath" --app "${userData.firebaseAppIdAndroid}" --groups "${userData.androidTesterGroups.join(', ')}"; 
''',
    );
  }

  final icloudKeychainPassword = 'mementomori';

  Future<bool> get importCertificates => shellV2WithResult('''
cd ~/Downloads/certificates;
security create-keychain -p $icloudKeychainPassword $keychainPath;
security default-keychain -s $keychainPath;
security unlock-keychain -p $icloudKeychainPassword $keychainPath;
security set-keychain-settings -lut 21600 $keychainPath;
security import $p12 -P $icloudKeychainPassword -A -t cert -f pkcs12 -k $keychainPath;
security list-keychain -d user -s $keychainPath;
mkdir -p ~/Library/MobileDevice/Provisioning\\ Profiles;
cp $mobileprovisionPath ~/Library/MobileDevice/Provisioning\\ Profiles;
''');

  Future<bool> get importAdhocExportOptionsPlist => shellV2WithResult('''
cd ~/Downloads/${userData.appName}/ios;
echo -n ${userData.exportOptionsAdhoc} | base64 --decode -o openCIexportOptions.plist;
''');

  Future<bool> get createAdhocCertificates => shellV2WithResult('''
mkdir $certificateDirectory;
echo -n ${userData.buildCertificateBase64} | base64 --decode -o $p12;
''');

  Future<bool> get createAdhocMobileProvisioningProfile => shellV2WithResult('''
echo -n ${userData.buildProvisioningProfileBase64} | base64 --decode -o $mobileprovisionPath;
''');

  Future<bool> get cloneRepository =>
      shellV2WithResult(gitHubService.clone(job: jobData, url: _githubUrl));

  String get _githubUrl => gitHubService.convertUrl(
        userData.githubRepositoryUrl,
        jobData.githubPAT,
      );

  Future<bool> get importServiceAccountJson async => shellV2WithResult(
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
    return shellV2WithResult(
      "cd ~/Downloads/${userData.appName}/${userData.keyJksFilePath} && echo '${userData.androidKeyJks}' | base64 --decode > ${userData.keyJksFileName}.jks;",
    );
  }

  Future<bool> get importP8 async {
    if (userData.appStoreConnectKeyId == null ||
        userData.appStoreConnectP8 == null ||
        userData.appStoreConnectIssuerId == null) {
      return true;
    }

    final privateKeysDir = '~/Downloads/${userData.appName}/private_keys';
    final p8FileName = 'AuthKey_${userData.appStoreConnectKeyId}.p8';
    return shellV2WithResult(
      'mkdir $privateKeysDir && echo ${userData.appStoreConnectP8} | base64 --decode > $privateKeysDir/$p8FileName',
    );
  }

  Future<bool> get importKeyProperties async => shellV2WithResult(
        "cd ~/Downloads/${userData.appName}/android && echo '${userData.androidKeyProperties}' | base64 --decode > key.properties;",
      );

  Future<bool> get checkFlutterVersion async => shellV2WithResult(
        '$_loadZshrcAndCdAppDir && flutter --version',
      );

  Future<bool> get flutterClean async => shellV2WithResult(
        '$_loadZshrcAndCdAppDir && $flutterCommand clean && $flutterCommand pub get && $flutterCommand doctor -v;',
      );

  Future<bool> get changeFlutterVersion async => shellV2WithResult(
        '$_loadZshrc && cd /Users/admin/flutter && git checkout ${userData.flutterVersion}',
      );

  Future<bool> get buildIpa {
    if (distribution.flavor == Flavor.prod) {
      return shellV2WithResult(
        '$_loadZshrcAndCdAppDir && $flutterCommand build ipa --build-number=${userData.iosBuildNumber} --flavor prod --dart-define=FLAVOR=prod -t lib/${userData.entryPoint} --export-options-plist=ios/openCIexportOptions.plist;',
      );
    }
    if (distribution.flavor == Flavor.dev) {
      return shellV2WithResult(
        '$_loadZshrcAndCdAppDir && $flutterCommand build ipa --build-number=${userData.iosBuildNumber} --flavor dev --dart-define=FLAVOR=dev -t lib/${userData.entryPoint} --export-options-plist=ios/openCIexportOptions.plist;',
      );
    }
    return shellV2WithResult(
      '$_loadZshrcAndCdAppDir && $flutterCommand build ipa --build-number=${userData.iosBuildNumber} --export-options-plist=ios/openCIexportOptions.plist;',
    );
  }

  Future<bool> get buildApk async {
    if (distribution.flavor == Flavor.prod) {
      return shellV2WithResult(
        '$_loadZshrcAndCdAppDir && $pathAndroidSDK && flutter --version && $flutterCommand build apk --build-number=${userData.androidBuildNumber} --flavor prod --dart-define=FLAVOR=prod -t lib/${userData.entryPoint};',
      );
    }
    if (distribution.flavor == Flavor.dev) {
      return shellV2WithResult(
        '$_loadZshrcAndCdAppDir && $pathAndroidSDK && flutter --version && $flutterCommand build apk --build-number=${userData.androidBuildNumber} --flavor dev --dart-define=FLAVOR=dev -t lib/${userData.entryPoint};',
      );
    }
    if (distribution.flavor == Flavor.none) {
      return shellV2WithResult(
        '$_loadZshrcAndCdAppDir && $pathAndroidSDK && $flutterCommand build apk --build-number=${userData.androidBuildNumber};',
      );
    }
    return shellV2WithResult(
      '$_loadZshrcAndCdAppDir && $pathAndroidSDK && $flutterCommand build apk --build-number=${userData.androidBuildNumber};',
    );
  }

  Future<String> get dynamicIpaPath async {
    final result = await shellV2(
      'find "/Users/admin/Downloads/${userData.appName}/build/ios/ipa" -type f -name "*.ipa"',
    );
    final filePath = result.sessionResult.sessionStdout;
    return filePath.replaceAll('\n', '');
  }

  Future<String> get dynamicApkPath async {
    final result = await shellV2(
      'find "/Users/admin/Downloads/${userData.appName}/build/app/outputs/flutter-apk" -type f -name "*.apk"',
    );
    final filePath = result.sessionResult.sessionStdout;
    return filePath.replaceAll('\n', '');
  }

  Future<bool> get uploadIpaToFAD async {
    final ipaPath = await dynamicIpaPath;
    return shellV2WithResult(
      '''
$_loadZshrcAndCdAppDir;
export GOOGLE_APPLICATION_CREDENTIALS="/Users/admin/Downloads/${userData.appName}/service_account.json";
firebase appdistribution:distribute "$ipaPath" --app "${userData.firebaseAppIdIos}" --groups "${userData.iosTesterGroups.join(', ')}"; 
''',
    );
  }

  Future<bool> get uploadIpaToTestFlight async {
    final ipaPath = await dynamicIpaPath;
    return shellV2WithResult(
      '''
$_loadZshrcAndCdAppDir;
xcrun altool --upload-app -f $ipaPath --type ios --apiKey ${userData.appStoreConnectKeyId} --apiIssuer ${userData.appStoreConnectIssuerId}
''',
    );
  }

  String get _loadZshrcAndCdAppDir =>
      'source ~/.zshrc && cd ~/Downloads/${userData.appName}';

  String get _loadZshrc => 'source ~/.zshrc';

  String get pathAndroidSDK =>
      'export ANDROID_SDK_ROOT=/Users/admin/android-sdk';

  String get flutterCommand => 'flutter';
}
