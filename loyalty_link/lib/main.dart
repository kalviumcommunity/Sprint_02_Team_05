import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const LoyaltyLinkApp());
}

class LoyaltyLinkApp extends StatelessWidget {
  const LoyaltyLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LoyaltyLink',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF6C63FF),
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: const AuthGate(),
    );
  }
}

/// 🔐 Central auth + persistence handler
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // ⏳ While Firebase checks stored session
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }

        // ✅ User already logged in (persistent session)
        if (snapshot.hasData) {
          return const HomeScreen();
        }

        // ❌ Not logged in
        return const AuthScreen();
      },
    );
  }
}