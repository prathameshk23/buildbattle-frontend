import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const backgroundPrimary = Color(0xFFFFFFFF);
  static const backgroundSoft = Color(0xFFF1F6F4);
  static const backgroundCard = Color(0xFFFFFFFF);
  static const backgroundElevated = Color(0xFFF7FAF8);
  static const primaryViolet = Color(0xFF188A6B);
  static const primaryVioletLight = Color(0xFF3DBA91);
  static const primaryVioletPale = Color(0xFFDDF4EC);
  static const gradientStart = Color(0xFF188A6B);
  static const gradientEnd = Color(0xFF1F6F8B);
  static const accentCyan = Color(0xFF2EA7A0);
  static const accentBlue = Color(0xFF1F6F8B);
  static const accentTeal = Color(0xFF34B27B);
  static const accentOrange = Color(0xFFE7653B);
  static const accentGold = Color(0xFFE2A72E);
  static const cardCalories = Color(0xFF188A6B);
  static const cardWeight = Color(0xFFE7653B);
  static const cardWater = Color(0xFF1F6F8B);
  static const cardSteps = Color(0xFF243B53);
  static const textPrimary = Color(0xFF18201D);
  static const textSecondary = Color(0xFF65746E);
  static const textMuted = Color(0xFF9AA8A2);
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
  static const pageBackground = Color(0xFFEFF4F1);

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
    colors: [cardSteps, Color(0xFF152638)],
  );

  static Color get shadowCard => primaryViolet.withValues(alpha: 0.10);
  static Color get shadowElevated => primaryViolet.withValues(alpha: 0.14);
  static Color get shadowButton => primaryViolet.withValues(alpha: 0.35);
}
