import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../providers/diary_provider.dart';
import '../widgets/meal_section_card.dart';
import 'add_food_screen.dart';

class DiaryScreen extends ConsumerWidget {
  const DiaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(diaryProvider);
    final meals = [
      'Breakfast',
      'Morning Snack',
      'Lunch',
      'Evening Snack',
      'Dinner',
    ];
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        SizedBox(
          height: 48,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 7,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                selected: index == 3,
                label: Text(index == 3 ? 'Today' : '${index - 3}d'),
                selectedColor: AppColors.primaryViolet.withValues(alpha: 0.22),
                backgroundColor: AppColors.backgroundCard,
                onSelected: (_) {},
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        ...meals.map(
          (meal) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: MealSectionCard(
              meal: meal,
              entries: entries.where((entry) => entry.meal == meal).toList(),
              onAdd: () => showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                backgroundColor: AppColors.backgroundElevated,
                builder: (_) => AddFoodScreen(meal: meal),
              ),
              onDelete: ref.read(diaryProvider.notifier).remove,
            ),
          ),
        ),
      ].animate(interval: 50.ms).fadeIn(duration: 300.ms).slideY(begin: 0.06),
    );
  }
}
