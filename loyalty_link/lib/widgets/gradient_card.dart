import 'package:flutter/material.dart';

/// A reusable gradient card widget used across multiple screens.
/// Accepts customizable title, subtitle, icon, and gradient colors.
class GradientCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final List<Color>? gradientColors;
  final VoidCallback? onTap;

  const GradientCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.iconColor = const Color(0xFF6C63FF),
    this.gradientColors,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: gradientColors ??
                [
                  iconColor.withValues(alpha: 0.3),
                  iconColor.withValues(alpha: 0.1),
                ],
          ),
          border: Border.all(color: iconColor.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconColor.withValues(alpha: 0.2),
              ),
              child: Icon(icon, color: iconColor, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              Icon(Icons.chevron_right,
                  color: Colors.white.withValues(alpha: 0.5)),
          ],
        ),
      ),
    );
  }
}
