import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/panel_card.dart';
import '../../../shared/widgets/stat_chip.dart';
import '../providers/onboarding_provider.dart';

class StepTargetsScreen extends ConsumerWidget {
  const StepTargetsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(onboardingProvider);
    final notifier = ref.read(onboardingProvider.notifier);
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text('Set your targets.', style: AppTextStyles.displayHero),
        const SizedBox(height: 18),
        _TargetTile(
          label: 'Target weight',
          value: '${profile.targetWeightKg.toStringAsFixed(1)} kg',
          icon: LucideIcons.target,
        ),
        const SizedBox(height: 12),
        _TargetTile(
          label: 'Daily calorie goal',
          value: '${profile.calorieGoal} kcal',
          icon: LucideIcons.flame,
        ),
        const SizedBox(height: 12),
        PanelCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Macro split', style: AppTextStyles.labelStrong),
              const SizedBox(height: 12),
              _MacroSlider(
                label: 'Protein',
                value: profile.proteinGoal / 250,
                color: AppColors.primaryViolet,
              ),
              _MacroSlider(
                label: 'Carbs',
                value: profile.carbGoal / 350,
                color: AppColors.accentGold,
              ),
              _MacroSlider(
                label: 'Fat',
                value: profile.fatGoal / 120,
                color: AppColors.accentTeal,
              ),
              Wrap(
                spacing: 8,
                children: [
                  StatChip(
                    label: 'P',
                    value: '${profile.proteinGoal}g',
                    color: AppColors.primaryViolet,
                  ),
                  StatChip(
                    label: 'C',
                    value: '${profile.carbGoal}g',
                    color: AppColors.accentGold,
                  ),
                  StatChip(
                    label: 'F',
                    value: '${profile.fatGoal}g',
                    color: AppColors.accentTeal,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _TargetTile(
          label: 'Water goal',
          value: '${profile.waterGoalMl} ml',
          icon: LucideIcons.waves,
        ),
        const SizedBox(height: 12),
        _TargetTile(
          label: 'Step goal',
          value: '${profile.stepGoal}',
          icon: LucideIcons.footprints,
        ),
        const SizedBox(height: 16),
        AppButton(
          label: 'Recalculate from biometrics',
          icon: LucideIcons.refreshCw,
          variant: AppButtonVariant.ghost,
          onPressed: notifier.recalculateTargets,
        ),
      ],
    );
  }
}

class _TargetTile extends StatelessWidget {
  const _TargetTile({
    required this.label,
    required this.value,
    required this.icon,
  });
  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return PanelCard(
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryViolet),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: AppTextStyles.caption)),
          Text(value, style: AppTextStyles.labelStrong),
        ],
      ),
    );
  }
}

class _MacroSlider extends StatelessWidget {
  const _MacroSlider({
    required this.label,
    required this.value,
    required this.color,
  });
  final String label;
  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 64, child: Text(label, style: AppTextStyles.caption)),
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: color,
              thumbColor: color,
              inactiveTrackColor: AppColors.borderLight,
            ),
            child: Slider(value: value.clamp(0, 1), onChanged: (_) {}),
          ),
        ),
      ],
    );
  }
}
