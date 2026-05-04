import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/panel_card.dart';

class StepsCard extends StatelessWidget {
  const StepsCard({
    super.key,
    required this.steps,
    required this.goal,
    required this.onEdit,
  });
  final int steps;
  final int goal;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return PanelCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Steps', style: AppTextStyles.displaySub),
              const Spacer(),
              IconButton(
                onPressed: onEdit,
                icon: const Icon(LucideIcons.plus, size: 18),
              ),
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: (steps / goal).clamp(0, 1),
              minHeight: 9,
              color: AppColors.accentTeal,
              backgroundColor: AppColors.borderLight,
            ),
          ),
          const SizedBox(height: 10),
          Text('$steps / $goal steps', style: AppTextStyles.caption),
        ],
      ),
    );
  }
}
