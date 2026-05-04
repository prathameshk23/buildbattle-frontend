import 'package:flutter_riverpod/flutter_riverpod.dart';

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
}
