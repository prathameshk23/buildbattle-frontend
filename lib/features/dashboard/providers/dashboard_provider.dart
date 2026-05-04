import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/network/api_endpoints.dart';
import '../../../core/network/dio_client.dart';

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
    required this.name,
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
  final String name;
}

final dashboardProvider = FutureProvider<DashboardData>((ref) async {
  final dio = ref.read(dioClientProvider).dio;
  final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final prefs = await SharedPreferences.getInstance();
  final localSteps = prefs.getInt('steps_$today');
  final responses = await Future.wait([
    dio.get(ApiEndpoints.diary, queryParameters: {'date': today}),
    dio.get(ApiEndpoints.goals),
    dio.get(ApiEndpoints.water, queryParameters: {'date': today}),
    dio.get(ApiEndpoints.steps, queryParameters: {'date': today}),
    dio.get(ApiEndpoints.profile),
  ]);

  final diarySections =
      responses[0].data['data']?['sections'] as Map<String, dynamic>? ?? {};
  final entries = diarySections.values
      .expand((items) => items is List ? items : const [])
      .whereType<Map<String, dynamic>>();
  final goals = responses[1].data['data'] as Map<String, dynamic>? ?? {};
  final water = responses[2].data['data'] as Map<String, dynamic>? ?? {};
  final steps = responses[3].data['data'] as Map<String, dynamic>? ?? {};
  final profile = responses[4].data['data'] as Map<String, dynamic>? ?? {};

  int readInt(Map<String, dynamic> map, String key) =>
      (num.tryParse(map[key]?.toString() ?? '') ?? 0).round();

  final totals = entries.fold(
    {'kcal': 0, 'protein_g': 0, 'carbs_g': 0, 'fat_g': 0},
    (acc, item) => {
      'kcal': acc['kcal']! + readInt(item, 'kcal'),
      'protein_g': acc['protein_g']! + readInt(item, 'protein_g'),
      'carbs_g': acc['carbs_g']! + readInt(item, 'carbs_g'),
      'fat_g': acc['fat_g']! + readInt(item, 'fat_g'),
    },
  );

  return DashboardData(
    calories: totals['kcal']!,
    goalCalories: readInt(goals, 'daily_kcal'),
    burned: 0,
    protein: totals['protein_g']!,
    carbs: totals['carbs_g']!,
    fat: totals['fat_g']!,
    waterMl: readInt(water, 'total_ml'),
    waterGoalMl: readInt(goals, 'water_ml'),
    steps: localSteps ?? readInt(steps, 'count'),
    stepGoal: readInt(goals, 'steps'),
    name: profile['display_name']?.toString() ?? 'Athlete',
  );
});

final dashboardActionsProvider = Provider<DashboardActions>((ref) {
  return DashboardActions(ref);
});

class DashboardActions {
  const DashboardActions(this.ref);

  final Ref ref;

  Future<bool> updateTodaySteps(int count) async {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('steps_$today', count);
    ref.invalidate(dashboardProvider);

    try {
      await ref.read(dioClientProvider).dio.post(
        ApiEndpoints.steps,
        data: {'date': today, 'count': count},
      );
      ref.invalidate(dashboardProvider);
      return true;
    } catch (_) {
      return false;
    }
  }
}
