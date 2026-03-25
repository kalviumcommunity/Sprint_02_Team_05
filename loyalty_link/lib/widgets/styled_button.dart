import 'package:flutter/material.dart';

/// A reusable styled button used across login, signup, and dashboard screens.
/// Supports loading state, custom colors, and full-width mode.
class StyledButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color backgroundColor;
  final Color textColor;
  final IconData? icon;
  final bool fullWidth;

  const StyledButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.backgroundColor = Colors.white,
    this.textColor = const Color(0xFF6C63FF),
    this.icon,
    this.fullWidth = true,
  });

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        elevation: 0,
      ),
      child: isLoading
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: textColor,
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 20),
                  const SizedBox(width: 8),
                ],
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
    );

    return fullWidth
        ? SizedBox(width: double.infinity, child: button)
        : button;
  }
}
