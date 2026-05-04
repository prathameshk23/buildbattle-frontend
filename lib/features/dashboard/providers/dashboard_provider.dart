import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardData {
  const DashboardData({
    required this.calories,
    required this.goalCalories,
    required this.burned,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.waterMl,
    required this.waterGoalMl,
    required this.steps,
    required this.stepGoal,
  });

  final int calories;
  final int goalCalories;
  final int burned;
  final int protein;
  final int carbs;
  final int fat;
  final int waterMl;
  final int waterGoalMl;
  final int steps;
  final int stepGoal;
}

final dashboardProvider = FutureProvider<DashboardData>((ref) async {
  await Future<void>.delayed(const Duration(milliseconds: 350));
  return const DashboardData(
    calories: 1240,
    goalCalories: 2100,
    burned: 260,
    protein: 92,
    carbs: 145,
    fat: 39,
    waterMl: 1500,
    waterGoalMl: 2500,
    steps: 6412,
    stepGoal: 9000,
  );
});
