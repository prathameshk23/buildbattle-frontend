import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_endpoints.dart';
import '../../../core/network/dio_client.dart';
import '../../../shared/models/goals.dart';
import '../../../shared/models/user_profile.dart';

final profileProvider = FutureProvider<UserProfile>((ref) async {
  final dio = ref.read(dioClientProvider).dio;
  final responses = await Future.wait([
    dio.get(ApiEndpoints.profile),
    dio.get(ApiEndpoints.goals),
  ]);
  final profile = responses[0].data['data'] as Map<String, dynamic>? ?? {};
  final goals = responses[1].data['data'] as Map<String, dynamic>? ?? {};

  int readInt(Map<String, dynamic> map, String key, int fallback) =>
      (num.tryParse(map[key]?.toString() ?? '') ?? fallback).round();
  double readDouble(Map<String, dynamic> map, String key, double fallback) =>
      (num.tryParse(map[key]?.toString() ?? '') ?? fallback).toDouble();

  final targetDate =
      DateTime.tryParse(goals['target_date']?.toString() ?? '') ??
          DateTime.now().add(const Duration(days: 120));
  final goalType = switch (profile['goal_type']?.toString()) {
    'weight_gain' => GoalType.weightGain,
    'maintenance' => GoalType.maintenance,
    _ => GoalType.weightLoss,
  };

  return UserProfile(
    name: profile['display_name']?.toString() ?? 'Athlete',
    email: '',
    goalType: goalType,
    age: readInt(profile, 'age', 25),
    sex: profile['sex']?.toString() ?? 'male',
    heightCm: readDouble(profile, 'height_cm', 170),
    weightKg: readDouble(profile, 'weight_kg', 70),
    activityLevel: profile['activity_level']?.toString() ?? 'moderately_active',
    targetWeightKg: readDouble(goals, 'target_weight_kg', 70),
    targetDate: targetDate,
    calorieGoal: readInt(goals, 'daily_kcal', 2000),
    proteinGoal: readInt(goals, 'protein_g', 150),
    carbGoal: readInt(goals, 'carbs_g', 225),
    fatGoal: readInt(goals, 'fat_g', 56),
    waterGoalMl: readInt(goals, 'water_ml', 2500),
    stepGoal: readInt(goals, 'steps', 10000),
    onboardingComplete: true,
  );
});
