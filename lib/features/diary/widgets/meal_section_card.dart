import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/theme/app_text_styles.dart';
import '../../../shared/models/diary_entry.dart';
import '../../../shared/widgets/panel_card.dart';
import 'food_entry_tile.dart';

class MealSectionCard extends StatelessWidget {
  const MealSectionCard({
    super.key,
    required this.meal,
    required this.entries,
    required this.onAdd,
    required this.onDelete,
  });
  final String meal;
  final List<DiaryEntry> entries;
  final VoidCallback onAdd;
  final ValueChanged<DiaryEntry> onDelete;

  @override
  Widget build(BuildContext context) {
    final kcal = entries.fold<int>(0, (sum, item) => sum + item.food.kcal);
    return PanelCard(
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        childrenPadding: EdgeInsets.zero,
        title: Text(meal, style: AppTextStyles.displaySub),
        subtitle: Text('$kcal kcal', style: AppTextStyles.caption),
        trailing: IconButton(
          onPressed: onAdd,
          icon: const Icon(LucideIcons.plus),
        ),
        children: entries
            .map(
              (entry) =>
                  FoodEntryTile(entry: entry, onDelete: () => onDelete(entry)),
            )
            .toList(),
      ),
    );
  }
}
