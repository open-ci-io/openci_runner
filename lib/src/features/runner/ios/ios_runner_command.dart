import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:openci_runner/src/features/runner/ios/controller/ios_runner_controller.dart';
import 'package:openci_runner/src/features/runner/ios/domain/ios_arguments.dart';

class IosRunnerCommand extends Command<int> {
  IosRunnerCommand({
    required Logger logger,
  }) : _logger = logger {
    argParser
      ..addFlag(
        'firebaseProjectName',
        help: 'Firebase Project Name',
        abbr: 'p',
        negatable: false,
      )
      ..addFlag(
        'firebaseServiceAccountJson',
        help: 'Firebase Service Account Json file Path',
        abbr: 's',
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
    final controller = IosRunnerController(_logger, argResults)
      ..checkArgument(IosArguments.supabaseUrl)
      ..checkArgument(IosArguments.supabaseApiKey)
      ..checkArgument(IosArguments.supabaseSignInEmail)
      ..checkArgument(IosArguments.supabaseSignInPassword)
      ..checkArgument(IosArguments.icloudKeychainPassword);
    final arguments = controller.doesArgumentsExist();
    final supabaseUrl = arguments[1];
    final supabaseApiKey = arguments[3];
    final supabaseSignInEmail = arguments[5];
    final supabaseSignInPassword = arguments[7];
    // final icloudKeychainPassword = arguments[9];

    _logger.success('Argument check passed.');

    while (true) {
      // final user = await signInController.signIn(job, supabase);

      if (Platform.isMacOS) {
        // final baseBranch = job.base_branch;
        // final distribution = user.distribution!
        //     .where((element) => element.base_branch == baseBranch)
        //     .first;
        // var isFad = false;
        // if (distribution.distribution == 'firebase_app_distribution') {
        //   isFad = true;
        // }
        // final vm = VMController(const Uuid().v4());
        // await vm.prepareVM;
        // unawaited(vm.launchVM);
        // await wait(seconds: 20);
        // _logger.info('VM is ready');
        // final vmIP = await vm.fetchIpAddress;
        // final ssh = SSHService();

        // final sshClient = await ssh.sshToServer(vmIP);
        // if (sshClient == null) {
        //   _logger.err('ssh client is null');
        //   continue;
        // }

        // final macos = MacOSService(
        //   sshClient: sshClient,
        //   userData: user,
        //   jobData: job,
        //   isFad: isFad,
        //   icloudKeychainPassword: icloudKeychainPassword,
        //   supabaseService: supabase,
        // );

        // await macos.cloneRepository;
        // if (isFad) {
        //   await macos.changeProvisioningProfileFromAppStoreToAdhoc;
        // }
        // if (isFad) {
        //   await macos.prepareAdhocExportOptionsPlist;
        // } else {
        //   await macos.prepareAppStoreExportOptionsPlist;
        // }

        // if (isFad) {
        //   await macos.createAdhocCertificates;
        // } else {
        //   await macos.createAppStoreCertificates;
        // }

        // await macos.importCertificates;
        // await macos.runCustomScript();
        // await macos.buildIpa;
        // await macos.decodeAppStoreConnectApiKey;

        // if (isFad) {
        //   await macos.uploadIpaToFad();
        // } else {
        //   await macos.uploadIpaToAppStoreConnect;
        // }
        // await supabase.incrementBuildNumber(user);

        // await supabase.setBuildSuccess(job);
        // await vm.stopVM;
        // await wait();
      }
    }
  }
}
