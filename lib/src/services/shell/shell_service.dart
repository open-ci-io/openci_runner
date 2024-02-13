import 'package:mason_logger/mason_logger.dart';
import 'package:process_run/shell.dart';

class ShellService {
  Future<String> runShell(String command) async {
    final shell = Shell();
    final logger = Logger();

    await shell.run('echo $command');
    final result = await shell.run(command);
    final stdout = result.first.stdout.toString();
    logger.info(stdout);
    return stdout;
  }
}
