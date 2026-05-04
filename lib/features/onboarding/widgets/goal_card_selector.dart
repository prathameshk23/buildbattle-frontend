import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/models/goals.dart';

class GoalCardSelector extends StatelessWidget {
  const GoalCardSelector({
    super.key,
    required this.goal,
    required this.selected,
    required this.onTap,
  });

  final GoalType goal;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final (icon, accent, description) = switch (goal) {
      GoalType.weightLoss => (
        LucideIcons.flame,
        AppColors.primaryViolet,
        'Trim the load and move with speed.',
      ),
      GoalType.weightGain => (
        LucideIcons.zap,
        AppColors.accentGold,
        'Build mass for the next grand voyage.',
      ),
      GoalType.fitnessCoach => (
        LucideIcons.dumbbell,
        AppColors.accentTeal,
        'Train with structure and steady support.',
      ),
      GoalType.maintenance => (
        LucideIcons.compass,
        AppColors.error,
        'Hold balance while the seas change.',
      ),
    };
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.backgroundCard,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: selected ? accent : AppColors.borderLight,
            width: selected ? 1.5 : 1,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: accent.withValues(alpha: 0.22),
                    blurRadius: 18,
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: accent, size: 24),
                const Spacer(),
                if (selected)
                  Icon(LucideIcons.checkCircle2, color: accent, size: 20),
              ],
            ),
            const Spacer(),
            Text(goal.title, style: AppTextStyles.labelStrong),
            const SizedBox(height: 6),
            Text(description, style: AppTextStyles.caption, maxLines: 2),
          ],
        ),
      ),
    );
  }
}
