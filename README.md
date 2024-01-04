## Getting Started 🚀

Activate globally via:

```sh
dart pub global activate openci_runner
```

## Usage

1. Create Firebase Project

2. Download Firebase's service account json

3. Run openci_runner

```sh
# iOS build
$ openci_runner ios_run -p "firebase-project-id" -s /path/to/firebase_service_account.json

# Android build
$ openci_runner android_run -p "firebase-project-id" -s /path/to/firebase_service_account.json

# Show CLI version
$ openci_runner --version

# Show usage help
$ openci_runner --help
```
