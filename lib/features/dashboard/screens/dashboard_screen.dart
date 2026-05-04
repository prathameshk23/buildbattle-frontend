import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/loading_shimmer.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/calorie_ring_card.dart';
import '../widgets/daily_greeting_header.dart';
import '../widgets/macro_bar_card.dart';
import '../widgets/steps_card.dart';
import '../widgets/water_tracker_card.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(dashboardProvider);
    return data.when(
      loading: () => const Padding(
        padding: EdgeInsets.all(20),
        child: LoadingShimmer(height: 500),
      ),
      error: (error, stackTrace) => Center(child: Text(error.toString())),
      data: (data) => ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const DailyGreetingHeader(name: 'Grace'),
          const SizedBox(height: 18),
          CalorieRingCard(
            eaten: data.calories,
            goal: data.goalCalories,
            burned: data.burned,
          ),
          const SizedBox(height: 14),
          MacroBarCard(protein: data.protein, carbs: data.carbs, fat: data.fat),
          const SizedBox(height: 14),
          WaterTrackerCard(waterMl: data.waterMl, goalMl: data.waterGoalMl),
          const SizedBox(height: 14),
          StepsCard(steps: data.steps, goal: data.stepGoal),
        ].animate(interval: 50.ms).fadeIn(duration: 300.ms).slideY(begin: 0.06),
      ),
    );
  }
}
