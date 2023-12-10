import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:openci_runner/src/features/runner/controller/runner_controller.dart';
import 'package:openci_runner/src/features/runner/domain/arguments.dart';
import 'package:openci_runner/src/features/sign_in/controller/sign_in_controller.dart';
import 'package:openci_runner/src/features/sign_in/domain/sign_in.dart';
import 'package:openci_runner/src/features/vm/controller/vm_controller.dart';
import 'package:openci_runner/src/services/macos/macos_service.dart';
import 'package:openci_runner/src/services/ssh/ssh_service.dart';
import 'package:openci_runner/src/services/supabase/supabase_service.dart';
import 'package:openci_runner/src/utilities/future_delayed.dart';

class IosRunnerCommand extends Command<int> {
  IosRunnerCommand({
    required Logger logger,
  }) : _logger = logger {
    argParser
      ..addFlag(
        'supabaseUrl',
        help: 'Supabase URL',
        abbr: 'u',
        negatable: false,
      )
      ..addFlag(
        'supabaseApiKey',
        help: 'Supabase API Key',
        abbr: 'k',
        negatable: false,
      )
      ..addFlag(
        'supabaseSignInEmail',
        help: 'Supabase Sign In Email',
        abbr: 'e',
        negatable: false,
      )
      ..addFlag(
        'supabaseSignInPassword',
        help: 'Supabase Sign In Password',
        abbr: 'p',
        negatable: false,
      )
      ..addFlag(
        'icloudKeychainPassword',
        help: 'iCloud Keychain Password',
        abbr: 'i',
        negatable: false,
      );
  }

  @override
  String get description => 'Open CI core command for iOS';

  @override
  String get name => 'ios_run';

  final Logger _logger;

  @override
  Future<int> run() async {
    final controller = RunnerController(_logger, argResults)
      ..checkArgument(Arguments.supabaseUrl)
      ..checkArgument(Arguments.supabaseApiKey)
      ..checkArgument(Arguments.supabaseSignInEmail)
      ..checkArgument(Arguments.supabaseSignInPassword)
      ..checkArgument(Arguments.icloudKeychainPassword);
    final arguments = controller.doesArgumentsExist();
    final supabaseUrl = arguments[1];
    final supabaseApiKey = arguments[3];
    final supabaseSignInEmail = arguments[5];
    final supabaseSignInPassword = arguments[7];
    final icloudKeychainPassword = arguments[9];

    _logger.success('Argument check passed.');

    final supabase = SupabaseService(
      supabaseUrl: supabaseUrl,
      supabaseApiKey: supabaseApiKey,
    );

    while (true) {
      final signInController = SignInController(_logger);
      final job = await signInController.fetchJob(
        supabase: supabase,
        signIn: SignIn(
          email: supabaseSignInEmail,
          password: supabaseSignInPassword,
        ),
      );
      if (job == null) {
        _logger.info('''
job is null, waiting 10 seconds for next check.
Jobがありません。10秒後に再確認します。
''');
        await wait();
        continue;
      }
      final user = await signInController.signIn(job, supabase);

      if (Platform.isMacOS) {
        final baseBranch = job.base_branch;
        final distribution = user.distribution!
            .where((element) => element.base_branch == baseBranch)
            .first;
        var isFad = false;
        if (distribution.distribution == 'firebase_app_distribution') {
          isFad = true;
        }
        final vm = VMController();
        await vm.prepareVM();
        unawaited(vm.launchVM);
        await wait(seconds: 20);
        _logger.info('VM is ready');
        final vmIP = await vm.fetchIpAddress;
        final ssh = SSHService();

        final sshClient = await ssh.sshToServer(vmIP);
        if (sshClient == null) {
          _logger.err('ssh client is null');
          continue;
        }

        final macos = MacOSService(
          sshClient: sshClient,
          userData: user,
          jobData: job,
          isFad: isFad,
          icloudKeychainPassword: icloudKeychainPassword,
        );

        await macos.cloneRepository;
        if (isFad) {
          await macos.changeProvisioningProfileFromAppStoreToAdhoc;
        }
        if (isFad) {
          await macos.prepareAdhocExportOptionsPlist;
        } else {
          await macos.prepareAppStoreExportOptionsPlist;
        }

        if (isFad) {
          await macos.createAdhocCertificates;
        } else {
          await macos.createAppStoreCertificates;
        }

        await macos.importCertificates;
        await macos.runCustomScript();
        await macos.buildIpa;
        await macos.decodeAppStoreConnectApiKey;

        if (isFad) {
          await macos.uploadIpaToFad();
        } else {
          await macos.uploadIpaToAppStoreConnect;
        }
        await supabase.incrementBuildNumber(user);

        await supabase.setBuildSuccess(job);
        await vm.stopVM;
        await wait();
      }
    }
  }
}
