import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class PanelCard extends StatelessWidget {
  const PanelCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.leftBorderAccent,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? leftBorderAccent;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.backgroundPanel,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      foregroundDecoration: leftBorderAccent == null
          ? null
          : BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border(
                left: BorderSide(color: leftBorderAccent!, width: 2),
              ),
            ),
      child: child,
    );
    if (onTap == null) return card;
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: card,
    );
  }
}
