import 'goals.dart';

class UserProfile {
  const UserProfile({
    required this.name,
    required this.email,
    required this.goalType,
    required this.age,
    required this.sex,
    required this.heightCm,
    required this.weightKg,
    required this.activityLevel,
    required this.targetWeightKg,
    required this.targetDate,
    required this.calorieGoal,
    required this.proteinGoal,
    required this.carbGoal,
    required this.fatGoal,
    required this.waterGoalMl,
    required this.stepGoal,
    this.onboardingComplete = false,
  });

  final String name;
  final String email;
  final GoalType goalType;
  final int age;
  final String sex;
  final double heightCm;
  final double weightKg;
  final String activityLevel;
  final double targetWeightKg;
  final DateTime targetDate;
  final int calorieGoal;
  final int proteinGoal;
  final int carbGoal;
  final int fatGoal;
  final int waterGoalMl;
  final int stepGoal;
  final bool onboardingComplete;

  UserProfile copyWith({
    String? name,
    String? email,
    GoalType? goalType,
    int? age,
    String? sex,
    double? heightCm,
    double? weightKg,
    String? activityLevel,
    double? targetWeightKg,
    DateTime? targetDate,
    int? calorieGoal,
    int? proteinGoal,
    int? carbGoal,
    int? fatGoal,
    int? waterGoalMl,
    int? stepGoal,
    bool? onboardingComplete,
  }) {
    return UserProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      goalType: goalType ?? this.goalType,
      age: age ?? this.age,
      sex: sex ?? this.sex,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      activityLevel: activityLevel ?? this.activityLevel,
      targetWeightKg: targetWeightKg ?? this.targetWeightKg,
      targetDate: targetDate ?? this.targetDate,
      calorieGoal: calorieGoal ?? this.calorieGoal,
      proteinGoal: proteinGoal ?? this.proteinGoal,
      carbGoal: carbGoal ?? this.carbGoal,
      fatGoal: fatGoal ?? this.fatGoal,
      waterGoalMl: waterGoalMl ?? this.waterGoalMl,
      stepGoal: stepGoal ?? this.stepGoal,
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
    );
  }

  static UserProfile sample() => UserProfile(
    name: 'Grace',
    email: 'grace@example.com',
    goalType: GoalType.weightLoss,
    age: 28,
    sex: 'Other',
    heightCm: 175,
    weightKg: 82,
    activityLevel: 'Moderate',
    targetWeightKg: 74,
    targetDate: DateTime.now().add(const Duration(days: 120)),
    calorieGoal: 2100,
    proteinGoal: 150,
    carbGoal: 230,
    fatGoal: 65,
    waterGoalMl: 2500,
    stepGoal: 9000,
  );
}
