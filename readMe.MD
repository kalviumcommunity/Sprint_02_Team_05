# LoyaltyLink – Digital Loyalty App for Small Businesses

## Sprint #2 Project Plan  
**Technology Stack:** Flutter + Firebase

---

## Project Description

**LoyaltyLink** is a mobile application built with Flutter and Firebase that helps small businesses in Tier-2 and Tier-3 towns manage digital loyalty programs. It replaces traditional paper punch cards with a modern, mobile-first loyalty experience — enabling businesses to track repeat customers, assign loyalty points, and create reward programs.

---

## Demo

### Welcome Screen – Initial State
![Welcome Screen - Initial](loyalty_link/screenshots/welcome_initial.png)

### Welcome Screen – After Tapping "Get Started"
![Welcome Screen - Joined](loyalty_link/screenshots/welcome_joined.png)

The Welcome screen features:
- A **gradient background** (purple → dark navy)
- A **loyalty tag icon** that transforms into a **green heart** on interaction
- **Animated text transitions** between "Welcome to LoyaltyLink" and "Welcome aboard! 🎉"
- A **stateful button** that toggles between "Get Started" and "Joined ✓"

---

## Responsive Layout Demo

### Phone Portrait (390 × 844px)
![Phone Portrait](loyalty_link/screenshots/responsive_phone_portrait.png)

- Single-column layout with 2-column stats grid
- Quick Actions wrap horizontally
- Bottom navigation bar with 4 tabs

### Phone Landscape (844 × 390px)
![Phone Landscape](loyalty_link/screenshots/responsive_phone_landscape.png)

- Layout adapts to wide two-column format with Recent Activity side panel
- Stats grid uses horizontal space with side-by-side content
- Settings icon appears in AppBar (tablet/landscape mode)

### Tablet (1024 × 768px)
![Tablet](loyalty_link/screenshots/responsive_tablet.png)

- Two-column layout: Stats + Quick Actions on left, Recent Activity on right
- Larger padding and font sizes for comfortable reading
- Settings icon visible in AppBar

---

## Responsive Design – Code Snippets

### MediaQuery for Device Detection

```dart
// Detect screen dimensions and orientation
final screenWidth = MediaQuery.of(context).size.width;
final screenHeight = MediaQuery.of(context).size.height;
final isTablet = screenWidth > 600;
final isLandscape = screenWidth > screenHeight;

// Dynamically adjust sizing
final titleSize = isTablet ? 28.0 : 22.0;
final subtitleSize = isTablet ? 16.0 : 13.0;
final cardPadding = isTablet ? 20.0 : 14.0;
final horizontalPadding = isTablet ? 32.0 : 16.0;
```

### LayoutBuilder for Constraint-Based Layout Switching

```dart
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth > 800) {
      return _buildWideLayout(...);      // Two-column with side panel
    } else if (constraints.maxWidth > 600) {
      return _buildMediumLayout(...);    // Single column, 2-col grid
    } else {
      return _buildNarrowLayout(...);    // Phone layout
    }
  },
)
```

### Adaptive Widgets Used

| Widget | Purpose |
|--------|---------|
| `Expanded` + `Flexible` | Distribute space in Row/Column layouts proportionally |
| `FittedBox` | Scale text down to fit available width without overflow |
| `Wrap` | Auto-wrap Quick Action buttons onto new rows on narrow screens |
| `GridView.builder` | Responsive stats grid (2-col on phone, 4-col in landscape) |
| `LayoutBuilder` | Choose between narrow (<600px), medium (600-800px), and wide (>800px) layouts |
| `MediaQuery` | Detect screen width, height, and orientation for dynamic sizing |
| `AspectRatio` via `childAspectRatio` | Control stat card proportions across screen sizes |

---

## Folder Structure

```
loyalty_link/
├── lib/
│   ├── main.dart          # Entry point – initializes MaterialApp & loads screens
│   ├── screens/           # Individual UI screens (one file per screen)
│   │   ├── welcome_screen.dart      # Welcome/onboarding screen with stateful interaction
│   │   └── responsive_home.dart     # Responsive dashboard with MediaQuery & LayoutBuilder
│   ├── widgets/           # Reusable UI components (custom buttons, cards, etc.)
│   ├── models/            # Data structures / classes (User, Customer, Reward)
│   └── services/          # Business logic, Firebase integration, API calls
├── test/
│   └── widget_test.dart   # Widget tests for UI verification
├── android/               # Android-specific configuration and build files
├── ios/                   # iOS-specific configuration (Xcode project)
├── web/                   # Web-specific configuration (index.html, manifest)
├── screenshots/           # App screenshots for documentation
├── pubspec.yaml           # Project dependencies and metadata
└── README.md              # Project documentation
```

### How This Structure Supports Modular App Design

| Directory | Purpose |
|-----------|---------|
| `lib/screens/` | Each screen is a self-contained widget in its own file. This makes navigation and routing straightforward as the app grows. |
| `lib/widgets/` | Shared UI components (e.g., a branded button or loyalty card widget) are extracted here to avoid duplication across screens. |
| `lib/models/` | Dart classes that define data shapes (e.g., `Customer`, `Reward`). Keeping models separate decouples data from UI. |
| `lib/services/` | Firebase Auth, Firestore CRUD, and any API logic lives here. This separation makes it easy to swap or mock backends for testing. |

### Naming Conventions

| Element | Convention | Example |
|---------|-----------|---------|
| **Files** | `snake_case.dart` | `welcome_screen.dart`, `responsive_home.dart` |
| **Classes** | `PascalCase` | `WelcomeScreen`, `ResponsiveHome` |
| **Widgets** | `PascalCase` (same as classes) | `WelcomeScreen`, `CustomerCard` |
| **Variables & Functions** | `camelCase` | `_isJoined`, `_buildWideLayout()` |
| **Constants** | `camelCase` or `SCREAMING_SNAKE_CASE` | `primaryColor`, `MAX_POINTS` |
| **Directories** | `lowercase` | `screens/`, `widgets/`, `models/` |

---

## Setup Instructions

### Prerequisites
- **Flutter SDK** (3.x or later) — [Install Guide](https://docs.flutter.dev/get-started/install)
- **Android Studio** with Flutter & Dart plugins — OR — **VS Code** with Flutter extension
- An Android emulator, iOS simulator, or Chrome browser

### Steps to Run

```bash
# 1. Verify Flutter installation
flutter doctor

# 2. Clone the repository
git clone <repo-url>
cd Sprint_02_Team_05/loyalty_link

# 3. Install dependencies
flutter pub get

# 4. Run on Chrome (easiest)
flutter run -d chrome

# 5. Or run on Android emulator
flutter run -d emulator-5554

# 6. Or run on a connected physical device
flutter run
```

---

## Reflection

### What I Learned About Dart & Flutter

1. **Widget-based architecture** — Everything in Flutter is a widget. The UI is built by composing small, reusable widgets (`Text`, `Icon`, `Column`, `Scaffold`) into larger ones.

2. **Stateful vs Stateless** — `StatelessWidget` is for static content; `StatefulWidget` + `setState()` is the mechanism for reactive UI updates.

3. **Dart syntax** — Dart is clean and strongly typed. Features like `const` constructors, named parameters, and null safety make code predictable.

4. **Hot reload** — Changes appear in under a second without losing app state.

5. **Material Design 3** — `useMaterial3: true` gives modern, polished components. `colorSchemeSeed` generates a full palette from one color.

### Responsive Design Challenges & Learnings

1. **Overflow handling** — The biggest challenge was preventing `RenderFlex` overflow errors on very small screens. Using `FittedBox`, `Flexible`, and `mainAxisSize: MainAxisSize.min` solved most cases.

2. **Breakpoint strategy** — Choosing the right breakpoints (600px, 800px) required testing across multiple sizes. `LayoutBuilder` + `constraints.maxWidth` is more reliable than `MediaQuery` for nested widgets because it uses the actual available space, not the full screen width.

3. **GridView aspect ratios** — `childAspectRatio` in `GridView` is critical for consistent card sizing across orientations. Landscape needed a 4-column grid while portrait worked best with 2 columns.

4. **Real-world impact** — Responsive design ensures the app works for all users regardless of device. A small shopkeeper on a phone and a store manager on a tablet both get an optimized experience.

### How This Structure Helps Build Complex UIs

The modular folder structure (`screens/`, `widgets/`, `models/`, `services/`) creates clear separation of concerns:
- **Screens** stay focused on layout and navigation
- **Widgets** can be unit-tested and reused across screens
- **Models** define the data contract independently of UI
- **Services** can be swapped (e.g., mock data → Firebase) without touching UI code

---

## Problem Statement

Small businesses in **Tier-2 and Tier-3 towns** struggle to build customer loyalty because they lack simple and affordable tools to track repeat customers or maintain reward programs.

### Key Question

How might we support small businesses with a **modern digital loyalty experience** that is simple, affordable, and easy to manage?

---

## Solution Overview

**LoyaltyLink** enables small businesses to manage digital loyalty programs — tracking repeat customers, assigning loyalty points, creating reward programs, and monitoring visits — all from a mobile app.

---

## Technology Stack

| Layer | Technology |
|------|------------|
| Frontend | Flutter |
| Programming Language | Dart |
| Backend | Firebase |
| Database | Cloud Firestore |
| Authentication | Firebase Auth |
| Hosting | Firebase Hosting |
| CI/CD | GitHub Actions |

---

## App User Flow

```
User opens app → Splash Screen → Login/Signup → Dashboard
                                                    │
                                             ┌──────┴──────┐
                                             ▼             ▼
                                          Customers     Rewards
                                             │             │
                                             ▼             ▼
                                          Add Points   Redeem Rewards
```

---

## MVP Features

- **Authentication**: Sign Up, Login, Logout
- **Customer Management**: Add/view customers, Firestore storage
- **Loyalty Points**: Add and track point balances
- **Rewards**: Create rewards, redeem points
- **Core Screens**: Splash, Login, Dashboard, Customers, Rewards, Profile

---

## Sprint Timeline (4 Weeks)

| Week | Focus |
|------|-------|
| 1 | Setup & Design – wireframes, Flutter & Firebase project setup |
| 2 | Core Development – auth, dashboard, customer profiles, Firestore |
| 3 | Integration & Testing – UI + Firestore, rewards, validation |
| 4 | MVP Completion – polish, bug fixes, APK generation, demo prep |

---

## Risks & Mitigation

| Risk | Mitigation |
|-----|------|
| Firebase config issues | Use mock data until Firebase works |
| UI bugs | Modular widget testing |
| Schema mistakes | Plan Firestore structure before dev |

---

## Future Improvements

Push notifications · QR code scanning · Analytics dashboard · Multi-language · Payment integration · Referral rewards