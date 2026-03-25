import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/responsive_home.dart';

/// Entry point of the LoyaltyLink application.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const LoyaltyLinkApp());
}

/// Root widget – sets up MaterialApp with theming, named routes,
/// and auth-based initial routing.
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

      // ── Named Routes ──
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/home': (context) => const ResponsiveHome(),
      },

      // ── Initial screen based on auth state ──
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasData) {
            return const DashboardScreen();
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
