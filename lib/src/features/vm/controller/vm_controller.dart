import 'package:openci_runner/src/services/tart/tart_service.dart';
import 'package:openci_runner/src/utilities/future_delayed.dart';

class VMController {
  static final _tartService = TartService();

  static const _workingVMName = 'ventura-flutter-working';

  Future<void> prepareVM() async {
    await _tartService.delete(_workingVMName);
    await _cloneVM;
  }

  Future<void> get _cloneVM async {
    const baseVMName = 'ventura-flutter';

    // TODO(someone): If baseVM does not exist, pull it from the internet.
    await _tartService.clone(baseVMName, _workingVMName);
    await wait(seconds: 1);
  }

  Future<void> get launchVM => _tartService.run(_workingVMName);

  Future<void> get stopVM => _tartService.stop(_workingVMName);

  Future<String> get fetchIpAddress async {
    try {
      final ip = await _tartService.ip(_workingVMName);
      final ipRegex =
          RegExp(r'\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b'); // 正規表現でIPv4をマッチング

      final Iterable<Match> matches = ipRegex.allMatches(ip);

      if (matches.length == 1) {
        print('Found IP Address: ${matches.first.group(0)}');
      } else if (matches.length > 1) {
        print('More than one IP addresses found.');
      } else {
        print('No IP addresses found.');
      }
      return matches.first.group(0)!;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
