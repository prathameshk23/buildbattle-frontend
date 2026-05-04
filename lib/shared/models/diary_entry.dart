import 'food_item.dart';

class DiaryEntry {
  const DiaryEntry({
    required this.meal,
    required this.food,
    required this.serving,
  });

  final String meal;
  final FoodItem food;
  final String serving;
}
