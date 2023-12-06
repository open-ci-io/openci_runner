import 'dart:convert';

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

  Future<void> sshShell({
    required SSHClient sshClient,
    required String command,
  }) async {
    try {
      final res = await sshClient.run(command);
      print(utf8.decode(res));
    } catch (e) {
      print(e);
    }
  }
}
