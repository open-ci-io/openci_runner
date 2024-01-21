import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dartssh2/dartssh2.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:openci_runner/src/services/ssh/domain/session_result.dart';

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
    final logger = Logger();
    final shell = await client.shell();
    const encoder = Utf8Encoder();
    shell
      ..write(encoder.convert('$command\n'))
      ..write(encoder.convert('exit\n'));
    await stdout.addStream(shell.stdout);
    await stderr.addStream(shell.stderr);

    logger.success('stdout: ${shell.stdout}');
    logger.err('stderr: ${shell.stderr}');
    shell.close();
    if (shell.exitCode == null) {
      return true;
    }
    return shell.exitCode == 0;
  }

  @Deprecated('prefer use runV2')
  Future<bool> run(SSHClient client, String command) async {
    final session = await client.execute(command);
    final logger = Logger();

    final stdout = await session.stdout
        .cast<List<int>>()
        .transform(const Utf8Decoder())
        .join();
    logger.success('stdout: $stdout');

    final stderr = await session.stderr
        .cast<List<int>>()
        .transform(const Utf8Decoder())
        .join();
    logger.err('stderr: $stderr');

    if (stderr.isNotEmpty) {
      return false;
    }
    return true;
  }

  Future<SessionResult> runV2(SSHClient client, String command) async {
    final logger = Logger();

    var sessionStdout = '';
    var sessionStderr = '';
    int? exitCode;

    logger.info('command: $command');
    final session = await client.execute(command);
    await session.stdin.close();
    await session.done;
    exitCode = session.exitCode;
    sessionStdout = await streamToString(session.stdout);
    sessionStderr = await streamToString(session.stderr);
    logger.success('session.stdout: $sessionStdout');
    logger.err('session.stderr: $sessionStderr');
    logger.info(session.exitCode.toString());

    return SessionResult(
      sessionExitCode: exitCode,
      sessionStdout: sessionStdout,
      sessionStderr: sessionStderr,
    );
  }

  Future<String> streamToString(Stream<Uint8List> stream) async {
    final bytes = await stream.fold<List<int>>(
      [],
      (previous, element) => previous..addAll(element),
    );

    return utf8.decode(bytes);
  }
}
