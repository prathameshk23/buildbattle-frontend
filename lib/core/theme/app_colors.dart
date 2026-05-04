import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const backgroundDeep = Color(0xFF090B10);
  static const backgroundPanel = Color(0xFF0F1318);
  static const backgroundElevated = Color(0xFF161C24);
  static const accentSaber = Color(0xFF00D4FF);
  static const accentStraw = Color(0xFFFFD23F);
  static const accentForce = Color(0xFF8B5CF6);
  static const accentRed = Color(0xFFFF3B5C);
  static const textPrimary = Color(0xFFF0F4FF);
  static const textSecondary = Color(0xFF8A9BB5);
  static const textMuted = Color(0xFF3D4F6A);
  static const borderSubtle = Color(0xFF1E2A3A);

  static Color get glowSaber => accentSaber.withValues(alpha: 0.25);
  static Color get glowStraw => accentStraw.withValues(alpha: 0.20);
}
