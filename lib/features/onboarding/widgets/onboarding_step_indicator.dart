import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class OnboardingStepIndicator extends StatelessWidget {
  const OnboardingStepIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps, (index) {
        final completed = index < currentStep;
        final active = index == currentStep;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: active ? 28 : 10,
          height: 10,
          decoration: BoxDecoration(
            color: completed
                ? AppColors.accentStraw
                : active
                ? AppColors.accentSaber
                : AppColors.borderSubtle,
            borderRadius: BorderRadius.circular(999),
            boxShadow: active
                ? [BoxShadow(color: AppColors.glowSaber, blurRadius: 14)]
                : null,
          ),
        );
      }),
    );
  }
}
