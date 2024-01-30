import 'package:openci_runner/src/features/runner/runner.dart';

class RunnerArguments {
  static Runner get firebaseProjectName {
    const key = 'firebaseProjectName';
    const name = 'Firebase Project Name';
    return const Runner(
      key: key,
      error: '''
$name($key) has not been set.
$name($key)を指定してください。,
''',
    );
  }
}
