import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../core/theme/app_colors.dart';

class BarcodeScannerSheet extends StatelessWidget {
  const BarcodeScannerSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MobileScanner(onDetect: (_) => Navigator.pop(context)),
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 2,
            margin: const EdgeInsets.symmetric(horizontal: 36),
            color: AppColors.primaryViolet,
          ),
        ),
      ],
    );
  }
}
