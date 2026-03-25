# LoyaltyLink – Flutter Project Structure Exploration

## Sprint #2 – Folder Structure Documentation  
**Technology Stack:** Flutter + Firebase

---

## Project Description

This document summarizes the Flutter folder structure exploration for the **LoyaltyLink** project. A detailed breakdown of every folder and file is available in [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md).

---

## Folder Structure Overview

```
loyalty_link/
├── lib/                          # Core Dart code (screens, widgets, services, models)
│   ├── main.dart                 # Entry point – Firebase init, auth routing
│   ├── screens/                  # UI screens (welcome, login, signup, dashboard)
│   ├── widgets/                  # Reusable UI components
│   ├── models/                   # Data classes
│   └── services/                 # Firebase Auth & Firestore services
├── android/                      # Android build config, google-services.json
├── ios/                          # iOS build config, Info.plist
├── web/                          # Web config, index.html
├── test/                         # Automated widget tests
├── pubspec.yaml                  # Dependencies & project metadata
├── firebase.json                 # Firebase project config
└── .gitignore                    # Files excluded from Git
```

For a detailed explanation of each folder and file, see 👉 [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md)

---

## Key Folders Explained

| Folder | Role |
|--------|------|
| `lib/` | All Dart application code — screens, widgets, models, services. `main.dart` is the entry point. |
| `lib/screens/` | One widget per screen. Currently: welcome, responsive home, login, signup, dashboard. |
| `lib/services/` | Business logic isolated from UI — `auth_service.dart` and `firestore_service.dart`. |
| `android/` | Gradle build scripts, `AndroidManifest.xml`, `google-services.json` for Firebase. |
| `ios/` | Xcode project files, `Info.plist` for permissions and metadata. |
| `test/` | Widget and unit tests using Flutter's testing framework. |
| `pubspec.yaml` | Manages dependencies (`firebase_core`, `firebase_auth`, `cloud_firestore`), assets, and fonts. |

---

## IDE Folder Structure Screenshot

*(Add your screenshot here: open the project in VS Code or Android Studio, expand the folder tree, and take a screenshot)*

![Folder Structure in IDE](loyalty_link/screenshots/folder_structure_ide.png)

---

## Reflection

### Why is it important to understand each folder's role?

- **Efficiency** — knowing where files belong saves time when adding features or debugging
- **Consistency** — the team follows the same conventions, making PRs predictable
- **Platform isolation** — `android/`, `ios/`, `web/` folders keep platform config separate from shared Dart code in `lib/`

### How does a clean structure help in a team environment?

- **Parallel development** — UI developer works in `screens/`, backend developer in `services/`, with minimal merge conflicts
- **Code reviews** — changes are scoped to specific folders, making reviews faster
- **Onboarding** — new members understand the codebase structure immediately from folder names
- **Scalability** — adding a new feature follows the same pattern: add a screen, reuse widgets, call services

---

## Related Files

- [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) – Detailed folder and file explanations