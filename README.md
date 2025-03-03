# ani4h_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
````

lib
├── ui
│   ├── core
│   │   ├── ui
│   │   │   └── <shared widgets>
│   │   └── themes
│   ├── <FEATURE NAME>
│   │   ├── view_model
│   │   │   └── <view_model class>.dart
│   │   └── widgets
│   │       ├── <feature name>_screen.dart
│   │       └── <other widgets>
├── domain
│   ├── models
│   │   └── <model name>.dart
├── data
│   ├── repositories
│   │   └── <repository class>.dart
│   ├── services
│   │   └── <service class>.dart
│   └── model
│       └── <api model class>.dart
├── config
├── utils
├── routing
├── main_staging.dart
├── main_development.dart
└── main.dart

// The test folder contains unit and widget tests
test
├── data
├── domain
├── ui
└── utils

// The testing folder contains mocks other classes need to execute tests
testing
├── fakes
└── models

````