# Responsive Layout Design – LoyaltyLink

## Sprint #2 – Designing Responsive Layouts Using Rows, Columns & Containers  
**Technology Stack:** Flutter + Dart

---

## Project Description

The LoyaltyLink dashboard (`responsive_home.dart`) demonstrates responsive layout design using Flutter's core layout widgets — **Container**, **Row**, **Column**, **Expanded**, and **Flexible** — combined with `MediaQuery` and `LayoutBuilder` for screen-size adaptation.

---

## Core Layout Widgets Used

### Container – Flexible boxes with padding, margin, and decoration

```dart
// Welcome banner with gradient, rounded corners, and padding
Container(
  width: double.infinity,
  margin: EdgeInsets.all(horizontalPadding),
  padding: EdgeInsets.all(cardPadding),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(18),
    gradient: LinearGradient(
      colors: [Color(0xFF7C4DFF), Color(0xFF6C63FF).withValues(alpha: 0.6)],
    ),
  ),
  child: Column(children: [
    Text('👋 Welcome back, Business Owner!'),
    Text('Here\'s your loyalty program overview for today.'),
  ]),
)
```

### Row – Horizontal layout for side-by-side content

```dart
// Wide layout: Stats on left, Recent Activity on right
Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Expanded(flex: 3, child: _buildStatsSection(...)),   // 60% width
    SizedBox(width: 16),
    Expanded(flex: 2, child: _buildActivityPanel(...)),   // 40% width
  ],
)
```

### Column – Vertical stacking for main content flow

```dart
// Main content stacked vertically
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    _buildWelcomeBanner(...),         // Header section
    SizedBox(height: 20),
    Text('Quick Stats'),              // Section title
    SizedBox(height: 12),
    GridView.builder(...),            // Stats grid
    SizedBox(height: 24),
    Text('Quick Actions'),            // Actions section
    Wrap(children: actionButtons),    // Responsive action buttons
  ],
)
```

### Expanded & Flexible – Proportional space distribution

```dart
// Two-column layout with 3:2 ratio
Row(children: [
  Expanded(flex: 3, child: mainContent),   // Takes 60%
  Expanded(flex: 2, child: sidePanel),     // Takes 40%
])
```

---

## Responsive Behavior

### How Responsiveness Works

```dart
// MediaQuery detects screen dimensions
final screenWidth = MediaQuery.of(context).size.width;
final isTablet = screenWidth > 600;
final isLandscape = screenWidth > screenHeight;

// LayoutBuilder adapts based on available space
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth > 800)  return _buildWideLayout();    // Row with side panel
    if (constraints.maxWidth > 600)  return _buildMediumLayout();  // Single column
    else                             return _buildNarrowLayout();  // Phone layout
  },
)
```

| Screen Size | Layout | Grid Columns | Side Panel |
|-------------|--------|-------------|------------|
| **< 600px** (Phone Portrait) | Single column | 2 | Hidden |
| **600–800px** (Phone Landscape) | Single column | 2–4 | Hidden |
| **> 800px** (Tablet) | Two-column Row | 2 | Visible |

---

## Screenshots

### Phone Portrait (390 × 844px)
![Phone Portrait](loyalty_link/screenshots/responsive_phone_portrait.png)

- Single **Column** layout
- Stats in 2-column **GridView**
- Quick Actions in **Wrap** (auto-wrapping)

### Phone Landscape (844 × 390px)
![Phone Landscape](loyalty_link/screenshots/responsive_phone_landscape.png)

- Adapts to **Row** layout with side panel
- Stats grid expands columns

### Tablet (1024 × 768px)
![Tablet](loyalty_link/screenshots/responsive_tablet.png)

- **Row** with **Expanded(flex: 3)** for stats + **Expanded(flex: 2)** for activity panel
- Larger padding and font sizes via **Container** properties

---

## Reflection

### Why is responsiveness important in mobile apps?
Users access apps on phones, tablets, and web browsers. A layout that only works at one size alienates users on different devices. Responsiveness ensures every user gets a usable, visually balanced experience regardless of screen dimensions.

### What challenges did you face managing layout proportions?
- **Overflow errors** — Column children exceeding screen height. Solved with `Expanded`, `Flexible`, and `SingleChildScrollView`.
- **Grid aspect ratios** — `childAspectRatio` in GridView needs different values for portrait vs landscape. Dynamic calculation via `MediaQuery` solved this.
- **Text sizing** — static font sizes look too small on tablets and too large on phones. Using `isTablet` conditional sizing fixed this.

### How can you improve layout for different orientations?
- Use `OrientationBuilder` alongside `LayoutBuilder` for finer control
- Implement adaptive breakpoints (not just phone/tablet but also foldables)
- Add responsive image sizing using `ConstrainedBox` and `FittedBox`
- Consider `SliverGrid` for more complex scrollable responsive grids