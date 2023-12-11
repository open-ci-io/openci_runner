import 'package:dartssh2/dartssh2.dart';
import 'package:openci_runner/src/features/job/domain/job_data.dart';
import 'package:openci_runner/src/features/user/domain/user_data.dart';
import 'package:openci_runner/src/services/firebase/firebase_app_distribution/fad_service.dart';
import 'package:openci_runner/src/services/github/github_service.dart';
import 'package:openci_runner/src/services/macos/directory_paths.dart';
import 'package:openci_runner/src/services/ssh/ssh_service.dart';

class MacOSService {
  MacOSService({
    required this.sshClient,
    required this.userData,
    required this.jobData,
    required this.isFad,
    required this.icloudKeychainPassword,
  });
  static final sshService = SSHService();
  static final github = GitHubService();
  static final fad = FADService();

  final SSHClient sshClient;
  final UserData userData;
  final JobData jobData;
  final bool isFad;
  final String? icloudKeychainPassword;

  Future<String> sshShell(
    String command,
  ) =>
      sshService.sshShell(
        sshClient: sshClient,
        command: command,
      );

  Future<void> get cleaningWorkingDirectory => sshShell(
        r'''
rm -rf ~/Downloads/certificates;
security delete-keychain ~/Users/admin/certificates/app-signing.keychain-db;
rm ~/Library/MobileDevice/Provisioning\ Profiles/build_pp.mobileprovision;
''',
      );

  Future<void> get cloneRepository =>
      sshShell(github.clone(job: jobData, url: _githubUrl));

  String get _githubUrl => github.convertUrl(
        userData.github_repository_url,
        jobData.github_personal_access_token,
      );

  Future<void> get changeProvisioningProfileFromAppStoreToAdhoc => sshShell(
        """
cd ~/Downloads/${userData.app_name};
sed -i '' 's/app_store/adhoc/gi' ios/Runner.xcodeproj/project.pbxproj
""",
      );

  Future<void> get prepareAdhocExportOptionsPlist => sshShell('''
cd ~/Downloads/${userData.app_name}/ios;
echo -n ${userData.export_options_adhoc} | base64 --decode -o openCIexportOptions.plist;
''');

  Future<void> get prepareAppStoreExportOptionsPlist => sshShell('''
cd ~/Downloads/${userData.app_name}/ios;
echo -n ${userData.export_options_app_store} | base64 --decode -o openCIexportOptions.plist;
''');

  Future<void> get createAdhocCertificates => sshShell('''
mkdir $certificateDirectory;
echo -n ${userData.build_certificate_base64} | base64 --decode -o $p12;
echo -n ${userData.build_provisioning_profile_adhoc_base64} | base64 --decode -o $mobileprovisionPath;
''');

  Future<void> get createAppStoreCertificates => sshShell('''
mkdir $certificateDirectory;
echo -n ${userData.build_certificate_base64} | base64 --decode -o $p12;
echo -n ${userData.build_provision_profile_base64} | base64 --decode -o $mobileprovisionPath;
''');

  Future<void> get importCertificates => sshShell('''
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

  Future<void> get buildIpa => sshShell('''
source ~/.zshrc;
cd Downloads/${userData.app_name};
flutter build ipa --build-number=${userData.ios_build_number} --export-options-plist=ios/openCIexportOptions.plist;
''');

  Future<void> get decodeAppStoreConnectApiKey => sshShell('''
cd Downloads/${userData.app_name};
mkdir private_keys;
echo "${userData.app_store_connect_p8}" | base64 --decode > /Users/admin/Downloads/${userData.app_name}/private_keys/AuthKey_${userData.app_store_connect_key_id}.p8;
''');

// TODO(mafreud): stop using firebase_cli_token
  Future<void> uploadIpaToFad({
    String releaseNote = 'This is a first build.',
  }) async {
    final command = '''
firebase --token "${userData.firebase_cli_token}" appdistribution:distribute "${ipaBuildPath(userData.app_name, userData.pubspec_yaml_name)}" --app "${userData.firebase_app_id_ios}" --release-notes "$releaseNote" ${fad.testers(userData.firebase_app_distribution_testers)};
'''
          ..replaceAll('\n', '');
    await sshShell('''
source ~/.zshrc;
$command
          ''');
  }

  Future<void> get uploadIpaToAppStoreConnect async {
    await sshShell('''
source ~/.zshrc;
cd Downloads/${userData.app_name};
xcrun altool --upload-app --type ios -f ${ipaBuildPath(userData.app_name, userData.pubspec_yaml_name)} --apiKey ${userData.app_store_connect_key_id} --apiIssuer ${userData.app_store_connect_issuer_id}
''');
  }

  Future<void> runCustomScript({String command = ''}) => sshShell('''
source ~/.zshrc;
cd Downloads/${userData.app_name};
flutter pub get;
cd ios;
pod repo update;
pod install;
''');

  Future<void> get importServiceAccountJson => sshShell('''
cd ~/Downloads/${userData.app_name};
echo '${userData.service_account_json_base64}' | base64 --decode > service_account.json;
echo '${userData.fad_service_account_base64}' | base64 --decode > fad_service_account.json;
''');

  Future<void> get importKeyJks => sshShell('''
cd ~/Downloads/${userData.app_name}/android/app;
echo '${userData.android_key_jks_base64}' | base64 --decode > key.jks;
''');

  Future<void> get importKeyProperties => sshShell('''
cd ~/Downloads/${userData.app_name}/android;
echo '${userData.android_key_properties_base64}' | base64 --decode > key.properties;
''');

  Future<void> get buildAppBundle => sshShell('''
source ~/.zshrc;
cd ~/Downloads/${userData.app_name};
export ANDROID_SDK_ROOT=/Users/admin/android-sdk;
flutter build appbundle --build-number=${userData.android_build_number};
''');

  Future<void> get uploadAabToPlayStore => sshShell('''
source ~/.zshrc;
dart pub global activate open_ci_cli;
source /Users/admin/.zshrc;
export PATH="\$PATH":"\$HOME/.pub-cache/bin";
cd ~/Downloads/${userData.app_name}
ls
oi deploy-aab -s service_account.json -n ${userData.package_name} -a /Users/admin/Downloads/${userData.app_name}/build/app/outputs/bundle/release/app-release.aab;
oi deploy-fad -s fad_service_account.json -i ${userData.firebase_app_id_android.trim().replaceAll('\n', '').replaceAll('\r', '')} -a /Users/admin/Downloads/${userData.app_name}/build/app/outputs/bundle/release/app-release.aab;
''');
}
