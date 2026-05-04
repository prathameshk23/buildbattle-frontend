enum GoalType { weightLoss, weightGain, fitnessCoach, maintenance }

extension GoalTypeLabel on GoalType {
  String get title => switch (this) {
    GoalType.weightLoss => 'Weight Loss',
    GoalType.weightGain => 'Weight Gain',
    GoalType.fitnessCoach => 'Fitness Coach',
    GoalType.maintenance => 'Maintenance',
  };

  String get planLabel => '$title Plan';
}
