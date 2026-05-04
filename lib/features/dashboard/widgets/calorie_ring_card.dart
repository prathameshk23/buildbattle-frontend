import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/glow_ring.dart';
import '../../../shared/widgets/panel_card.dart';

class CalorieRingCard extends StatelessWidget {
  const CalorieRingCard({
    super.key,
    required this.eaten,
    required this.goal,
    required this.burned,
  });

  final int eaten;
  final int goal;
  final int burned;

  @override
  Widget build(BuildContext context) {
    final over = eaten > goal;
    final remaining = goal - eaten + burned;
    return PanelCard(
      child: Column(
        children: [
          GlowRing(
            value: eaten / goal,
            size: 220,
            arcColor: over ? AppColors.accentRed : AppColors.accentSaber,
            label: '$eaten / $goal kcal',
            sublabel: 'logged today',
          ),
          const SizedBox(height: 12),
          Text(
            '${remaining.abs()} kcal ${remaining >= 0 ? 'remaining' : 'over'}',
            style: AppTextStyles.displaySub.copyWith(
              color: remaining >= 0
                  ? AppColors.accentStraw
                  : AppColors.accentRed,
            ),
          ),
          Text('$burned kcal exercise offset', style: AppTextStyles.caption),
        ],
      ),
    );
  }
}
