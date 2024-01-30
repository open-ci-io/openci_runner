import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dart_firebase_admin/dart_firebase_admin.dart';
import 'package:dart_firebase_admin/firestore.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:openci_runner/src/features/job/domain/job_data.dart';
import 'package:openci_runner/src/features/runner/android/controller/android_job_controller.dart';
import 'package:openci_runner/src/features/runner/runner_arguments.dart';
import 'package:openci_runner/src/features/runner/runner_controller.dart';
import 'package:openci_runner/src/features/user/domain/user_data.dart';
import 'package:openci_runner/src/features/vm/controller/vm_controller.dart';
import 'package:openci_runner/src/services/ssh/ssh_service.dart';
import 'package:openci_runner/src/utilities/future_delayed.dart';
import 'package:openci_runner/src/utilities/github/github_service.dart';
import 'package:uuid/uuid.dart';

const checks = '''
job is null, waiting 10 seconds for next check.
Jobがありません。10秒後に再確認します。
''';

const jobsPath = 'jobs_v2';

class RunnerCommand extends Command<int> {
  RunnerCommand({
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
  String get description => 'Open CI core command';

  @override
  String get name => 'run';

  final Logger _logger;

  @override
  Future<int> run() async {
    final controller = RunnerController(_logger, argResults)
      ..checkArgument(RunnerArguments.firebaseProjectName);
    final arguments = controller.doesArgumentsExist();
    final firebaseProjectName = arguments[1];
    final serviceAccountJsonPath = arguments[3];

    _logger.success('Argument check passed.');

    final admin = FirebaseAdminApp.initializeApp(
      firebaseProjectName,
      Credential.fromServiceAccount(
        File(serviceAccountJsonPath),
      ),
    );

    final firestore = Firestore(admin);

    var isSearching = false;

    Progress? progress;

    while (true) {
      if (isSearching == false) {
        _logger.info('Searching new job');
        progress = _logger.progress('Searching new job');

        isSearching = true;
      }

      final jobsQs = await firestore
          .collection(jobsPath)
          .where('processing', WhereFilter.equal, false)
          .where('success', WhereFilter.equal, false)
          .where('failure', WhereFilter.equal, false)
          .get();
      if (jobsQs.docs.isEmpty && progress != null) {
        progress.update('No jobs were found');

        await wait();
        continue;
      }
      progress!.complete('New job found');
      isSearching = false;
      final jobsData = jobsQs.docs.first.data();
      final jobData = JobData.fromJson(jobsData);
      final targetPlatform = jobData.platform;
      _logger.info('targetPlatform: $targetPlatform');

      await firestore.collection(jobsPath).doc(jobData.documentId).update({
        'processing': true,
      });

      final userDocs =
          await firestore.collection('users').doc(jobData.userId).get();

      if (userDocs.exists == false) {
        _logger.info(checks);
        await wait();
        continue;
      }

      final userData = userDocs.data();
      if (userData == null) {
        _logger.info(checks);
        await wait();
        continue;
      }
      final user = UserData.fromJson(userData);

      final distributionQs = await firestore
          .collection('users')
          .doc(user.userId)
          .collection('distribution')
          .where('platform', WhereFilter.equal, targetPlatform.name)
          .get();

      if (distributionQs.docs.isEmpty) {
        _logger.info(checks);
        await wait();
        continue;
      }
      final distributionList = distributionQs.docs.map((e) {
        final data = e.data();
        return Distribution.fromJson(data);
      }).toList();

      final distribution = distributionList.first;

      if (Platform.isMacOS) {
        final vm = VMController(const Uuid().v4());
        await vm.prepareVM;
        unawaited(vm.launchVM);
        await wait(seconds: 20);
        _logger.success('VM is ready');
        final vmIP = await vm.fetchIpAddress;
        final ssh = SSHService();

        final sshClient = await ssh.sshToServer(vmIP);
        if (sshClient == null) {
          throw Exception('ssh client is null');
        }
        if (targetPlatform == TargetPlatform.android) {
          final androidJobController = AndroidJobController(
            sshService: ssh,
            sshClient: sshClient,
            userData: user,
            jobData: jobData,
            gitHubService: GitHubService(),
            firestore: firestore,
            distribution: distribution,
            vmController: vm,
          );

          if (await androidJobController.cloneRepository == false) {
            _logger.err('clone repository failed');
            continue;
          }

          if (await androidJobController.importServiceAccountJson == false) {
            _logger.err('import service account json failed');
            continue;
          }

          if (await androidJobController.importKeyJks == false) {
            _logger.err('import key jks failed');
            continue;
          }

          if (await androidJobController.importKeyProperties == false) {
            _logger.err('import key properties failed');
            continue;
          }

          if (await androidJobController.changeFlutterVersion == false) {
            _logger.err('changeFlutterVersion failed');
            continue;
          }

          if (await androidJobController.checkFlutterVersion == false) {
            _logger.err('checkFlutterVersion failed');
            continue;
          }

          if (await androidJobController.flutterClean == false) {
            _logger.err('flutter clean failed');
            continue;
          }

          if (await androidJobController.buildApk == false) {
            _logger.err('build apk failed');
            continue;
          }

          if (await androidJobController.uploadApkToFAD == false) {
            _logger.err('upload apk failed');
            continue;
          }

          await firestore
              .collection('users')
              .doc(user.userId)
              .update({'androidBuildNumber': user.androidBuildNumber + 1});

          await firestore
              .collection(jobsPath)
              .doc(jobData.documentId)
              .update({'success': true});

          _logger.success('build success');

          await vm.stopVM;
        } else if (targetPlatform == TargetPlatform.ios) {
          _logger.info('ios');
          await Future.delayed(const Duration(seconds: 10));
          await firestore
              .collection(jobsPath)
              .doc(jobData.documentId)
              .update({'success': true});
          await vm.stopVM;
        }
      }
    }
  }
}