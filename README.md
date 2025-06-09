# ani4h\_app

A modern Flutter application using Riverpod for state management and Freezed for data modeling.

---

## 📁 Prerequisites

Make sure you have the following installed:

* [Flutter SDK](https://docs.flutter.dev/get-started/install) (version `>=3.x.x`)
* Android Studio or VS Code
* A device or emulator (Android/iOS/Chrome)

---

## 📦 1. Install Dependencies

```bash
flutter pub get
```

---

## 🧪 2. Run Code Generation

The project uses `freezed`, so code generation is required:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

For continuous development:

```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

---

## 📱 3. Run the App

To launch the app:

```bash
flutter run
```

To target a specific platform:

```bash
flutter run -d android
flutter run -d ios
flutter run -d chrome
```

---

## 🪠 4. Clean Build (Optional)

Run this if you encounter build issues:

```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## 📅 Project Structure Overview

```text
lib
├── common
├── core
├── features
│   ├── feature
│   │   ├── application
│   │   ├── data
│   │   │   ├── dto
│   │   │   ├── repository
│   │   │   └── source
│   │   ├── domain
│   │   │   ├── mapper
│   │   │   └── model
│   │   └── presentation
│   │       ├── controller
│   │       ├── state
│   │       └── ui
├── config
├── utils
├── routing
├── main.dart
├── main_development.dart
└── main_staging.dart

test
├── data
├── domain
├── ui
└── utils

testing
├── fakes
└── models
```
