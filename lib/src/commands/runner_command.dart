import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:openci_runner/src/features/sign_in/controller/sign_in_controller.dart';
import 'package:openci_runner/src/features/sign_in/domain/sign_in.dart';
import 'package:openci_runner/src/features/vm/controller/vm_controller.dart';
import 'package:openci_runner/src/services/github/github_service.dart';
import 'package:openci_runner/src/services/ssh/ssh_service.dart';
import 'package:openci_runner/src/services/supabase/supabase_service.dart';

class RunnerCommand extends Command<int> {
  RunnerCommand({
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
      );
  }

  @override
  String get description => 'Open CI core command';

  @override
  String get name => 'run';

  final Logger _logger;

  @override
  Future<int> run() async {
    if (argResults?['supabaseUrl'] == false) {
      _logger.err('''
Supabase URL(supabaseUrl) has not been set.
Supabase URL(supabaseUrl)を指定してください。,
        ''');
      return ExitCode.software.code;
    }

    if (argResults?['supabaseApiKey'] == false) {
      _logger.err('''
Supabase API KEY(supabaseApiKey) has not been set. 
Supabase API KEY(supabaseApiKey)を指定してください。,
        ''');
      return ExitCode.software.code;
    }
    if (argResults?['supabaseSignInEmail'] == false) {
      _logger.err('''
Supabase Sign In Email(supabaseSignInEmail) has not been set.
Supabase Sign In Email(supabaseSignInEmail)を指定してください。,
        ''');
      return ExitCode.software.code;
    }
    if (argResults?['supabaseSignInPassword'] == false) {
      _logger.err('''
Supabase Sign In Password(supabaseSignInPassword) has not been set.
Supabase Sign In Password(supabaseSignInPassword)を指定してください。,
        ''');
      return ExitCode.software.code;
    }
    final arguments = argResults?.arguments;
    if (arguments == null) {
      throw Exception('Command Arguments are null.');
    }

    final supabaseUrl = arguments[1];
    final supabaseApiKey = arguments[3];
    final supabaseSignInEmail = arguments[5];
    final supabaseSignInPassword = arguments[7];

    final supabase = SupabaseService(
      supabaseUrl: supabaseUrl,
      supabaseApiKey: supabaseApiKey,
    );

    while (true) {
      final signInController = SignInController();
      final job = await signInController.fetchJob(
        supabase: supabase,
        signIn: SignIn(
          email: supabaseSignInEmail,
          password: supabaseSignInPassword,
        ),
      );
      if (job == null) {
        print('job is null');
        await Future<void>.delayed(const Duration(seconds: 10));
        continue;
      }
      final user = await signInController.signIn(job, supabase);
      if (user == null) {
        continue;
      }
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
        print('launching VM');
        await Future<void>.delayed(const Duration(seconds: 20));
        final vmIP = await vm.fetchIpAddress;
        final ssh = SSHService();

        final sshClient = await ssh.sshToServer(vmIP);
        if (sshClient == null) {
          print('ssh client is null');
          continue;
        }
        final github = GitHubService();
        final url = github.convertUrl(
          user.github_repository_url,
          job.github_personal_access_token,
        );
        print('url: $url');
        await Future.delayed(const Duration(seconds: 10));
      }
    }

    // return error
    // return ExitCode.software.code;

    return ExitCode.success.code;
  }
}
