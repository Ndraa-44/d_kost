import 'package:flutter/material.dart';

/// Centralized color palette for the TheKost application.
///
/// All UI colors should reference this class instead of using
/// hardcoded color values. This ensures visual consistency and
/// makes future theming/rebranding simple.
class AppColors {
  AppColors._(); // Prevent instantiation

  // ── Primary ──
  static const Color primary = Color(0xFF2563EB);
  static const Color primaryLight = Color(0xFFA5B4FC);
  static const Color accentPurple = Color(0xFF5A67D8);

  // ── Backgrounds ──
  static const Color background = Color(0xFFF8FAFC);
  static const Color white = Colors.white;
  static const Color cardBackground = Colors.white;

  // ── Text ──
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Colors.grey;

  // ── Semantic ──
  static const Color success = Color(0xFF16A34A);
  static const Color error = Color(0xFFDC2626);
  static const Color warning = Color(0xFFF59E0B);

  // ── Shadows ──
  static final Color cardShadow = Colors.black.withValues(alpha: 0.05);
}
