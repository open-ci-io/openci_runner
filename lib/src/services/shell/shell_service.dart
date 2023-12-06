import 'package:process_run/shell.dart';

class ShellService {
  Future<String> runShell(String command) async {
    final shell = Shell();

    await shell.run('echo $command');
    final result = await shell.run(command);
    final stdout = result.first.stdout.toString();
    print(stdout);
    return stdout;
  }
}
