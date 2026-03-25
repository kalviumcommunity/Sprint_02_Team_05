# Flutter Project Structure – LoyaltyLink

## Introduction

Flutter uses a well-organized directory structure that separates platform-specific code, application logic, and configuration files. Understanding this structure is critical for building scalable, maintainable apps — especially when working in teams where each member may own different layers of the application.

This document explains every key folder and file in the **LoyaltyLink** Flutter project.

---

## Folder Hierarchy

```
loyalty_link/
├── lib/                             # 🎯 Core application code (Dart)
│   ├── main.dart                    #    App entry point, Firebase init, routing
│   ├── firebase_options.dart        #    Generated Firebase config (FlutterFire CLI)
│   ├── screens/                     #    Individual UI screens
│   │   ├── welcome_screen.dart      #       Welcome/onboarding screen
│   │   ├── responsive_home.dart     #       Responsive dashboard layout
│   │   ├── signup_screen.dart       #       Firebase Auth sign-up
│   │   ├── login_screen.dart        #       Firebase Auth login
│   │   └── dashboard_screen.dart    #       Customer CRUD with Firestore
│   ├── widgets/                     #    Reusable UI components
│   ├── models/                      #    Data classes (User, Customer, Reward)
│   └── services/                    #    Business logic & API integration
│       ├── auth_service.dart        #       Firebase Authentication service
│       └── firestore_service.dart   #       Firestore CRUD operations
│
├── android/                         # 🤖 Android platform configuration
│   ├── app/
│   │   ├── build.gradle             #    App-level build config (name, version, deps)
│   │   ├── google-services.json     #    Firebase config for Android
│   │   └── src/main/AndroidManifest.xml  # Permissions & app metadata
│   └── build.gradle                 #    Project-level Gradle config
│
├── ios/                             # 🍎 iOS platform configuration
│   └── Runner/
│       └── Info.plist               #    App metadata, permissions, icons for iOS
│
├── web/                             # 🌐 Web platform configuration
│   ├── index.html                   #    HTML entry point for Flutter web
│   └── manifest.json                #    PWA manifest
│
├── test/                            # 🧪 Automated tests
│   └── widget_test.dart             #    Widget/unit test file
│
├── assets/                          # 📁 Static files (images, fonts, JSON)
│   └── (manually created as needed)
│
├── pubspec.yaml                     # 📦 Dependencies, assets, fonts, metadata
├── pubspec.lock                     #    Locked dependency versions
├── firebase.json                    #    Firebase project config
├── .gitignore                       #    Files/folders Git should ignore
├── README.md                        #    Project documentation
└── build/                           #    Auto-generated compiled builds (do not edit)
```

---

## Folder & File Details

| Folder/File | Purpose |
|-------------|---------|
| **`lib/`** | Core application code. All Dart files live here — screens, widgets, models, services. The `main.dart` file is the entry point where `runApp()` is called. |
| **`lib/screens/`** | One file per screen. Each screen is a self-contained widget. Clean separation makes navigation and routing easy to manage. |
| **`lib/widgets/`** | Reusable UI components shared across multiple screens (e.g., custom buttons, cards). Avoids code duplication. |
| **`lib/models/`** | Data structure classes (e.g., `Customer`, `Reward`). Decouples data shapes from UI logic. |
| **`lib/services/`** | Business logic, Firebase Auth, Firestore CRUD, and API integrations. Isolating services makes it easy to swap backends or mock for testing. |
| **`android/`** | Android-specific build config. Contains Gradle scripts, `AndroidManifest.xml` for permissions, and `google-services.json` for Firebase. |
| **`ios/`** | iOS-specific build config. Works with Xcode. `Info.plist` defines app metadata, permissions, and icon settings. |
| **`web/`** | Web platform files. `index.html` is the HTML shell that loads the Flutter web app. |
| **`test/`** | Automated tests. `widget_test.dart` verifies UI and logic using Flutter's testing framework. |
| **`assets/`** | Manually created folder for images, fonts, and static data. Must be declared in `pubspec.yaml` under `flutter: assets:`. |
| **`pubspec.yaml`** | The most important config file. Manages dependencies, assets, fonts, app version, and SDK constraints. |
| **`.gitignore`** | Lists files Git should ignore — `build/`, `.dart_tool/`, platform-specific caches, env files. |
| **`build/`** | Auto-generated compiled output. Never edit manually — regenerated on every `flutter build` or `flutter run`. |
| **`.dart_tool/`** | Dart tooling cache. Auto-generated, should not be committed. |

---

## How pubspec.yaml Works

```yaml
# Project metadata
name: loyalty_link
version: 1.0.0+1

# Dart SDK version constraint
environment:
  sdk: ^3.11.3

# App dependencies
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^3.0.0        # Firebase initialization
  firebase_auth: ^5.0.0        # Authentication
  cloud_firestore: ^5.0.0      # Database

# Dev/test dependencies
dev_dependencies:
  flutter_test:
    sdk: flutter

# Asset declarations (example)
flutter:
  uses-material-design: true
  # assets:
  #   - assets/images/
  #   - assets/fonts/
```

---

## How the Structure Supports Scalability & Teamwork

### Scalability
- **Modular folders** (`screens/`, `widgets/`, `services/`) let you add features without touching unrelated code
- Adding a new screen = adding one file in `screens/` and composing existing widgets/services
- Platform folders (`android/`, `ios/`, `web/`) are isolated — platform-specific changes don't affect Dart code

### Teamwork
- **Clear ownership** — one developer can own `services/`, another `screens/`, without merge conflicts
- **Consistent naming** (`snake_case` files, `PascalCase` classes) makes files predictable and searchable
- **Separation of concerns** — UI developers work in `screens/` and `widgets/`, backend logic lives in `services/`

### Cross-Platform Build System
```
lib/ (shared Dart code)
 │
 ├── android/  → Gradle builds APK/AAB
 ├── ios/      → Xcode builds IPA
 └── web/      → Dart compiles to JavaScript
```

Flutter compiles the **same `lib/` code** to native ARM for Android, native ARM for iOS, and JavaScript for web. Platform folders only contain config — not app logic.

---

## Reflection

Understanding the folder structure is the **foundation of productive Flutter development**:

1. **Faster debugging** — knowing where each file lives means finding bugs quickly
2. **Clean PRs** — changes are scoped to specific folders, making code reviews easier
3. **Onboarding** — new team members can understand the codebase by reading the folder names alone
4. **Future-proofing** — adding Firebase, state management, or new screens follows the same pattern every time
