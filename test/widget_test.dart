import 'package:buildbattle_frontend/shared/models/goals.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('goal labels expose mission names', () {
    expect(GoalType.weightLoss.title, 'Weight Loss');
    expect(GoalType.fitnessCoach.mission, 'Fitness Coach Mission');
  });
}
