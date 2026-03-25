# Consistent Styles & Scrollable Views – LoyaltyLink

## Sprint #2 – Applying Styles, Colors, Text Themes + Scrollable Views  
**Technology Stack:** Flutter + Dart

---

## Project Description

LoyaltyLink demonstrates **consistent theming** across all screens using Material 3's `ThemeData` + `colorSchemeSeed`, and uses **ListView** and **GridView** widgets to display scrollable content efficiently.

---

## Consistent Styles & Theming

### Global Theme in `main.dart`

All screens inherit from a single `ThemeData` defined in the root `MaterialApp`:

```dart
MaterialApp(
  theme: ThemeData(
    colorSchemeSeed: const Color(0xFF6C63FF),  // Purple seed generates full palette
    useMaterial3: true,
    brightness: Brightness.dark,
  ),
)
```

### How Theme Consistency Works Across Screens

| Element | Style Approach | Consistency |
|---------|---------------|-------------|
| **Colors** | Custom purple palette (`0xFF6C63FF`) + color scheme seed | All screens use same gradient + accent |
| **Text** | Uniform `TextStyle` sizes: 28 for titles, 15 for subtitles, 13 for labels | Same hierarchy everywhere |
| **Buttons** | `ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: purple)` | Login, Signup, Dashboard match |
| **Cards** | `Colors.white.withValues(alpha: 0.1)` with `BorderRadius.circular(14)` | Glassmorphic style on all screens |
| **Gradients** | `LinearGradient(colors: [0xFF6C63FF, 0xFF1A1A2E])` | Same background on every screen |
| **Input fields** | Filled `TextFormField` with `Colors.white.withValues(alpha: 0.1)` | Login & Signup match exactly |

### Reusable Color Palette

```dart
// Consistent across all screens
const primaryPurple = Color(0xFF6C63FF);
const darkBackground = Color(0xFF1A1A2E);
const cardOverlay = Colors.white.withValues(alpha: 0.1);
const textPrimary = Colors.white;
const textSecondary = Colors.white.withValues(alpha: 0.7);
```

---

## ListView – Scrollable Customer List

### Implementation in `dashboard_screen.dart`

```dart
StreamBuilder<QuerySnapshot>(
  stream: _firestore.getCustomers(user.uid),
  builder: (context, snapshot) {
    final docs = snapshot.data!.docs;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: docs.length,
      itemBuilder: (_, i) {
        final data = docs[i].data() as Map<String, dynamic>;
        return ListTile(
          leading: CircleAvatar(child: Text(data['name'][0])),
          title: Text(data['name']),
          subtitle: Text('⭐ ${data['points']} pts'),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
            IconButton(icon: Icon(Icons.edit), onPressed: () => _edit(docs[i])),
            IconButton(icon: Icon(Icons.delete), onPressed: () => _delete(docs[i])),
          ]),
        );
      },
    );
  },
)
```

**Why `ListView.builder`:** Only renders visible items — efficient for lists of any size.

---

## GridView – Stats Dashboard Grid

### Implementation in `responsive_home.dart`

```dart
GridView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: isLandscape ? 4 : 2,
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
    childAspectRatio: isTablet ? 1.6 : 1.3,
  ),
  itemCount: stats.length,
  itemBuilder: (context, index) {
    return Container(
      padding: EdgeInsets.all(cardPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white.withValues(alpha: 0.1),
      ),
      child: Column(children: [
        Icon(stats[index].icon, color: stats[index].color),
        FittedBox(child: Text(stats[index].value)),
        Text(stats[index].label),
      ]),
    );
  },
)
```

**Why `GridView.builder`:** Lazy rendering + responsive `crossAxisCount` for different screen sizes.

---

## ListView vs GridView

| Feature | ListView | GridView |
|---------|----------|---------|
| **Layout** | Single-column vertical scroll | Multi-column grid scroll |
| **Best for** | Contacts, chats, feeds, customer lists | Dashboards, galleries, product catalogs |
| **Builder** | `ListView.builder()` | `GridView.builder()` |
| **Responsive** | Via item width | Via `crossAxisCount` |

---

## Screenshots

### Dashboard – ListView (Customer List)
*(Add screenshot of scrollable customer list)*

![ListView](loyalty_link/screenshots/listview_customers.png)

### Home – GridView (Stats Grid)
![GridView Phone](loyalty_link/screenshots/responsive_phone_portrait.png)

![GridView Tablet](loyalty_link/screenshots/responsive_tablet.png)

---

## Reflection

### How does ListView differ from GridView in design use cases?
ListView is ideal for **sequential content** (messages, contacts, feeds) where items are read top-to-bottom. GridView is better for **visual browsing** (photos, stats, products) where users scan a 2D layout.

### Why is `ListView.builder()` more efficient for large lists?
It uses **lazy construction** — only the ~10-15 items visible on screen are built. A regular `ListView` with 1000 children would build all 1000 upfront, consuming memory and delaying the first frame.

### What can you do to prevent lag or overflow errors?
1. **Always use `.builder()`** for dynamic data
2. **Wrap in `Expanded`** when inside a Column to avoid unbounded height
3. **Use `shrinkWrap: true`** + `NeverScrollableScrollPhysics()` for nested scrollable widgets
4. **Avoid heavy computation** inside `itemBuilder` — pre-process data before building