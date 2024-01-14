import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dart_firebase_admin/dart_firebase_admin.dart';
import 'package:dart_firebase_admin/firestore.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:openci_runner/src/features/job/domain/job_data.dart';
import 'package:openci_runner/src/features/runner/android/controller/android_job_controller.dart';
import 'package:openci_runner/src/features/runner/android/controller/android_runner_controller.dart';
import 'package:openci_runner/src/features/runner/android/domain/android_arguments.dart';
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

class AndroidRunnerCommand extends Command<int> {
  AndroidRunnerCommand({
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
  String get description => 'Open CI core command for Android';

  @override
  String get name => 'android_run';

  final Logger _logger;

  @override
  Future<int> run() async {
    final controller = AndroidRunnerController(_logger, argResults)
      ..checkArgument(AndroidArguments.firebaseProjectName);
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
          .collection('jobs')
          .where('processing.android', WhereFilter.equal, false)
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

      await firestore.collection('jobs').doc(jobData.documentId).update({
        'processing.android': true,
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
          .where('platform', WhereFilter.equal, 'android')
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

      if (Platform.isMacOS || Platform.isLinux) {
        final vm = VMController(const Uuid().v4());
        await vm.prepareVM;
        unawaited(vm.launchVM);
        await wait(seconds: 20);
        _logger.success('VM is ready');
        final vmIP = await vm.fetchIpAddress;
        final ssh = SSHService();

        final sshClient = await ssh.sshToServer(vmIP);
        if (sshClient == null) {
          // TODO(mafreud): throw Exception and kill this program.

          _logger.err('ssh client is null');
          continue;
        }

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
          _logger.err('flutter clean failed');
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

        if (await androidJobController.uploadApkToPlayStore == false) {
          _logger.err('upload apk failed');
          continue;
        }

        await firestore
            .collection('users')
            .doc(user.userId)
            .update({'androidBuildNumber': user.androidBuildNumber + 1});

        await firestore
            .collection('jobs')
            .doc(jobData.documentId)
            .update({'success.android': true});

        _logger.success('build success');

        await vm.stopVM;
      }
    }
  }
}
