import 'package:openci_runner/src/services/shell/shell_service.dart';

class TartService {
  static final _shellService = ShellService();

  Future<String> _runShell(String command) => _shellService.runShell(command);

  Future<void> stop(String vmName) => _runShell('tart stop $vmName');

  Future<void> run(String vmName) => _runShell('tart run $vmName');

  Future<void> delete(String vmName) => _runShell('tart delete $vmName');

  Future<void> clone(String baseVMName, String newVMName) =>
      _runShell('tart clone $baseVMName $newVMName');

  Future<String> ip(String vmName) => _runShell('tart ip $vmName');
}
