import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dart_firebase_admin/dart_firebase_admin.dart';
import 'package:dart_firebase_admin/firestore.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:openci_runner/src/features/job/domain/job_data.dart';
import 'package:openci_runner/src/features/runner/android/controller/android_job_controller.dart';
import 'package:openci_runner/src/features/runner/ios_job_controller.dart';
import 'package:openci_runner/src/features/runner/runner_arguments.dart';
import 'package:openci_runner/src/features/runner/runner_controller.dart';
import 'package:openci_runner/src/features/user/domain/user_data.dart';
import 'package:openci_runner/src/features/vm/controller/vm_controller.dart';
import 'package:openci_runner/src/services/ssh/ssh_service.dart';
import 'package:openci_runner/src/utilities/future_delayed.dart';
import 'package:openci_runner/src/utilities/github/github_service.dart';
import 'package:process_run/shell.dart';
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

        await Future<void>.delayed(const Duration(seconds: 10));
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
        final vmId = const Uuid().v4();
        final vm = VMController(vmId);
        await vm.cloneVM;
        unawaited(vm.launchVM);
        while (true) {
          final shell = Shell();
          List<ProcessResult>? result;
          try {
            result = await shell.run('tart ip $vmId');
          } catch (e) {
            result = null;
          }
          if (result != null) {
            break;
          }
          await Future<void>.delayed(const Duration(seconds: 1));
        }
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
          final iosJobController = IosJobController(
            sshService: ssh,
            sshClient: sshClient,
            userData: user,
            jobData: jobData,
            gitHubService: GitHubService(),
            firestore: firestore,
            distribution: distribution,
            vmController: vm,
          );

          if (user.buildCertificateBase64 == null ||
              user.exportOptionsAdhoc == null ||
              user.buildProvisioningProfileBase64 == null) {
            _logger.err('ios setup has not been finished');
            await firestore
                .collection(jobsPath)
                .doc(jobData.documentId)
                .update({
              'failure': true,
            });
            continue;
          }

          if (await iosJobController.cloneRepository == false) {
            _logger.err('clone repository failed');
            continue;
          }

          if (await iosJobController.importServiceAccountJson == false) {
            _logger.err('import service account json failed');
            continue;
          }

          if (await iosJobController.importAdhocExportOptionsPlist == false) {
            _logger.err('importAdhocExportOptionsPlist failed');
            continue;
          }

          if (await iosJobController.createAdhocCertificates == false) {
            _logger.err('createAdhocCertificates failed');
            continue;
          }

          if (await iosJobController.createAdhocMobileProvisioningProfile ==
              false) {
            _logger.err('createAdhocMobileProvisioningProfile failed');
            continue;
          }

          if (await iosJobController.importCertificates == false) {
            _logger.err('importCertificates failed');
            continue;
          }
          if (await iosJobController.importP8 == false) {
            _logger.err('importP8 failed');
            continue;
          }

          if (await iosJobController.runCustomScript == false) {
            _logger.err('runCustomScript failed');
            continue;
          }

          if (await iosJobController.buildIpa == false) {
            _logger.err('buildIpa failed');
            continue;
          }

          if (distribution.distribution == 'fad') {
            if (await iosJobController.uploadIpaToFAD == false) {
              _logger.err('uploadIpaToFAD failed');
              continue;
            }
          }

          if (distribution.distribution == 'testFlight') {
            if (await iosJobController.uploadIpaToTestFlight == false) {
              _logger.err('uploadIpaToTestFlight failed');
              continue;
            }
          }

          await firestore
              .collection('users')
              .doc(user.userId)
              .update({'iosBuildNumber': user.iosBuildNumber + 1});

          await firestore
              .collection(jobsPath)
              .doc(jobData.documentId)
              .update({'success': true});

          _logger.success('build success');

          await vm.stopVM;
        }
      }
    }
  }
}
