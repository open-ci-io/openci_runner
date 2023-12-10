import 'package:mason_logger/mason_logger.dart';
import 'package:openci_runner/src/services/shell/shell_service.dart';

class TartService {
  TartService();
  static final _shellService = ShellService();
  final _logger = Logger();

  Future<String> _runShell(String command) => _shellService.runShell(command);

  Future<void> stop(String vmName) => _runShell('tart stop $vmName');

  Future<void> run(String vmName) => _runShell('tart run $vmName');

  Future<void> delete(String vmName) async {
    try {
      await _runShell('tart delete $vmName');
    } catch (e) {
      _logger.warn(e.toString());
    }
  }

  Future<void> clone(String baseVMName, String newVMName) =>
      _runShell('tart clone $baseVMName $newVMName');

  Future<String> ip(String vmName) => _runShell('tart ip $vmName');
}
