import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyles {
  const AppTextStyles._();

  static TextStyle get displayHero => GoogleFonts.nunito(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  static TextStyle get displayTitle => GoogleFonts.nunito(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  static TextStyle get sectionTitle => GoogleFonts.nunito(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle get cardValue => GoogleFonts.nunito(
    fontSize: 36,
    fontWeight: FontWeight.w800,
    color: AppColors.textOnPrimary,
  );

  static TextStyle get cardValueSmall => GoogleFonts.nunito(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textOnPrimary,
  );

  static TextStyle get cardLabel => GoogleFonts.nunito(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: AppColors.textOnPrimary,
    letterSpacing: 1.2,
  );

  static TextStyle get bodyLarge => GoogleFonts.nunito(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static TextStyle get bodyMedium => GoogleFonts.nunito(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static TextStyle get bodySmall => GoogleFonts.nunito(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static TextStyle get labelButton => GoogleFonts.nunito(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.textOnPrimary,
    letterSpacing: 0.2,
  );

  static TextStyle get labelStrong => GoogleFonts.nunito(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle get labelCaps => GoogleFonts.nunito(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: 1.4,
  );

  static TextStyle get caption => GoogleFonts.nunito(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static TextStyle get captionMedium => GoogleFonts.nunito(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );

  static TextStyle get micro => GoogleFonts.nunito(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: AppColors.textMuted,
  );

  static TextStyle get stepLabel => GoogleFonts.nunito(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: AppColors.textMuted,
    letterSpacing: 0.5,
  );

  static TextStyle get displaySub => sectionTitle;
  static TextStyle get body => bodyMedium;
}
