import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/models/goals.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/panel_card.dart';
import '../../../shared/widgets/stat_chip.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/onboarding_provider.dart';

class OnboardingSummaryScreen extends ConsumerWidget {
  const OnboardingSummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(onboardingProvider);
    return ListView(
      padding: const EdgeInsets.all(24),
      children:
          [
            Text('Plan summary.', style: AppTextStyles.displayHero),
            const SizedBox(height: 8),
            Text(
              'Review your health profile before you begin.',
              style: AppTextStyles.body,
            ),
            const SizedBox(height: 18),
            _SummaryTile(
              icon: LucideIcons.user,
              label: 'Name & goal',
              value: '${profile.name} - ${profile.goalType.planLabel}',
            ),
            _SummaryTile(
              icon: LucideIcons.activity,
              label: 'Biometrics',
              value:
                  '${profile.age} yrs, ${profile.heightCm.round()} cm, ${profile.weightKg.toStringAsFixed(1)} kg, ${profile.activityLevel}',
            ),
            PanelCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        LucideIcons.flame,
                        color: AppColors.primaryViolet,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${profile.calorieGoal} kcal daily',
                        style: AppTextStyles.labelStrong,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
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
            _SummaryTile(
              icon: LucideIcons.waves,
              label: 'Water',
              value: '${profile.waterGoalMl} ml',
            ),
            _SummaryTile(
              icon: LucideIcons.footprints,
              label: 'Steps',
              value: '${profile.stepGoal} per day',
            ),
            _SummaryTile(
              icon: LucideIcons.calendarClock,
              label: 'Target',
              value:
                  '${profile.targetWeightKg.toStringAsFixed(1)} kg by ${DateFormat.yMMMd().format(profile.targetDate)}',
            ),
            const SizedBox(height: 12),
            AppButton(
              label: 'Edit details',
              variant: AppButtonVariant.ghost,
              onPressed: () => context.go('/onboarding/name'),
            ),
            const SizedBox(height: 10),
            AppButton(
              label: 'Start tracking',
              icon: LucideIcons.sparkles,
              onPressed: () async {
                await ref.read(onboardingProvider.notifier).saveToBackend();
                await ref.read(authProvider.notifier).completeOnboarding();
                if (context.mounted) context.go('/home/dashboard');
              },
            ),
          ].expand((child) sync* {
            yield child;
            if (child is _SummaryTile || child is PanelCard) {
              yield const SizedBox(height: 12);
            }
          }).toList(),
    );
  }
}

class _SummaryTile extends StatelessWidget {
  const _SummaryTile({
    required this.icon,
    required this.label,
    required this.value,
  });
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return PanelCard(
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryViolet),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.caption),
                const SizedBox(height: 4),
                Text(value, style: AppTextStyles.labelStrong),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
