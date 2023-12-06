import 'dart:async';

import 'package:mason_logger/mason_logger.dart';
import 'package:openci_runner/src/api_keys/api_keys.dart';
import 'package:sentry/sentry.dart';

class SentryService {
  static final _logger = Logger();
  Future<void> get initialize async {
    await Sentry.init((options) {
      options
        ..dsn = sentryDsn
        ..tracesSampleRate = 1.0;
    });
  }

  Future<void> captureExceptionBySentry(
    Object? error,
    StackTrace? stackTrace,
  ) async {
    _logger.err(error.toString());
    unawaited(
      Sentry.captureException(
        error,
        stackTrace: stackTrace,
      ),
    );
  }
}
