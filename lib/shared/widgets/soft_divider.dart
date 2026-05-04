import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class SoftDivider extends StatelessWidget {
  const SoftDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            AppColors.primaryViolet,
            Colors.transparent,
          ],
        ),
        boxShadow: [BoxShadow(color: AppColors.shadowButton, blurRadius: 10)],
      ),
    );
  }
}
