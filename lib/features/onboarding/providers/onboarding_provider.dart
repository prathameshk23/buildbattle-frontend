import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/network/api_endpoints.dart';
import '../../../core/network/dio_client.dart';
import '../../../shared/models/goals.dart';
import '../../../shared/models/user_profile.dart';

final onboardingProvider = NotifierProvider<OnboardingNotifier, UserProfile>(
  OnboardingNotifier.new,
);

class OnboardingNotifier extends Notifier<UserProfile> {
  @override
  UserProfile build() => UserProfile.sample();

  void setIdentity(String name, String email) =>
      state = state.copyWith(name: name, email: email);
  void setBiometrics({
    int? age,
    String? sex,
    double? heightCm,
    double? weightKg,
    String? activityLevel,
  }) {
    state = state.copyWith(
      age: age,
      sex: sex,
      heightCm: heightCm,
      weightKg: weightKg,
      activityLevel: activityLevel,
    );
  }

  void setGoal(GoalType goalType) => state = state.copyWith(goalType: goalType);

  void setTargets({
    double? targetWeightKg,
    DateTime? targetDate,
    int? calorieGoal,
    int? proteinGoal,
    int? carbGoal,
    int? fatGoal,
    int? waterGoalMl,
    int? stepGoal,
  }) {
    state = state.copyWith(
      targetWeightKg: targetWeightKg,
      targetDate: targetDate,
      calorieGoal: calorieGoal,
      proteinGoal: proteinGoal,
      carbGoal: carbGoal,
      fatGoal: fatGoal,
      waterGoalMl: waterGoalMl,
      stepGoal: stepGoal,
    );
  }

  void recalculateTargets() {
    final calories = state.goalType == GoalType.weightGain ? 2600 : 2100;
    state = state.copyWith(
      calorieGoal: calories,
      proteinGoal: 150,
      carbGoal: 230,
      fatGoal: 65,
    );
  }

  Future<void> saveToBackend() async {
    final dio = ref.read(dioClientProvider).dio;
    await dio.put(
      ApiEndpoints.profile,
      data: {
        'display_name': state.name,
        'age': state.age,
        'sex': state.sex.toLowerCase() == 'female' ? 'female' : 'male',
        'height_cm': state.heightCm,
        'weight_kg': state.weightKg,
        'activity_level': switch (state.activityLevel.toLowerCase()) {
          'light' || 'lightly active' => 'lightly_active',
          'active' => 'very_active',
          'athlete' => 'extra_active',
          'very active' => 'very_active',
          'extra active' => 'extra_active',
          'moderate' || 'moderately active' => 'moderately_active',
          _ => 'sedentary',
        },
        'goal_type': switch (state.goalType) {
          GoalType.weightGain => 'weight_gain',
          GoalType.maintenance => 'maintenance',
          _ => 'weight_loss',
        },
      },
    );
    await dio.put(
      ApiEndpoints.goals,
      data: {
        'target_weight_kg': state.targetWeightKg,
        'target_date': DateFormat('yyyy-MM-dd').format(state.targetDate),
        'daily_kcal': state.calorieGoal,
        'protein_g': state.proteinGoal,
        'carbs_g': state.carbGoal,
        'fat_g': state.fatGoal,
        'water_ml': state.waterGoalMl,
        'steps': state.stepGoal,
      },
    );
  }
}
