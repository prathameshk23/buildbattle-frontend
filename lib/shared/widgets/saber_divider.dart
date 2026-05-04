import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class SaberDivider extends StatelessWidget {
  const SaberDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            AppColors.accentSaber,
            Colors.transparent,
          ],
        ),
        boxShadow: [BoxShadow(color: AppColors.glowSaber, blurRadius: 10)],
      ),
    );
  }
}
