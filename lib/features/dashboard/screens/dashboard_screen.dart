import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/loading_shimmer.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_text_field.dart';
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
          DailyGreetingHeader(name: data.name),
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
          StepsCard(
            steps: data.steps,
            goal: data.stepGoal,
            onEdit: () => _openStepsSheet(context, ref, data.steps),
          ),
        ].animate(interval: 50.ms).fadeIn(duration: 300.ms).slideY(begin: 0.06),
      ),
    );
  }

  Future<void> _openStepsSheet(
    BuildContext context,
    WidgetRef ref,
    int currentSteps,
  ) async {
    final controller = TextEditingController(text: '$currentSteps');
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: 20 + MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTextField(
                label: 'Steps today',
                controller: controller,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: '+500',
                      variant: AppButtonVariant.secondary,
                      onPressed: () {
                        final value = int.tryParse(controller.text) ?? 0;
                        controller.text = '${value + 500}';
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppButton(
                      label: '+1000',
                      variant: AppButtonVariant.secondary,
                      onPressed: () {
                        final value = int.tryParse(controller.text) ?? 0;
                        controller.text = '${value + 1000}';
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              AppButton(
                label: 'Save steps',
                onPressed: () async {
                  final value = int.tryParse(controller.text) ?? currentSteps;
                  final synced = await ref
                      .read(dashboardActionsProvider)
                      .updateTodaySteps(value.clamp(0, 200000));
                  if (!context.mounted) return;
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        synced
                            ? 'Steps saved'
                            : 'Steps saved locally. Backend sync failed.',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
