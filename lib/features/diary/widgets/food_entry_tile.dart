import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/models/diary_entry.dart';

class FoodEntryTile extends StatelessWidget {
  const FoodEntryTile({super.key, required this.entry, required this.onDelete});
  final DiaryEntry entry;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey('${entry.meal}${entry.food.name}'),
      background: Container(
        color: AppColors.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(Icons.delete),
      ),
      onDismissed: (_) => onDelete(),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(entry.food.name, style: AppTextStyles.body),
        subtitle: Text(entry.serving, style: AppTextStyles.caption),
        trailing: Text(
          '${entry.food.kcal} kcal',
          style: AppTextStyles.labelStrong,
        ),
      ),
    );
  }
}
