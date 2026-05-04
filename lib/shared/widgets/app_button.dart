import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

enum AppButtonVariant { primary, secondary, ghost, danger }

class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.variant = AppButtonVariant.primary,
    this.fullWidth = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final AppButtonVariant variant;
  final bool fullWidth;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final isPrimary = widget.variant == AppButtonVariant.primary;
    final isDanger = widget.variant == AppButtonVariant.danger;
    final isGhost = widget.variant == AppButtonVariant.ghost;
    final foreground = isDanger
        ? AppColors.error
        : isGhost
        ? AppColors.textLink
        : isPrimary
        ? AppColors.textOnPrimary
        : AppColors.primaryViolet;
    final border = isPrimary
        ? Colors.transparent
        : isDanger
        ? AppColors.error
        : isGhost
        ? Colors.transparent
        : AppColors.primaryViolet;
    final fill = isGhost || isDanger || isPrimary
        ? Colors.transparent
        : AppColors.primaryVioletPale;

    return Listener(
      onPointerDown: (_) => setState(() => _pressed = true),
      onPointerCancel: (_) => setState(() => _pressed = false),
      onPointerUp: (_) => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1,
        duration: const Duration(milliseconds: 120),
        child: SizedBox(
          height: 52,
          width: widget.fullWidth ? double.infinity : null,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: fill,
              gradient: isPrimary ? AppColors.gradientCta : null,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: border, width: isPrimary ? 1.5 : 1),
              boxShadow: isPrimary
                  ? [
                      BoxShadow(
                        color: AppColors.shadowButton,
                        offset: const Offset(0, 6),
                        blurRadius: 20,
                      ),
                    ]
                  : null,
            ),
            child: TextButton.icon(
              onPressed: widget.onPressed,
              icon: widget.icon == null
                  ? const SizedBox.shrink()
                  : Icon(widget.icon, size: 18),
              label: Text(widget.label),
              style: TextButton.styleFrom(
                foregroundColor: foreground,
              textStyle: AppTextStyles.labelButton.copyWith(color: foreground),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
