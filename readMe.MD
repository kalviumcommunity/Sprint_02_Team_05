# Responsive Design with MediaQuery & LayoutBuilder – LoyaltyLink

## Sprint #2 – Using MediaQuery and LayoutBuilder for Responsive Design  
**Technology Stack:** Flutter + Dart

---

## Project Description

LoyaltyLink's dashboard (`responsive_home.dart`) combines **MediaQuery** and **LayoutBuilder** to create a fully responsive layout that adapts across phone portrait, phone landscape, and tablet screen sizes.

---

## MediaQuery – Device-Level Screen Info

`MediaQuery` provides device dimensions used for global layout decisions:

```dart
final screenWidth = MediaQuery.of(context).size.width;
final screenHeight = MediaQuery.of(context).size.height;
final isTablet = screenWidth > 600;
final isLandscape = screenWidth > screenHeight;

// Dynamic sizing based on device
final horizontalPadding = isTablet ? 24.0 : 16.0;
final titleFontSize = isTablet ? 26.0 : 20.0;
final cardPadding = isTablet ? 20.0 : 14.0;
```

**Use case:** Adjusting padding, font sizes, and spacing globally based on device type.

---

## LayoutBuilder – Constraint-Based Layout Switching

`LayoutBuilder` provides the **actual available width** (from parent constraints) and switches between entirely different layouts:

```dart
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth > 800) {
      return _buildWideLayout(constraints);   // Two-column Row
    } else if (constraints.maxWidth > 600) {
      return _buildMediumLayout(constraints); // Single column, wider grid
    } else {
      return _buildNarrowLayout(constraints); // Phone layout
    }
  },
)
```

### Narrow Layout (< 600px) — Phone Portrait
```dart
Column(children: [
  _buildWelcomeBanner(horizontalPadding, cardPadding),
  GridView.builder(crossAxisCount: 2, ...),  // 2-column stats
  Wrap(children: actionButtons),              // Wrapping buttons
])
```

### Wide Layout (> 800px) — Tablet
```dart
Row(children: [
  Expanded(flex: 3, child: Column(children: [
    _buildWelcomeBanner(...),
    GridView.builder(crossAxisCount: 2, ...),
  ])),
  Expanded(flex: 2, child: _buildActivityPanel()),  // Side panel
])
```

---

## MediaQuery vs LayoutBuilder

| Feature | MediaQuery | LayoutBuilder |
|---------|-----------|---------------|
| **What it provides** | Full screen width/height | Available space from parent |
| **Scope** | Global device info | Local widget constraints |
| **Best for** | Font sizes, padding, detecting device type | Switching between layout structures |
| **When to use** | Styling adjustments | Conditional layout trees |
| **Example** | `screenWidth > 600 ? 24px : 16px` padding | `maxWidth > 800 ? Row(...) : Column(...)` |

**Use BOTH together:** MediaQuery for proportional sizing, LayoutBuilder for structural layout changes.

---

## Responsive Breakpoints

| Screen Width | Device | Layout | Grid Cols | Side Panel |
|-------------|--------|--------|-----------|------------|
| < 600px | Phone Portrait | Column | 2 | Hidden |
| 600–800px | Phone Landscape | Column | 4 | Hidden |
| > 800px | Tablet | Row (3:2) | 2 | Visible |

---

## Screenshots

### Phone (< 600px)
![Phone Portrait](loyalty_link/screenshots/responsive_phone_portrait.png)

### Phone Landscape (600–800px)
![Phone Landscape](loyalty_link/screenshots/responsive_phone_landscape.png)

### Tablet (> 800px)
![Tablet](loyalty_link/screenshots/responsive_tablet.png)

---

## Reflection

### Why is responsiveness important in mobile development?
Users access apps on ~20,000 different Android devices with varying screen sizes. A fixed-width layout that works on a Pixel 7 will overflow on an older 4.5" phone and waste space on a 10" tablet. Responsive design ensures every user gets a usable, visually balanced experience.

### How does LayoutBuilder differ from MediaQuery?
- **MediaQuery** gives the **device's full screen** dimensions — useful for global decisions
- **LayoutBuilder** gives the **parent's available space** — useful for widgets that might be in a sidebar, dialog, or split view where screen width ≠ available width

### How could your team use these tools to scale efficiently?
- Define shared breakpoints (600px, 800px) as constants
- Create a `ResponsiveWrapper` widget that auto-switches between mobile/tablet layouts
- Use MediaQuery for theming (larger fonts on tablets) and LayoutBuilder for structure (column vs row)