# Cyber Hayat PK — build

## Tooling
- Flutter 3.24+ / Dart 3.3+
- Android minSdk 21, targetSdk 34
- App version 1.0.0+1

## Commands
```bash
flutter pub get
flutter analyze
flutter test
flutter build apk --release
flutter build appbundle --release
```

Copy `build/app/outputs/flutter-apk/app-release.apk` to `cyber_hayat_pk.apk`.

This sandbox cannot download the Dart/Android SDK (TLS to Google storage and Debian mirrors is blocked).

On GitHub, the workflow `.github/workflows/build-apk.yml` builds `cyber_hayat_pk.apk` as an artifact when the repo is pushed.

Locally, install Flutter 3.24+, then run the commands above.
