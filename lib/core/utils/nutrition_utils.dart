int macroCalories({
  required int protein,
  required int carbs,
  required int fat,
}) {
  return protein * 4 + carbs * 4 + fat * 9;
}

double percent(num value, num goal) =>
    goal == 0 ? 0 : (value / goal).clamp(0, 1).toDouble();

String grams(int value) => '${value}g';
