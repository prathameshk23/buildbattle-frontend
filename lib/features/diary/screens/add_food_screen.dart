import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/models/food_item.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/panel_card.dart';
import '../providers/diary_provider.dart';
import '../widgets/barcode_scanner_sheet.dart';

class AddFoodScreen extends ConsumerWidget {
  const AddFoodScreen({super.key, required this.meal});
  final String meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Add to $meal', style: AppTextStyles.displaySub),
              const SizedBox(height: 8),
              const TabBar(
                tabs: [
                  Tab(icon: Icon(LucideIcons.search)),
                  Tab(icon: Icon(LucideIcons.camera)),
                  Tab(icon: Icon(LucideIcons.scanLine)),
                ],
              ),
              SizedBox(
                height: 460,
                child: TabBarView(
                  children: [
                    _FoodSearch(meal: meal),
                    _AiFoodScan(meal: meal),
                    BarcodeScannerSheet(meal: meal),
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

class _FoodSearch extends ConsumerStatefulWidget {
  const _FoodSearch({required this.meal});
  final String meal;

  @override
  ConsumerState<_FoodSearch> createState() => _FoodSearchState();
}

class _FoodSearchState extends ConsumerState<_FoodSearch> {
  final _query = TextEditingController();
  String _term = '';

  @override
  Widget build(BuildContext context) {
    final results = ref.watch(foodSearchProvider(_term));
    return ListView(
      padding: const EdgeInsets.only(top: 16),
      children: [
        AppTextField(
          label: 'Search foods',
          controller: _query,
          prefixIcon: LucideIcons.search,
          onChanged: (value) => setState(() => _term = value),
        ),
        const SizedBox(height: 12),
        ...results.when(
          loading: () => const [Center(child: CircularProgressIndicator())],
          error: (error, _) => [Text(error.toString())],
          data: (foods) => foods.isEmpty
              ? [Text('Search food database.', style: AppTextStyles.caption)]
              : foods
                  .map(
                    (food) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _FoodCard(
                        food: food,
                        onTap: () => _addFood(context, ref, widget.meal, food),
                      ),
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }
}

class _AiFoodScan extends ConsumerStatefulWidget {
  const _AiFoodScan({required this.meal});
  final String meal;

  @override
  ConsumerState<_AiFoodScan> createState() => _AiFoodScanState();
}

class _AiFoodScanState extends ConsumerState<_AiFoodScan> {
  FoodItem? _food;
  bool _busy = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 18),
      children: [
        PanelCard(
          child: Column(
            children: [
              const Icon(LucideIcons.camera, size: 44, color: AppColors.accentTeal),
              const SizedBox(height: 12),
              Text('Scan meal with local AI', style: AppTextStyles.labelStrong),
              const SizedBox(height: 6),
              Text(
                'Uses LM Studio on backend.',
                style: AppTextStyles.caption,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: _busy ? 'Scanning' : 'Camera',
                      icon: LucideIcons.camera,
                      onPressed: _busy
                          ? null
                          : () => _pickAndScan(ImageSource.camera),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: AppButton(
                      label: 'Gallery',
                      icon: LucideIcons.imagePlus,
                      variant: AppButtonVariant.secondary,
                      onPressed: _busy
                          ? null
                          : () => _pickAndScan(ImageSource.gallery),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (_food != null) ...[
          const SizedBox(height: 12),
          _FoodCard(
            food: _food!,
            onTap: () => _addFood(context, ref, widget.meal, _food!),
          ),
        ],
      ],
    );
  }

  Future<void> _pickAndScan(ImageSource source) async {
    final picked = await ImagePicker().pickImage(
      source: source,
      imageQuality: 82,
      maxWidth: 1400,
    );
    if (picked == null) return;
    setState(() => _busy = true);
    try {
      final bytes = await picked.readAsBytes();
      final mimeType = picked.mimeType ?? 'image/jpeg';
      final food = await ref
          .read(diaryProvider.notifier)
          .scanFood(bytes: bytes, mimeType: mimeType);
      if (mounted) setState(() => _food = food);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.toString())),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }
}

class _FoodCard extends StatelessWidget {
  const _FoodCard({required this.food, required this.onTap});
  final FoodItem food;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final confidence = food.confidence == null
        ? ''
        : ' · ${(food.confidence! * 100).round()}% sure';
    return PanelCard(
      onTap: onTap,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(food.name, style: AppTextStyles.labelStrong),
        subtitle: Text(
          '${food.brand} · ${food.servingG.round()}g$confidence\nP ${food.protein}g / C ${food.carbs}g / F ${food.fat}g',
          style: AppTextStyles.caption,
        ),
        trailing: Text('${food.kcal} kcal', style: AppTextStyles.labelStrong),
      ),
    );
  }
}

Future<void> _addFood(
  BuildContext context,
  WidgetRef ref,
  String meal,
  FoodItem food,
) async {
  await ref.read(diaryProvider.notifier).add(meal, food);
  if (context.mounted) Navigator.pop(context);
}
