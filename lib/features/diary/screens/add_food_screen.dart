import 'package:flutter/material.dart';

import '../../../core/theme/app_text_styles.dart';
import '../../../shared/models/food_item.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/panel_card.dart';
import '../widgets/barcode_scanner_sheet.dart';
import '../widgets/food_search_delegate.dart';

class AddFoodScreen extends StatelessWidget {
  const AddFoodScreen({super.key, required this.meal});
  final String meal;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Add to $meal', style: AppTextStyles.displaySub),
              const TabBar(
                tabs: [
                  Tab(text: 'Search'),
                  Tab(text: 'Barcode'),
                  Tab(text: 'Recent'),
                ],
              ),
              SizedBox(
                height: 420,
                child: TabBarView(
                  children: [
                    _FoodList(meal: meal),
                    const BarcodeScannerSheet(),
                    _FoodList(meal: meal),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FoodList extends StatelessWidget {
  const _FoodList({required this.meal});
  final String meal;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 16),
      children: [
        const AppTextField(label: 'Search foods'),
        const SizedBox(height: 12),
        ...sampleFoods.map(
          (food) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: PanelCard(
              onTap: () => _openDetail(context, food),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(food.name, style: AppTextStyles.labelStrong),
                subtitle: Text(
                  '${food.brand} - ${food.kcal} kcal per serving',
                  style: AppTextStyles.caption,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _openDetail(BuildContext context, FoodItem food) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => PanelCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(food.name, style: AppTextStyles.displaySub),
            Text(
              'P ${food.protein}g / C ${food.carbs}g / F ${food.fat}g',
              style: AppTextStyles.caption,
            ),
            const SizedBox(height: 18),
            AppButton(
              label: 'Add to $meal',
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
