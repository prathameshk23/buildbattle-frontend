import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/models/food_item.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/panel_card.dart';
import '../providers/diary_provider.dart';

class BarcodeScannerSheet extends ConsumerStatefulWidget {
  const BarcodeScannerSheet({super.key, required this.meal});

  final String meal;

  @override
  ConsumerState<BarcodeScannerSheet> createState() => _BarcodeScannerSheetState();
}

class _BarcodeScannerSheetState extends ConsumerState<BarcodeScannerSheet> {
  final _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
  );
  bool _busy = false;
  String? _barcode;
  FoodItem? _food;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 16),
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: 260,
            child: Stack(
              children: [
                MobileScanner(controller: _controller, onDetect: _onDetect),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 2,
                    margin: const EdgeInsets.symmetric(horizontal: 36),
                    color: AppColors.primaryViolet,
                  ),
                ),
                if (_busy)
                  const Center(
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.black45),
                      child: Padding(
                        padding: EdgeInsets.all(14),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          _barcode == null ? 'Point at barcode.' : 'Barcode $_barcode',
          style: AppTextStyles.caption,
          textAlign: TextAlign.center,
        ),
        if (_food != null) ...[
          const SizedBox(height: 12),
          PanelCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_food!.name, style: AppTextStyles.labelStrong),
                const SizedBox(height: 6),
                Text(
                  '${_food!.brand} · ${_food!.servingG.round()}g\n'
                  'P ${_food!.protein}g / C ${_food!.carbs}g / F ${_food!.fat}g',
                  style: AppTextStyles.caption,
                ),
                const SizedBox(height: 12),
                AppButton(
                  label: 'Add ${_food!.kcal} kcal',
                  icon: LucideIcons.plus,
                  onPressed: () async {
                    await ref
                        .read(diaryProvider.notifier)
                        .add(widget.meal, _food!);
                    if (context.mounted) Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_busy || _food != null) return;
    String? code;
    for (final barcode in capture.barcodes) {
      final value = barcode.rawValue;
      if (value != null && RegExp(r'^\d{8,14}$').hasMatch(value)) {
        code = value;
        break;
      }
    }
    if (code == null) return;

    setState(() {
      _busy = true;
      _barcode = code;
    });
    await _controller.stop();

    try {
      final food = await ref.read(diaryProvider.notifier).lookupBarcode(code);
      if (mounted) setState(() => _food = food);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.toString())));
        await _controller.start();
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }
}
