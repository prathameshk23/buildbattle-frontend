import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_text_styles.dart';
import '../../../shared/models/goals.dart';
import '../providers/onboarding_provider.dart';
import '../widgets/goal_card_selector.dart';

class StepGoalScreen extends ConsumerWidget {
  const StepGoalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(onboardingProvider).goalType;
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text('Choose your goal.', style: AppTextStyles.displayHero),
        const SizedBox(height: 18),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 0.92,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: GoalType.values.map((goal) {
            return GoalCardSelector(
              goal: goal,
              selected: selected == goal,
              onTap: () => ref.read(onboardingProvider.notifier).setGoal(goal),
            );
          }).toList(),
        ),
      ],
    );
  }
}
