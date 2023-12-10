import 'package:openci_runner/src/features/runner/domain/runner.dart';

class Arguments {
  static Runner get supabaseUrl {
    const key = 'supabaseUrl';
    const name = 'Supabase URL';
    return const Runner(
      key: key,
      error: '''
$name($key) has not been set.
$name($key)を指定してください。,
''',
    );
  }

  static Runner get supabaseApiKey {
    const key = 'supabaseApiKey';
    const name = 'Supabase API KEY';
    return const Runner(
      key: key,
      error: '''
$name($key) has not been set.
$name($key)を指定してください。,
''',
    );
  }

  static Runner get supabaseSignInEmail {
    const key = 'supabaseSignInEmail';
    const name = 'Supabase Sign In Email';
    return const Runner(
      key: key,
      error: '''
$name($key) has not been set.
$name($key)を指定してください。,
''',
    );
  }

  static Runner get supabaseSignInPassword {
    const key = 'supabaseSignInPassword';
    const name = 'Supabase Sign In Password';
    return const Runner(
      key: key,
      error: '''
$name($key) has not been set.
$name($key)を指定してください。,
''',
    );
  }

  static Runner get icloudKeychainPassword {
    const key = 'icloudKeychainPassword';
    const name = 'iCloud Keychain Password';
    return const Runner(
      key: key,
      error: '''
$name($key) has not been set.
$name($key)を指定してください。,
''',
    );
  }
}
