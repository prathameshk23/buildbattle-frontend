import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/app_button.dart';
import '../widgets/onboarding_step_indicator.dart';
import 'onboarding_summary_screen.dart';
import 'step_biometrics_screen.dart';
import 'step_goal_screen.dart';
import 'step_name_screen.dart';
import 'step_targets_screen.dart';

class OnboardingShell extends StatefulWidget {
  const OnboardingShell({super.key, required this.initialStep});

  final int initialStep;

  @override
  State<OnboardingShell> createState() => _OnboardingShellState();
}

class _OnboardingShellState extends State<OnboardingShell> {
  late final PageController _controller = PageController(
    initialPage: widget.initialStep,
  );
  late int _step = widget.initialStep;
  final _paths = const [
    '/onboarding/name',
    '/onboarding/biometrics',
    '/onboarding/goal',
    '/onboarding/targets',
    '/onboarding/summary',
  ];

  void _go(int step) {
    setState(() => _step = step.clamp(0, 4));
    _controller.animateToPage(
      _step,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOut,
    );
    context.go(_paths[_step]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 18),
            OnboardingStepIndicator(currentStep: _step, totalSteps: 5),
            Expanded(
              child: PageView(
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  StepNameScreen(),
                  StepBiometricsScreen(),
                  StepGoalScreen(),
                  StepTargetsScreen(),
                  OnboardingSummaryScreen(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: 'Back',
                      variant: AppButtonVariant.ghost,
                      onPressed: _step == 0 ? null : () => _go(_step - 1),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppButton(
                      label: _step == 4 ? 'Review' : 'Next',
                      onPressed: _step == 4 ? null : () => _go(_step + 1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.06);
  }
}
