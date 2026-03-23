import 'package:flutter/material.dart';

/// WelcomeScreen – the first screen users see when they launch LoyaltyLink.
/// Demonstrates Scaffold, AppBar, Column layout, Icon, Text, Button,
/// and basic state management with setState.
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // ---------- STATE ----------
  bool _isJoined = false;

  void _toggleJoin() {
    setState(() {
      _isJoined = !_isJoined;
    });
  }

  // ---------- UI ----------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // -------- APP BAR --------
      appBar: AppBar(
        title: const Text(
          'LoyaltyLink',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF6C63FF),
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      // -------- BODY --------
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF6C63FF), Color(0xFF1A1A2E)],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ---- ICON ----
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _isJoined
                      ? Colors.greenAccent.withValues(alpha: 0.2)
                      : Colors.white.withValues(alpha: 0.15),
                ),
                child: Icon(
                  _isJoined ? Icons.favorite : Icons.loyalty,
                  size: 100,
                  color: _isJoined ? Colors.greenAccent : Colors.white,
                ),
              ),

              const SizedBox(height: 32),

              // ---- TITLE TEXT ----
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: Text(
                  _isJoined
                      ? 'Welcome aboard! 🎉'
                      : 'Welcome to LoyaltyLink',
                  key: ValueKey<bool>(_isJoined),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // ---- SUBTITLE ----
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: Text(
                  _isJoined
                      ? 'You\'re now part of the loyalty family.'
                      : 'Earn rewards. Build loyalty.\nGrow your business.',
                  key: ValueKey<String>(_isJoined ? 'joined' : 'default'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withValues(alpha: 0.8),
                    height: 1.5,
                  ),
                ),
              ),

              const SizedBox(height: 48),

              // ---- BUTTON (state change on tap) ----
              ElevatedButton.icon(
                onPressed: _toggleJoin,
                icon: Icon(
                  _isJoined ? Icons.check_circle : Icons.arrow_forward,
                ),
                label: Text(
                  _isJoined ? 'Joined ✓' : 'Get Started',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _isJoined ? Colors.greenAccent : Colors.white,
                  foregroundColor:
                      _isJoined ? Colors.black87 : const Color(0xFF6C63FF),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
