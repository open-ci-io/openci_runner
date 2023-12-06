import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';

class RunnerCommand extends Command<int> {
  /// {@macro sample_command}
  RunnerCommand({
    required Logger logger,
  }) : _logger = logger {
    argParser.addFlag(
      'cyan',
      abbr: 'c',
      help: 'Prints the same joke, but in cyan',
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
    print('test');

    // return error
    // return ExitCode.software.code;

    return ExitCode.success.code;
  }
}
