import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/panel_card.dart';

class StreakBadgeRow extends StatelessWidget {
  const StreakBadgeRow({super.key});

  @override
  Widget build(BuildContext context) {
    final badges = [
      ('Consistent Logger', true),
      ('Balanced Meals', true),
      ('Goal Streak', false),
      ('Target Reached', false),
    ];
    return SizedBox(
      height: 128,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: badges.map((badge) {
          final earned = badge.$2;
          return Container(
            width: 168,
            margin: const EdgeInsets.only(right: 12),
            child: PanelCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    LucideIcons.award,
                    color: earned ? AppColors.accentGold : AppColors.textMuted,
                  ),
                  const Spacer(),
                  Text(
                    badge.$1,
                    style: AppTextStyles.labelStrong.copyWith(
                      color: earned
                          ? AppColors.textPrimary
                          : AppColors.textMuted,
                    ),
                  ),
                  Text(
                    earned ? 'Earned' : 'Locked',
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
