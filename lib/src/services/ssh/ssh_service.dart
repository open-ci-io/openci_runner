import 'dart:convert';
import 'dart:io';

import 'package:dartssh2/dartssh2.dart';

class SSHService {
  Future<SSHClient?> sshToServer(
    String vmIp, {
    String username = 'admin',
    String password = 'admin',
  }) async {
    try {
      return SSHClient(
        await SSHSocket.connect(vmIp, 22),
        username: username,
        onPasswordRequest: () => password,
      );
    } catch (e) {
      print(e);
      return null;
    }
  }

  @Deprecated('use run()')
  Future<bool> shell(String command, SSHClient client) async {
    final shell = await client.shell();
    const encoder = Utf8Encoder();
    shell
      // ignore: prefer_interpolation_to_compose_strings
      ..write(encoder.convert(command + '\n'))
      ..write(encoder.convert('exit\n'));
    await stdout.addStream(shell.stdout);
    await stderr.addStream(shell.stderr);
    print('exitCode: ${shell.exitCode}');
    shell.close();
    if (shell.exitCode == null) {
      return true;
    }
    return shell.exitCode == 0;
  }

  Future<bool> run(SSHClient client, String command) async {
    final session = await client.execute(command);

    final stdout = await session.stdout
        .cast<List<int>>()
        .transform(const Utf8Decoder())
        .join();
    print('stdout:$stdout');

    final stderr = await session.stderr
        .cast<List<int>>()
        .transform(const Utf8Decoder())
        .join();
    print('stderr:$stderr');
    if (stderr.isNotEmpty) {
      return false;
    }
    return true;
  }

  @Deprecated('use shell method')
  Future<String> sshShell({
    required SSHClient sshClient,
    required String command,
  }) async {
    try {
      final res = await sshClient.run(command);
      print(utf8.decode(res));

      return utf8.decode(res);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
