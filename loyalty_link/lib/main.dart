import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';

/// Entry point of the LoyaltyLink application.
void main() {
  runApp(const LoyaltyLinkApp());
}

/// Root widget – sets up MaterialApp with theming and routes.
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
      home: const WelcomeScreen(),
    );
  }
}
