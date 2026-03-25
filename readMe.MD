# Stateless vs Stateful Widgets – LoyaltyLink Demo

## Sprint #2 – Creating and Using Stateless & Stateful Widgets  
**Technology Stack:** Flutter + Dart

---

## Project Description

A demo app (`stateless_stateful_demo.dart`) showcasing both **StatelessWidget** and **StatefulWidget** side-by-side. The screen is split into two clearly labeled sections — static widgets at the top and interactive widgets below — to demonstrate when and why to use each type.

---

## What Are Stateless and Stateful Widgets?

| | **StatelessWidget** | **StatefulWidget** |
|---|---|---|
| **State** | No mutable state | Maintains internal state |
| **Rebuilds** | Only when parent rebuilds with new data | When `setState()` is called |
| **Use for** | Labels, icons, static cards, headers | Counters, toggles, forms, animations |
| **Performance** | Cheaper — no state tracking overhead | Slightly heavier — tracks state lifecycle |
| **Example** | `AppHeader`, `StaticInfoCard` | `InteractiveDemo` |

---

## Code Snippets

### StatelessWidget – AppHeader (static, never changes)

```dart
class AppHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AppHeader({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(colors: [Color(0xFF6C63FF), ...]),
      ),
      child: Column(children: [
        Text(title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        Text(subtitle),
      ]),
    );
  }
}
```

> This widget displays the same content every time. It has **no `setState()`**, no mutable variables. The only way it changes is if a parent passes different `title`/`subtitle` values.

### StatefulWidget – InteractiveDemo (updates on interaction)

```dart
class InteractiveDemo extends StatefulWidget {
  @override
  State<InteractiveDemo> createState() => _InteractiveDemoState();
}

class _InteractiveDemoState extends State<InteractiveDemo> {
  int _counter = 0;
  bool _isDarkMode = true;
  bool _showSecret = false;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // Counter with animated color
      Text('$_counter', style: TextStyle(fontSize: 56, color: _accentColor)),
      
      // Increment/Decrement/Reset buttons
      Row(children: [
        IconButton(onPressed: () => setState(() => _counter--), icon: Icon(Icons.remove)),
        IconButton(onPressed: () => setState(() => _counter++), icon: Icon(Icons.add)),
        IconButton(onPressed: () => setState(() => _counter = 0), icon: Icon(Icons.refresh)),
      ]),

      // Theme toggle
      GestureDetector(
        onTap: () => setState(() => _isDarkMode = !_isDarkMode),
        child: Text(_isDarkMode ? 'Dark Mode' : 'Light Mode'),
      ),

      // Visibility toggle
      GestureDetector(
        onTap: () => setState(() => _showSecret = !_showSecret),
        child: AnimatedCrossFade(...),
      ),
    ]);
  }
}
```

> This widget has **three state variables** (`_counter`, `_isDarkMode`, `_showSecret`). Each `setState()` call tells Flutter to rebuild only the changed parts.

---

## Interactions Demonstrated

| # | Interaction | State Change | Widgets Rebuilt |
|---|------------|-------------|-----------------|
| 1 | Tap **+** button | `_counter++` | Counter text, accent color container |
| 2 | Tap **−** button | `_counter--` | Counter text, accent color container |
| 3 | Tap **reset** button | `_counter = 0` | Counter text, accent color container |
| 4 | Tap **theme toggle** | `_isDarkMode` flips | Theme row (icon, text, background color) |
| 5 | Tap **secret reveal** | `_showSecret` flips | AnimatedCrossFade shows/hides text |

**Meanwhile, ALL StatelessWidgets (AppHeader, StaticInfoCards) remain untouched** — they are never rebuilt during any of these interactions.

---

## Screenshots

### Initial State
*(Add screenshot showing the demo screen with counter at 0, dark mode active, secret hidden)*

![Initial State](loyalty_link/screenshots/demo_initial.png)

### After Interactions
*(Add screenshot showing counter incremented, light mode toggled, secret revealed)*

![After Interaction](loyalty_link/screenshots/demo_after.png)

---

## Reflection

### How do Stateful widgets make Flutter apps dynamic?
StatefulWidget + `setState()` is the mechanism for **reactive UI updates**. When a user taps a button, the state variable changes, Flutter marks the widget as dirty, and only the affected subtree is rebuilt. This makes real-time interactions (counters, toggles, forms) possible without manually manipulating UI elements.

### Why separate static and reactive parts?
1. **Performance** — StatelessWidgets are cheaper to render; isolating them avoids unnecessary rebuilds
2. **Readability** — code is clearer when static labels are separate from interactive logic
3. **Reusability** — `AppHeader` and `StaticInfoCard` can be reused anywhere without side effects
4. **Testing** — StatelessWidgets are easier to unit test since they have no state to mock