import 'package:mason_logger/mason_logger.dart';
import 'package:openci_runner/src/services/tart/tart_service.dart';

class VMController {
  VMController(this.workingVMName);
  final String workingVMName;
  Logger logger = Logger();

  static final _tartService = TartService();

  Future<void> get prepareVM => _cloneVM;

  Future<void> get _cloneVM async {
    const baseVMName = 'ventura-flutter';

    // TODO(someone): If baseVM does not exist, pull it from the internet.
    await _tartService.clone(baseVMName, workingVMName);
    await Future<void>.delayed(const Duration(seconds: 10));
  }

  Future<void> get launchVM => _tartService.run(workingVMName);

  Future<void> get stopVM async {
    await _tartService.stop(workingVMName);
    await _tartService.delete(workingVMName);
  }

  Future<String> get fetchIpAddress async {
    try {
      final ip = await _tartService.ip(workingVMName);
      final ipRegex =
          RegExp(r'\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b'); // 正規表現でIPv4をマッチング

      final Iterable<Match> matches = ipRegex.allMatches(ip);

      if (matches.length == 1) {
        logger.info('Found IP Address: ${matches.first.group(0)}');
      } else if (matches.length > 1) {
        logger.warn('More than one IP addresses found.');
      } else {
        logger.alert('No IP addresses found.');
      }
      return matches.first.group(0)!;
    } catch (e) {
      logger.err(e.toString());
      rethrow;
    }
  }
}
