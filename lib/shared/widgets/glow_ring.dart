import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class GlowRing extends StatelessWidget {
  const GlowRing({
    super.key,
    required this.value,
    required this.size,
    required this.label,
    required this.sublabel,
    this.trackColor = AppColors.borderLight,
    this.arcColor = AppColors.primaryViolet,
    this.glowColor,
    this.strokeWidth = 14,
  });

  final double value;
  final double size;
  final String label;
  final String sublabel;
  final Color trackColor;
  final Color arcColor;
  final Color? glowColor;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: CustomPaint(
        painter: _GlowRingPainter(
          value: value.clamp(0, 1.2),
          trackColor: trackColor,
          arcColor: arcColor,
          glowColor: glowColor ?? arcColor.withValues(alpha: 0.28),
          strokeWidth: strokeWidth,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                textAlign: TextAlign.center,
                style: AppTextStyles.labelStrong,
              ),
              const SizedBox(height: 4),
              Text(sublabel, style: AppTextStyles.caption),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlowRingPainter extends CustomPainter {
  const _GlowRingPainter({
    required this.value,
    required this.trackColor,
    required this.arcColor,
    required this.glowColor,
    required this.strokeWidth,
  });

  final double value;
  final Color trackColor;
  final Color arcColor;
  final Color glowColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final inset = strokeWidth / 2 + 8;
    final arcRect = rect.deflate(inset);
    final start = -math.pi / 2;
    final sweep = math.pi * 2 * value.clamp(0, 1);
    final trackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = trackColor;
    final glowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth + 4
      ..strokeCap = StrokeCap.round
      ..color = glowColor
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);
    final arcPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = arcColor;
    canvas.drawArc(arcRect, 0, math.pi * 2, false, trackPaint);
    canvas.drawArc(arcRect, start, sweep, false, glowPaint);
    canvas.drawArc(arcRect, start, sweep, false, arcPaint);
  }

  @override
  bool shouldRepaint(covariant _GlowRingPainter oldDelegate) {
    return oldDelegate.value != value || oldDelegate.arcColor != arcColor;
  }
}
