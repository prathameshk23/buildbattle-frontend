import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get dark {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.backgroundDeep,
      colorScheme: const ColorScheme.dark(
        surface: AppColors.backgroundPanel,
        primary: AppColors.accentSaber,
        secondary: AppColors.accentStraw,
        tertiary: AppColors.accentForce,
        error: AppColors.accentRed,
      ),
      textTheme: GoogleFonts.exo2TextTheme(base.textTheme).apply(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.backgroundDeep,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: AppTextStyles.displaySub,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.backgroundPanel,
        selectedItemColor: AppColors.accentSaber,
        unselectedItemColor: AppColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.backgroundElevated,
        contentTextStyle: AppTextStyles.body,
      ),
    );
  }
}
