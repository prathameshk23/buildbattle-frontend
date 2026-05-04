import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/panel_card.dart';
import '../../../shared/widgets/stat_chip.dart';

class MacroBarCard extends StatelessWidget {
  const MacroBarCard({
    super.key,
    required this.protein,
    required this.carbs,
    required this.fat,
  });
  final int protein;
  final int carbs;
  final int fat;

  @override
  Widget build(BuildContext context) {
    return PanelCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Macros', style: AppTextStyles.displaySub),
          const SizedBox(height: 14),
          _bar('P', protein, 150, AppColors.primaryViolet),
          _bar('C', carbs, 230, AppColors.accentGold),
          _bar('F', fat, 65, AppColors.accentTeal),
        ],
      ),
    );
  }

  Widget _bar(String label, int value, int goal, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          StatChip(label: label, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                minHeight: 10,
                value: (value / goal).clamp(0, 1),
                color: color,
                backgroundColor: AppColors.borderLight,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text('$value / ${goal}g', style: AppTextStyles.caption),
        ],
      ),
    );
  }
}
