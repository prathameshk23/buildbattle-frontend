import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/models/goals.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/panel_card.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/profile_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 42,
                backgroundColor: AppColors.backgroundElevated,
                child: Text(
                  (profile.name.isEmpty ? '?' : profile.name[0]).toUpperCase(),
                  style: AppTextStyles.displaySub,
                ),
              ),
              const SizedBox(height: 10),
              Text(profile.name, style: AppTextStyles.displaySub),
              Text(
                profile.goalType.mission,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.accentStraw,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _section('Biometrics', [
          '${profile.age} years',
          '${profile.heightCm.round()} cm',
          '${profile.weightKg.toStringAsFixed(1)} kg',
          profile.activityLevel,
        ]),
        _section('Goal targets', [
          '${profile.calorieGoal} kcal',
          '${profile.waterGoalMl} ml water',
          '${profile.stepGoal} steps',
        ]),
        _section('Preferences', ['Metric units', 'Notifications enabled']),
        PanelCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Account', style: AppTextStyles.displaySub),
              const SizedBox(height: 8),
              Text(profile.email, style: AppTextStyles.caption),
              const SizedBox(height: 14),
              AppButton(
                label: 'Sign out',
                icon: LucideIcons.logOut,
                variant: AppButtonVariant.danger,
                onPressed: () async {
                  await ref.read(authProvider.notifier).signOut();
                  if (context.mounted) context.go('/auth/login');
                },
              ),
            ],
          ),
        ),
      ].animate(interval: 50.ms).fadeIn(duration: 300.ms).slideY(begin: 0.06),
    );
  }

  Widget _section(String title, List<String> values) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: PanelCard(
        leftBorderAccent: AppColors.accentStraw,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyles.displaySub),
            const SizedBox(height: 8),
            ...values.map(
              (value) => ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                title: Text(value, style: AppTextStyles.body),
                trailing: const Icon(LucideIcons.chevronRight, size: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
