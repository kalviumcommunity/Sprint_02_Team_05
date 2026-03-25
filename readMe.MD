# Scrollable Views with ListView & GridView – LoyaltyLink

## Sprint #2 – Building Scrollable UI with ListView and GridView  
**Technology Stack:** Flutter + Dart

---

## Project Description

The LoyaltyLink app uses both **ListView** and **GridView** to display scrollable content — customer lists via `ListView.builder` in the dashboard, and stats cards via `GridView.builder` in the responsive home screen. Both use builder constructors for efficient rendering of dynamic data.

---

## ListView – Scrollable Customer List

### Implementation in `dashboard_screen.dart`

The customer list uses `ListView.builder` with real-time Firestore data via `StreamBuilder`:

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
        final name = data['name'] ?? 'Unknown';
        final phone = data['phone'] ?? '';
        final points = data['points'] ?? 0;

        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white.withValues(alpha: 0.08),
          ),
          child: ListTile(
            leading: CircleAvatar(
              child: Text(name[0].toUpperCase()),
            ),
            title: Text(name),
            subtitle: Text('$phone  •  ⭐ $points pts'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: Icon(Icons.edit), onPressed: () => _edit(doc)),
                IconButton(icon: Icon(Icons.delete), onPressed: () => _delete(doc)),
              ],
            ),
          ),
        );
      },
    );
  },
)
```

**Key features:**
- `ListView.builder` — only renders visible items (lazy loading)
- `StreamBuilder` — list updates in real-time as Firestore data changes
- Each item has edit/delete actions via trailing `IconButton`s
- Empty state shows a placeholder illustration when no customers exist

---

## GridView – Stats Dashboard Grid

### Implementation in `responsive_home.dart`

The stats cards use `GridView.builder` with a responsive column count:

```dart
GridView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),  // Parent handles scrolling
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: isLandscape ? 4 : 2,          // Responsive columns
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
    childAspectRatio: isTablet ? 1.6 : 1.3,       // Responsive card shape
  ),
  itemCount: stats.length,
  itemBuilder: (context, index) {
    final stat = stats[index];
    return Container(
      padding: EdgeInsets.all(cardPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white.withValues(alpha: 0.1),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(stat.icon, color: stat.color, size: 24),
          Spacer(),
          FittedBox(child: Text(stat.value, style: TextStyle(fontSize: 28))),
          Text(stat.label),
        ],
      ),
    );
  },
)
```

**Key features:**
- `GridView.builder` — efficient rendering for dynamic stat items
- `crossAxisCount` adapts: 2 columns on phone, 4 in landscape
- `childAspectRatio` adjusts card proportions per device
- `shrinkWrap: true` + `NeverScrollableScrollPhysics` — embedded inside a parent `SingleChildScrollView`

---

## Builder vs Static Constructors

| Constructor | When to Use | Performance |
|-------------|------------|-------------|
| `ListView()` | Small, fixed lists (< 10 items) | Builds all items upfront |
| `ListView.builder()` | Dynamic/large lists | **Lazy** — only builds visible items |
| `GridView.count()` | Small, fixed grids | Builds all items upfront |
| `GridView.builder()` | Dynamic/large grids | **Lazy** — only builds visible cells |

---

## Screenshots

### ListView – Customer List (Dashboard)
*(Add screenshot showing the scrollable customer list)*

![Customer List](loyalty_link/screenshots/listview_customers.png)

### GridView – Stats Dashboard
![Stats Grid - Phone](loyalty_link/screenshots/responsive_phone_portrait.png)

![Stats Grid - Tablet](loyalty_link/screenshots/responsive_tablet.png)

---

## Reflection

### How do ListView and GridView improve UI efficiency?
Both widgets provide **scrollable containers** that handle overflow gracefully. Instead of content being clipped or causing overflow errors, items scroll naturally. The `builder` variants use **lazy rendering** — only visible items are built in memory, which keeps the app fast even with hundreds of items.

### Why are builder constructors recommended for large data sets?
- **Memory efficiency** — only ~10-15 visible items exist at a time, not all 1000
- **Smooth scrolling** — minimal frame drops because items are built on-demand
- **Dynamic data** — `itemCount` and `itemBuilder` work naturally with lists from APIs/databases
- **Recycling** — Flutter reuses widget slots as items scroll in/out of view

### Common performance pitfalls to avoid
1. **Unbounded height** — never put a `ListView` inside a `Column` without `shrinkWrap: true` or wrapping in `Expanded`
2. **Heavy builders** — avoid expensive operations (network calls, image processing) inside `itemBuilder`
3. **Missing keys** — without `key` on list items, Flutter may rebuild items unnecessarily on reorder
4. **Nested scrolling** — use `NeverScrollableScrollPhysics()` on inner scrollable widgets to prevent scroll conflicts