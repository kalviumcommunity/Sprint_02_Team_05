# Local State Management with setState – LoyaltyLink

## Sprint #2 – Managing Local UI State with setState  
**Technology Stack:** Flutter + Dart

---

## Project Description

LoyaltyLink uses `setState()` extensively across multiple screens to manage interactive UI state — toggles, counters, loading indicators, form errors, and visibility changes. This document explains how `setState()` powers the app's reactive behavior.

---

## setState() in Action — All Usage Across the App

### 1. Welcome Screen – Toggle State (`welcome_screen.dart`)

```dart
bool _isJoined = false;  // Local state

void _toggleJoin() {
  setState(() {
    _isJoined = !_isJoined;  // Flips the boolean
  });
}
```

**What changes:** Icon switches (loyalty → favorite), text updates, button color changes, all via a single boolean.

---

### 2. Counter with Color Change (`stateless_stateful_demo.dart`)

```dart
int _counter = 0;
bool _isDarkMode = true;
bool _showSecret = false;

// Counter accent color changes based on count value
Color get _accentColor {
  final colors = [Color(0xFF6C63FF), Color(0xFFFF6584), Color(0xFF43E97B)];
  return colors[_counter % colors.length];  // Conditional state update
}

// Increment
onPressed: () => setState(() => _counter++),

// Decrement (with guard)
onPressed: () => setState(() { if (_counter > 0) _counter--; }),

// Reset
onPressed: () => setState(() => _counter = 0),

// Theme toggle
onTap: () => setState(() => _isDarkMode = !_isDarkMode),

// Visibility toggle
onTap: () => setState(() => _showSecret = !_showSecret),
```

**Conditional UI:** Background color and accent color change based on `_counter` value — demonstrating state-driven visual updates.

---

### 3. Loading & Error State (`login_screen.dart`)

```dart
bool _loading = false;
String? _error;

Future<void> _handleLogin() async {
  if (!_formKey.currentState!.validate()) return;

  setState(() { _loading = true; _error = null; });  // Show spinner, clear error

  try {
    await _auth.login(email, password);
    // Navigate on success
  } catch (e) {
    setState(() => _error = e.toString());  // Show error banner
  } finally {
    setState(() => _loading = false);  // Hide spinner
  }
}
```

**Multiple state variables** updated in sequence — `_loading` controls the spinner, `_error` controls the error banner.

---

## Common Mistakes Avoided

| ❌ Mistake | ✅ LoyaltyLink Approach |
|-----------|------------------------|
| Updating state without `setState()` | All state changes wrapped in `setState(() {...})` |
| Calling `setState()` inside `build()` | State only updated in event handlers (`onPressed`, `onTap`) |
| Rebuilding entire widget tree | Small StatefulWidgets update only their subtree |
| Not guarding state | `if (_counter > 0) _counter--` prevents negative values |

---

## Screenshots

### Before State Change (counter = 0, dark mode)
*(Add screenshot of initial demo state)*

![Before](loyalty_link/screenshots/state_before.png)

### After State Change (counter incremented, light mode toggled)
*(Add screenshot after interactions)*

![After](loyalty_link/screenshots/state_after.png)

---

## Reflection

### What's the difference between Stateless and Stateful widgets?
- **StatelessWidget** = a photograph — fixed, no internal variables that change. UI is built once from constructor arguments.
- **StatefulWidget** = a live feed — has a `State` object with mutable variables. Calling `setState()` re-runs `build()` to reflect changes.

### Why is setState() important for Flutter's reactive model?
`setState()` is the **trigger** that connects data changes to UI updates. Without it, Flutter doesn't know that a variable changed and won't re-render. It marks the widget as "dirty" so Flutter's rendering pipeline only rebuilds the affected subtree — not the entire app.

### How can improper use of setState() affect performance?
1. **Too high in the tree** — calling `setState()` on a parent widget rebuilds all children, even unchanged ones
2. **Inside build()** — causes infinite rebuild loops and crashes
3. **Too many variables** — tracking too much state in one widget makes it hard to isolate what's changing
4. **Not needed** — for app-wide state (auth, theme), use `StreamBuilder` or state management libraries instead of `setState()`