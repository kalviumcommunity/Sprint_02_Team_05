import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════
//  STATELESS WIDGETS – static UI components that never change
// ═══════════════════════════════════════════════════════════════════

/// AppHeader – a StatelessWidget that displays a static title & subtitle.
/// Once built, it never changes unless the parent rebuilds it with new data.
class AppHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AppHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF6C63FF).withValues(alpha: 0.8),
            const Color(0xFF6C63FF).withValues(alpha: 0.4),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}

/// StaticInfoCard – a StatelessWidget showing a fixed label and value.
class StaticInfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;

  const StaticInfoCard({
    super.key,
    required this.icon,
    required this.label,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withValues(alpha: 0.08),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 22),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
//  STATEFUL WIDGET – interactive component that manages its own state
// ═══════════════════════════════════════════════════════════════════

/// InteractiveDemo – a StatefulWidget demonstrating setState() updates.
/// Contains a counter, a color changer, and a visibility toggle.
class InteractiveDemo extends StatefulWidget {
  const InteractiveDemo({super.key});

  @override
  State<InteractiveDemo> createState() => _InteractiveDemoState();
}

class _InteractiveDemoState extends State<InteractiveDemo> {
  int _counter = 0;
  bool _isDarkMode = true;
  bool _showSecret = false;

  // Color palette that changes with counter
  Color get _accentColor {
    final colors = [
      const Color(0xFF6C63FF),
      const Color(0xFFFF6584),
      const Color(0xFF43E97B),
      const Color(0xFFFA8BFF),
      const Color(0xFFFFBE0B),
    ];
    return colors[_counter % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Counter Section ──
        AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: _accentColor.withValues(alpha: 0.15),
            border: Border.all(color: _accentColor.withValues(alpha: 0.3)),
          ),
          child: Column(
            children: [
              const Text(
                'Loyalty Points Counter',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  '$_counter',
                  key: ValueKey(_counter),
                  style: TextStyle(
                    fontSize: 56,
                    fontWeight: FontWeight.bold,
                    color: _accentColor,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _actionButton(
                    icon: Icons.remove,
                    onTap: () => setState(() {
                      if (_counter > 0) _counter--;
                    }),
                    color: Colors.redAccent,
                  ),
                  const SizedBox(width: 16),
                  _actionButton(
                    icon: Icons.add,
                    onTap: () => setState(() => _counter++),
                    color: const Color(0xFF43E97B),
                  ),
                  const SizedBox(width: 16),
                  _actionButton(
                    icon: Icons.refresh,
                    onTap: () => setState(() => _counter = 0),
                    color: Colors.amber,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // ── Theme Toggle (Light/Dark) ──
        GestureDetector(
          onTap: () => setState(() => _isDarkMode = !_isDarkMode),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: _isDarkMode
                  ? Colors.white.withValues(alpha: 0.08)
                  : Colors.white.withValues(alpha: 0.85),
            ),
            child: Row(
              children: [
                Icon(
                  _isDarkMode ? Icons.dark_mode : Icons.light_mode,
                  color: _isDarkMode ? Colors.white : Colors.black87,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _isDarkMode ? 'Dark Mode Active' : 'Light Mode Active',
                    style: TextStyle(
                      color: _isDarkMode ? Colors.white : Colors.black87,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                AnimatedRotation(
                  turns: _isDarkMode ? 0 : 0.5,
                  duration: const Duration(milliseconds: 400),
                  child: Icon(
                    Icons.swap_horiz,
                    color: _isDarkMode ? Colors.white54 : Colors.black45,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // ── Visibility Toggle ──
        GestureDetector(
          onTap: () => setState(() => _showSecret = !_showSecret),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.white.withValues(alpha: 0.08),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      _showSecret ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white70,
                      size: 22,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      _showSecret ? 'Secret Revealed!' : 'Tap to reveal secret',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                AnimatedCrossFade(
                  firstChild: const SizedBox.shrink(),
                  secondChild: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      '🎉 You found it! LoyaltyLink rewards loyal customers with surprise points!',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 13,
                      ),
                    ),
                  ),
                  crossFadeState: _showSecret
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 300),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _actionButton({
    required IconData icon,
    required VoidCallback onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: 0.2),
          border: Border.all(color: color.withValues(alpha: 0.4)),
        ),
        child: Icon(icon, color: color, size: 24),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
//  MAIN DEMO SCREEN – combines both Stateless & Stateful widgets
// ═══════════════════════════════════════════════════════════════════

/// StatelessStatefulDemo – the main screen that composes both widget types.
class StatelessStatefulDemo extends StatelessWidget {
  const StatelessStatefulDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Stateless vs Stateful',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF6C63FF),
        foregroundColor: Colors.white,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF6C63FF), Color(0xFF1A1A2E)],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── STATELESS SECTION ──
              Text(
                '📌 Stateless Widgets',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withValues(alpha: 0.5),
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),

              // These are StatelessWidgets — they never change
              const AppHeader(
                title: 'LoyaltyLink Dashboard',
                subtitle: 'These widgets are static — they never change on their own.',
              ),
              const SizedBox(height: 10),
              const StaticInfoCard(
                icon: Icons.check_circle,
                label: 'Flutter SDK: v3.41.5 (stable)',
                iconColor: Color(0xFF43E97B),
              ),
              const SizedBox(height: 8),
              const StaticInfoCard(
                icon: Icons.phone_android,
                label: 'Platform: Android (arm64)',
                iconColor: Color(0xFF6C63FF),
              ),
              const SizedBox(height: 8),
              const StaticInfoCard(
                icon: Icons.storage,
                label: 'Backend: Firebase Firestore',
                iconColor: Color(0xFFFFBE0B),
              ),

              const SizedBox(height: 28),

              // ── STATEFUL SECTION ──
              Text(
                '⚡ Stateful Widgets',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withValues(alpha: 0.5),
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),

              // This is a StatefulWidget — it updates on interaction
              const InteractiveDemo(),
            ],
          ),
        ),
      ),
    );
  }
}
