import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/theme/app_colors.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({super.key, this.height = 96});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.backgroundPanel,
      highlightColor: AppColors.backgroundElevated,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: AppColors.backgroundPanel,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
