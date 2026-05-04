import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class StatChip extends StatelessWidget {
  const StatChip({
    super.key,
    required this.label,
    required this.color,
    this.value,
  });

  final String label;
  final Color color;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: value == null ? 24 : null,
      height: value == null ? 24 : null,
      alignment: Alignment.center,
      padding: value == null
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        value == null ? label : '$label $value',
        style: AppTextStyles.micro.copyWith(color: AppColors.textOnPrimary),
      ),
    );
  }
}
