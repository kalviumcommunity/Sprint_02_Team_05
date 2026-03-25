# Handling User Input with Forms – LoyaltyLink

## Sprint #2 – TextFields, Buttons, and Form Validation  
**Technology Stack:** Flutter + Dart + Firebase Auth

---

## Project Description

LoyaltyLink uses **Form**, **TextFormField**, and **ElevatedButton** widgets across its signup and login screens to collect and validate user credentials. The forms include real-time validation, error feedback, and Firebase-powered submission.

---

## Form Implementations

### Signup Form (`signup_screen.dart`)

Three input fields with validation, linked to Firebase Auth:

```dart
final _formKey = GlobalKey<FormState>();
final _nameController = TextEditingController();
final _emailController = TextEditingController();
final _passwordController = TextEditingController();

Form(
  key: _formKey,
  child: Column(children: [
    // Name field
    TextFormField(
      controller: _nameController,
      decoration: InputDecoration(hintText: 'Business Name', prefixIcon: Icon(Icons.storefront)),
      validator: (v) => (v == null || v.isEmpty) ? 'Enter your name' : null,
    ),

    // Email field
    TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(hintText: 'Email', prefixIcon: Icon(Icons.email_outlined)),
      validator: (v) {
        if (v == null || v.isEmpty) return 'Enter email';
        if (!v.contains('@')) return 'Enter a valid email';
        return null;
      },
    ),

    // Password field
    TextFormField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(hintText: 'Password', prefixIcon: Icon(Icons.lock_outline)),
      validator: (v) {
        if (v == null || v.isEmpty) return 'Enter password';
        if (v.length < 6) return 'Min 6 characters';
        return null;
      },
    ),

    // Submit button
    ElevatedButton(
      onPressed: _loading ? null : _handleSignUp,
      child: _loading ? CircularProgressIndicator() : Text('Sign Up'),
    ),
  ]),
)
```

### Form Submission Handler

```dart
Future<void> _handleSignUp() async {
  if (!_formKey.currentState!.validate()) return;  // Triggers all validators

  setState(() { _loading = true; _error = null; });

  try {
    final user = await _auth.signUp(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
    if (user != null) {
      await _firestore.addUserData(user.uid, {
        'name': _nameController.text.trim(),
        'email': user.email,
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashboardScreen()));
    }
  } catch (e) {
    setState(() => _error = e.toString());  // Show error banner
  } finally {
    setState(() => _loading = false);
  }
}
```

### Login Form (`login_screen.dart`)

Same pattern with email + password fields and validation:

```dart
TextFormField(
  controller: _emailController,
  validator: (v) {
    if (v == null || v.isEmpty) return 'Enter email';
    if (!v.contains('@')) return 'Enter a valid email';
    return null;
  },
),

TextFormField(
  controller: _passwordController,
  obscureText: true,
  validator: (v) => (v == null || v.isEmpty) ? 'Enter password' : null,
),

ElevatedButton(
  onPressed: _loading ? null : _handleLogin,
  child: Text('Login'),
),
```

---

## Input Widgets Used

| Widget | Purpose | Screen |
|--------|---------|--------|
| `Form` | Groups fields + manages validation state | Signup, Login |
| `GlobalKey<FormState>` | Triggers `.validate()` on all fields at once | Signup, Login |
| `TextFormField` | Text input with built-in `validator` | All forms |
| `TextEditingController` | Reads/controls text field values | All forms |
| `ElevatedButton` | Triggers form submission | Signup, Login |
| `InputDecoration` | Styled hints, icons, borders | All fields |

---

## Validation Flow

```
User taps "Sign Up"
     │
     ▼
_formKey.currentState!.validate()
     │
     ├── Name empty?     → "Enter your name"
     ├── Email empty?    → "Enter email"
     ├── Email no @?     → "Enter a valid email"
     ├── Password empty? → "Enter password"
     ├── Password < 6?   → "Min 6 characters"
     │
     ▼ (all pass)
Firebase Auth → createUserWithEmailAndPassword()
     │
     ├── Success → Navigate to Dashboard
     └── Error   → Show error banner (e.g., "Email already in use")
```

---

## Error Handling UI

```dart
// Error banner shown when Firebase returns an error
if (_error != null)
  Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.red.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.red.withValues(alpha: 0.4)),
    ),
    child: Text(_error!, style: TextStyle(color: Colors.redAccent)),
  ),
```

---

## Screenshots

### Form Before Input
*(Add screenshot of empty signup form)*

![Empty Form](loyalty_link/screenshots/form_empty.png)

### Form With Validation Errors
*(Add screenshot showing validation error messages)*

![Validation Errors](loyalty_link/screenshots/form_errors.png)

### Successful Submission (Dashboard)
*(Add screenshot of dashboard after successful signup)*

![Success](loyalty_link/screenshots/form_success.png)

---

## Reflection

### Why is input validation important in mobile apps?
Validation prevents **bad data** from reaching the backend. Without it, users could submit empty emails, weak passwords, or malformed data — causing crashes, security vulnerabilities, or corrupted database entries.

### What's the difference between TextField and TextFormField?
- `TextField` — basic text input with no built-in validation
- `TextFormField` — extends TextField with a `validator` property and integrates with `Form` for grouped validation via `_formKey.currentState!.validate()`

### How does form state management simplify validation?
`GlobalKey<FormState>` lets you validate **all fields at once** with a single call to `.validate()`. Without it, you'd have to manually check each controller's text value — more code, more bugs, more maintenance.