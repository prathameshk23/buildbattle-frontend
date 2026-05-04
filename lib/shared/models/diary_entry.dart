import 'food_item.dart';

class DiaryEntry {
  const DiaryEntry({
    this.id,
    required this.meal,
    required this.food,
    required this.serving,
  });

  final String? id;
  final String meal;
  final FoodItem food;
  final String serving;

  factory DiaryEntry.fromJson(Map<String, dynamic> json) => DiaryEntry(
    id: json['id']?.toString(),
    meal: _mealLabel(json['meal_section']?.toString() ?? 'breakfast'),
    food: FoodItem(
      name: json['food_name']?.toString() ?? 'Food',
      brand: 'Diary',
      kcal: (FoodItem.readNum(json['kcal']) ?? 0).round(),
      protein: (FoodItem.readNum(json['protein_g']) ?? 0).round(),
      carbs: (FoodItem.readNum(json['carbs_g']) ?? 0).round(),
      fat: (FoodItem.readNum(json['fat_g']) ?? 0).round(),
      servingG: FoodItem.readNum(json['serving_g']) ?? 100,
    ),
    serving: '${FoodItem.readNum(json['serving_g'])?.round() ?? 100}g',
  );

  static String sectionKey(String meal) => switch (meal) {
    'Breakfast' => 'breakfast',
    'Morning Snack' => 'morning_snack',
    'Lunch' => 'lunch',
    'Evening Snack' => 'evening_snack',
    'Dinner' => 'dinner',
    _ => 'breakfast',
  };

  static String _mealLabel(String key) => switch (key) {
    'morning_snack' => 'Morning Snack',
    'lunch' => 'Lunch',
    'evening_snack' => 'Evening Snack',
    'dinner' => 'Dinner',
    _ => 'Breakfast',
  };
}
