import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/models/diary_entry.dart';
import '../../../shared/models/food_item.dart';

final diaryProvider = NotifierProvider<DiaryNotifier, List<DiaryEntry>>(
  DiaryNotifier.new,
);

class DiaryNotifier extends Notifier<List<DiaryEntry>> {
  @override
  List<DiaryEntry> build() => const [
    DiaryEntry(
      meal: 'Breakfast',
      food: FoodItem(
        name: 'Protein oats',
        brand: 'Kitchen',
        kcal: 420,
        protein: 31,
        carbs: 52,
        fat: 10,
      ),
      serving: '1 bowl',
    ),
    DiaryEntry(
      meal: 'Lunch',
      food: FoodItem(
        name: 'Grilled chicken rice',
        brand: 'Recent',
        kcal: 610,
        protein: 48,
        carbs: 76,
        fat: 13,
      ),
      serving: '1 plate',
    ),
  ];

  void add(String meal, FoodItem food) => state = [
    ...state,
    DiaryEntry(meal: meal, food: food, serving: '1 serving'),
  ];
  void remove(DiaryEntry entry) =>
      state = state.where((item) => item != entry).toList();
}
