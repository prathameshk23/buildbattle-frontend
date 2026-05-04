import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const backgroundPrimary = Color(0xFFFFFFFF);
  static const backgroundSoft = Color(0xFFF4F5FF);
  static const backgroundCard = Color(0xFFFFFFFF);
  static const backgroundElevated = Color(0xFFF8F8FF);
  static const primaryViolet = Color(0xFF7C6FF7);
  static const primaryVioletLight = Color(0xFF9B8FFF);
  static const primaryVioletPale = Color(0xFFECEAFF);
  static const gradientStart = Color(0xFF8B7FFF);
  static const gradientEnd = Color(0xFF6A5FF0);
  static const accentCyan = Color(0xFF4FC3F7);
  static const accentBlue = Color(0xFF4A90D9);
  static const accentTeal = Color(0xFF26C6DA);
  static const accentOrange = Color(0xFFFF7043);
  static const accentGold = Color(0xFFFFB300);
  static const cardCalories = Color(0xFF7C6FF7);
  static const cardWeight = Color(0xFF9B8FFF);
  static const cardWater = Color(0xFF4A90D9);
  static const cardSteps = Color(0xFF2D3561);
  static const textPrimary = Color(0xFF1A1D2E);
  static const textSecondary = Color(0xFF6B7280);
  static const textMuted = Color(0xFFB0B8D0);
  static const textOnPrimary = Color(0xFFFFFFFF);
  static const textAccent = Color(0xFF7C6FF7);
  static const textLink = Color(0xFF4A90D9);
  static const borderLight = Color(0xFFEEEFF5);
  static const borderMedium = Color(0xFFD8DAE8);
  static const borderFocus = Color(0xFF7C6FF7);
  static const success = Color(0xFF34C77B);
  static const warning = Color(0xFFFFB300);
  static const error = Color(0xFFFF3B5C);
  static const stepActive = Color(0xFF7C6FF7);
  static const stepComplete = Color(0xFF7C6FF7);
  static const stepInactive = Color(0xFFE0E0F0);
  static const pageBackground = Color(0xFFF0F1FA);

  static const gradientCta = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [gradientStart, gradientEnd],
  );

  static const gradientCalories = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gradientStart, gradientEnd],
  );

  static const gradientWater = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accentBlue, Color(0xFF357ABD)],
  );

  static const gradientSteps = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [cardSteps, Color(0xFF1A2040)],
  );

  static Color get shadowCard => primaryViolet.withValues(alpha: 0.10);
  static Color get shadowElevated => primaryViolet.withValues(alpha: 0.14);
  static Color get shadowButton => primaryViolet.withValues(alpha: 0.35);
}
