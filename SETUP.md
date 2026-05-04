# BuildBattle Frontend Setup

## Prerequisites

- Flutter SDK matching `pubspec.yaml` (`sdk: ^3.11.5`)
- Dart from that Flutter SDK
- Android Studio for Android builds
- Xcode and CocoaPods for iOS builds
- Backend running at `http://localhost:3000`
- LM Studio running only if you want AI food photo scan

## Clone & Install

From `buildbattle_frontend`:

```sh
flutter pub get
```

## Environment Config

The app reads the backend URL from `lib/core/config/env.dart`. Pass it at runtime:

```sh
flutter run --dart-define=API_BASE_URL=http://localhost:3000
```

Android emulator cannot reach your laptop through `localhost`. Use:

```sh
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:3000
```

iOS simulator can usually use `http://localhost:3000`.

## Auth

The app now uses real email/password auth through backend `POST /auth/login` and `POST /auth/register`. For development, disable Supabase email confirmation or confirm the user before signing in.

## Food Scan

Diary > add food > camera tab sends selected photo bytes to backend `POST /food/scan`. Backend forwards the image to LM Studio. Use a vision-capable local model in LM Studio.

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
