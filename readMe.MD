# Reusable Custom Widgets – LoyaltyLink

## Sprint #2 – Creating Modular, Reusable Custom Widgets  
**Technology Stack:** Flutter + Dart

---

## Project Description

LoyaltyLink uses custom reusable widgets stored in `lib/widgets/` to maintain **consistent design** and **reduce code duplication** across all screens. Three custom widgets are defined and reused across login, signup, and dashboard.

---

## Custom Widgets Created

### 1. `StyledButton` — Reusable Action Button

A button with loading state, icon support, customizable colors, and full-width mode.

```dart
// lib/widgets/styled_button.dart
class StyledButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color backgroundColor;
  final IconData? icon;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? CircularProgressIndicator(strokeWidth: 2)
          : Row(children: [
              if (icon != null) Icon(icon),
              Text(label),
            ]),
    );
  }
}
```

**Reused in:**
| Screen | Usage |
|--------|-------|
| Login | `StyledButton(label: 'Login', isLoading: _loading, onPressed: _handleLogin)` |
| Signup | `StyledButton(label: 'Sign Up', isLoading: _loading, onPressed: _handleSignUp)` |
| Dashboard | `StyledButton(label: 'Add Customer', icon: Icons.add, onPressed: _addCustomer)` |

---

### 2. `StyledTextField` — Reusable Form Input

A styled `TextFormField` with consistent borders, colors, icons, and validation support.

```dart
// lib/widgets/styled_text_field.dart
class StyledTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(prefixIcon),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.1),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
      validator: validator,
    );
  }
}
```

**Reused in:**
| Screen | Fields |
|--------|--------|
| Signup | Name, Email, Password (3 instances) |
| Login | Email, Password (2 instances) |
| Dashboard | Customer Name, Phone, Points (3 instances in dialog) |

---

### 3. `GradientCard` — Reusable Info Card

A card with gradient background, icon, title, subtitle, and optional tap action.

```dart
// lib/widgets/gradient_card.dart
class GradientCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(colors: [iconColor.withAlpha(0.3), iconColor.withAlpha(0.1)]),
      ),
      child: Row(children: [
        CircleAvatar(child: Icon(icon, color: iconColor)),
        Column(children: [Text(title), Text(subtitle)]),
        if (onTap != null) Icon(Icons.chevron_right),
      ]),
    );
  }
}
```

**Reused in:**
| Screen | Usage |
|--------|-------|
| Dashboard | Welcome banner card |
| Responsive Home | Stats overview card |
| Demo | Info display cards |

---

## Widget Folder Structure

```
lib/
├── widgets/
│   ├── gradient_card.dart       # Reusable gradient info card
│   ├── styled_button.dart       # Reusable button with loading state
│   └── styled_text_field.dart   # Reusable form input field
├── screens/
│   ├── login_screen.dart        # Uses StyledButton, StyledTextField
│   ├── signup_screen.dart       # Uses StyledButton, StyledTextField
│   └── dashboard_screen.dart    # Uses StyledButton, GradientCard
```

---

## How Widgets Are Imported and Reused

```dart
// In any screen:
import '../widgets/styled_button.dart';
import '../widgets/styled_text_field.dart';
import '../widgets/gradient_card.dart';

// Usage — same widget, different data:
StyledButton(label: 'Login', onPressed: _login),
StyledButton(label: 'Sign Up', onPressed: _signup, backgroundColor: Colors.green),
StyledButton(label: 'Add', icon: Icons.add, onPressed: _add, fullWidth: false),
```

---

## Screenshots

### StyledButton reused on Login & Signup
*(Add screenshots showing the same button style on both screens)*

![Login](loyalty_link/screenshots/widget_login.png)
![Signup](loyalty_link/screenshots/widget_signup.png)

---

## Reflection

### How do reusable widgets improve development efficiency?
Instead of copying 20+ lines of button styling into every screen, we define it **once** in `StyledButton` and reuse it everywhere. Changing the border radius or color in one file updates **all** buttons across the app instantly.

### What challenges did you face designing modular components?
- **Flexibility vs simplicity** — making widgets configurable enough (via parameters) without over-engineering them with too many options
- **Default values** — choosing sensible defaults so widgets work with minimal configuration while still being customizable

### How could your team apply this approach?
- Create a shared `widgets/` folder with team-agreed components
- New screens only import existing widgets — no inline styling
- Design changes are made in one file, reflected everywhere
- PR reviews are faster because screens contain less boilerplate