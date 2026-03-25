# Multi-Screen Navigation – LoyaltyLink

## Sprint #2 – Structuring Navigation Using Navigator & Routes  
**Technology Stack:** Flutter + Dart

---

## Project Description

LoyaltyLink uses **Navigator** with both **named routes** and **push-based navigation** to manage multi-screen transitions. The app contains 5 screens connected by a logical navigation flow — from authentication to the main dashboard.

---

## Navigation Architecture

```
App Launch → Firebase Init → Auth State Check
                                    │
                    ┌───────────────┴───────────────┐
                    ▼                               ▼
            Login Screen (/login)          Dashboard Screen (/dashboard)
                    │                               │
                    ▼                               ▼
            Signup Screen (/signup)            Logout → Login
                    │
                    ▼
            Dashboard Screen (/dashboard)
```

---

## Named Routes in main.dart

```dart
MaterialApp(
  // Named routes map — each route name maps to a screen widget
  routes: {
    '/login':     (context) => const LoginScreen(),
    '/signup':    (context) => const SignupScreen(),
    '/dashboard': (context) => const DashboardScreen(),
    '/welcome':   (context) => const WelcomeScreen(),
    '/home':      (context) => const ResponsiveHome(),
  },

  // Initial screen determined by auth state
  home: StreamBuilder<User?>(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (context, snapshot) {
      if (snapshot.hasData) return const DashboardScreen();
      return const LoginScreen();
    },
  ),
);
```

---

## Navigation Methods Used

### 1. `Navigator.pushReplacement()` – Replace current screen

Used for login → dashboard (no back button to login after signing in):

```dart
// In login_screen.dart – after successful login
Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (_) => const DashboardScreen()),
);
```

### 2. `Navigator.pushNamed()` – Navigate by route name

Used for navigating between screens using route strings:

```dart
// Navigate to signup using named route
Navigator.pushNamed(context, '/signup');

// Navigate to dashboard
Navigator.pushNamed(context, '/dashboard');
```

### 3. `Navigator.pop()` – Go back to previous screen

Used for returning to the previous screen:

```dart
// In second_screen or dialogs
Navigator.pop(context);
```

### 4. Auth-based routing with StreamBuilder

The app automatically routes based on login state:

```dart
StreamBuilder<User?>(
  stream: FirebaseAuth.instance.authStateChanges(),
  builder: (context, snapshot) {
    if (snapshot.hasData) return const DashboardScreen();  // Logged in
    return const LoginScreen();                             // Not logged in
  },
)
```

---

## Screen-by-Screen Navigation

| Screen | Route | Navigates To | Method |
|--------|-------|-------------|--------|
| **LoginScreen** | `/login` | Dashboard (on success), Signup (link) | `pushReplacement` |
| **SignupScreen** | `/signup` | Dashboard (on success), Login (link) | `pushReplacement` |
| **DashboardScreen** | `/dashboard` | Login (on logout) | `pushReplacement` |
| **WelcomeScreen** | `/welcome` | — (standalone) | — |
| **ResponsiveHome** | `/home` | — (standalone) | — |

---

## Screenshots

### Login Screen
*(Add screenshot of login screen)*

![Login](loyalty_link/screenshots/nav_login.png)

### Signup Screen
*(Add screenshot of signup screen)*

![Signup](loyalty_link/screenshots/nav_signup.png)

### Dashboard Screen (after login)
*(Add screenshot of dashboard)*

![Dashboard](loyalty_link/screenshots/nav_dashboard.png)

---

## Reflection

### How does Navigator manage the app's stack of screens?
Navigator maintains a **stack** (LIFO — last in, first out) of routes. `push()` adds a screen on top, `pop()` removes the top screen and returns to the previous one, and `pushReplacement()` replaces the current screen entirely (preventing back navigation). This stack model mirrors how users naturally move through app flows.

### What are the benefits of named routes in larger applications?
1. **Centralized routing** — all routes defined in one place (`main.dart`), making it easy to see the full app structure
2. **String-based navigation** — `pushNamed('/dashboard')` is cleaner and more readable than importing screen classes everywhere
3. **Deep linking** — named routes map naturally to URL paths for web apps
4. **Maintainability** — changing a screen class only requires updating the route map, not every file that navigates to it
5. **Team collaboration** — developers can reference route names without knowing implementation details