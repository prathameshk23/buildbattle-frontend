import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../providers/onboarding_provider.dart';
import '../widgets/biometric_input_tile.dart';

class StepBiometricsScreen extends ConsumerWidget {
  const StepBiometricsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(onboardingProvider);
    final notifier = ref.read(onboardingProvider.notifier);
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Set your baseline.',
                style: AppTextStyles.displayHero,
              ),
            ),
            SegmentedButton<bool>(
              segments: const [
                ButtonSegment(value: true, label: Text('Metric')),
                ButtonSegment(value: false, label: Text('Imp')),
              ],
              selected: const {true},
              style: SegmentedButton.styleFrom(
                selectedForegroundColor: AppColors.pageBackground,
                selectedBackgroundColor: AppColors.primaryViolet,
              ),
              onSelectionChanged: (_) {},
            ),
          ],
        ),
        const SizedBox(height: 20),
        BiometricInputTile(
          label: 'Age',
          value: '${profile.age}',
          trailing: StepperControl(
            value: profile.age,
            onChanged: (value) => notifier.setBiometrics(age: value.round()),
          ),
        ),
        const SizedBox(height: 12),
        BiometricInputTile(
          label: 'Biological sex',
          value: profile.sex,
          trailing: DropdownButton<String>(
            value: profile.sex,
            dropdownColor: AppColors.backgroundElevated,
            items: const ['Male', 'Female', 'Other']
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
            onChanged: (value) => notifier.setBiometrics(sex: value),
          ),
        ),
        const SizedBox(height: 12),
        BiometricInputTile(
          label: 'Height',
          value: '${profile.heightCm.round()} cm',
          trailing: StepperControl(
            value: profile.heightCm,
            onChanged: (value) => notifier.setBiometrics(heightCm: value),
          ),
        ),
        const SizedBox(height: 12),
        BiometricInputTile(
          label: 'Current weight',
          value: '${profile.weightKg.toStringAsFixed(1)} kg',
          trailing: StepperControl(
            value: profile.weightKg,
            step: 0.5,
            onChanged: (value) => notifier.setBiometrics(weightKg: value),
          ),
        ),
        const SizedBox(height: 18),
        Text('Activity level', style: AppTextStyles.displaySub),
        const SizedBox(height: 10),
        SizedBox(
          height: 84,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: ['Sedentary', 'Light', 'Moderate', 'Active', 'Athlete']
                .map((level) {
                  final selected = profile.activityLevel == level;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ChoiceChip(
                      label: Text(level),
                      selected: selected,
                      selectedColor: AppColors.primaryViolet.withValues(
                        alpha: 0.22,
                      ),
                      backgroundColor: AppColors.backgroundCard,
                      side: BorderSide(
                        color: selected
                            ? AppColors.primaryViolet
                            : AppColors.borderLight,
                      ),
                      onSelected: (_) =>
                          notifier.setBiometrics(activityLevel: level),
                    ),
                  );
                })
                .toList(),
          ),
        ),
      ],
    );
  }
}

class StepperControl extends StatelessWidget {
  const StepperControl({
    super.key,
    required this.value,
    required this.onChanged,
    this.step = 1,
  });
  final num value;
  final double step;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () => onChanged(value.toDouble() - step),
          icon: const Icon(Icons.remove),
        ),
        IconButton(
          onPressed: () => onChanged(value.toDouble() + step),
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
