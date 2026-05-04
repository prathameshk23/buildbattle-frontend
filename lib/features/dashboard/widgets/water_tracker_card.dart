import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/panel_card.dart';

class WaterTrackerCard extends StatelessWidget {
  const WaterTrackerCard({
    super.key,
    required this.waterMl,
    required this.goalMl,
  });
  final int waterMl;
  final int goalMl;

  @override
  Widget build(BuildContext context) {
    final filled = (waterMl / 250).round().clamp(0, 8);
    return PanelCard(
      leftBorderAccent: AppColors.accentStraw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Hydration', style: AppTextStyles.displaySub),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(8, (i) {
              final active = i < filled;
              return GestureDetector(
                onTap: () {},
                onLongPress: () {},
                child: Icon(
                  LucideIcons.glassWater,
                  color: active
                      ? AppColors.accentSaber
                      : AppColors.borderSubtle,
                ),
              );
            }),
          ),
          const SizedBox(height: 10),
          Text('$waterMl ml / $goalMl ml', style: AppTextStyles.caption),
        ],
      ),
    );
  }
}
