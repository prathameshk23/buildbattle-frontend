# BuildBattle Frontend Setup

## Prerequisites

- Flutter SDK 3.19 or newer
- Dart 3.3 or newer
- Android Studio for Android builds
- Xcode and CocoaPods for iOS builds

## Clone & Install

From `buildbattle_frontend`:

```sh
flutter pub get
```

## Environment Config

The app reads the backend URL from `lib/core/config/env.dart`. For local development, either edit the default value there or pass it at runtime:

```sh
flutter run --dart-define=API_BASE_URL=http://localhost:3000
```

## Code Generation

Riverpod code generation dependencies are included. Run generation after adding `@riverpod` providers:

```sh
dart run build_runner build --delete-conflicting-outputs
```

## iOS Setup

`ios/Runner/Info.plist` already includes:

- `NSCameraUsageDescription`
- `NSMotionUsageDescription`

Then install pods:

```sh
cd ios
pod install
```

For HealthKit, open the Runner target in Xcode, add the HealthKit capability, and configure the required entitlement for step syncing.

## Android Setup

`android/app/src/main/AndroidManifest.xml` already includes:

- `android.permission.CAMERA`
- `android.permission.ACTIVITY_RECOGNITION`

The Android min SDK is set to `21` in `android/app/build.gradle.kts`.

## HealthKit / Google Fit

- iOS: enable HealthKit in Signing & Capabilities, then request step read permissions in the native health integration.
- Android: keep `ACTIVITY_RECOGNITION` enabled and configure Google Fit/OAuth consent for the package name used by release builds.

## Run

```sh
flutter run
```
