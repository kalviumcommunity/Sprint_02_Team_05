In this task, you will build a complete authentication system in Flutter using Firebase Authentication (Email & Password). Unlike the previous lesson where you implemented only the basic signup/login logic, this task focuses on building a multi-screen authentication flow with clean UI, error handling, and automatic navigation based on user state.

By the end of this task, your app will support:

Sign Up (creating new users)
Login (authenticating existing users)
Logout (ending active sessions)
Auto-navigation between auth screens and home screens using authStateChanges()
This forms the backbone of any production-ready Flutter app with Firebase.

Task Overview
1. Enable Email & Password Authentication in Firebase Console
Follow these steps:

Open Firebase Console
Navigate to Authentication → Sign-in Method
Enable Email/Password
Click Save
This activates the authentication method your app will use.

2. Set Up Dependencies
Make sure your pubspec.yaml includes:

dependencies:
  firebase_core: ^3.0.0
  firebase_auth: ^5.0.0
Install:

flutter pub get
3. Initialize Firebase and Use authStateChanges()
The entire flow depends on listening to real-time authentication updates.

In main.dart:

home: StreamBuilder<User?>(
  stream: FirebaseAuth.instance.authStateChanges(),
  builder: (ctx, snapshot) {
    if (snapshot.hasData) {
      return HomeScreen();
    }
    return AuthScreen();
  },
),
This ensures:

If the user is logged in → show HomeScreen
If the user is logged out → show AuthScreen
No manual navigation is needed.

4. Build the AuthScreen (Signup + Login UI)
Your AuthScreen should:

Accept email and password
Allow switching between Signup/Login mode
Handle Firebase errors with SnackBars
Use FirebaseAuth methods:
Signup:

createUserWithEmailAndPassword()
Login:

signInWithEmailAndPassword()
UI Expectations:

Clean layout
Proper validation
Loading indicators are optional but encouraged
5. Build the HomeScreen (Logged-in State)
Your HomeScreen should:

Display the authenticated user’s email
Include a logout button
Call:
FirebaseAuth.instance.signOut();
On logout, the StreamBuilder automatically switches back to the AuthScreen.

6. Implement Logout Functionality
Logout is essential for:

Clearing session state
Testing authentication consistency
Allowing multiple test accounts during development
Make sure your logout button is easy to find and works properly.