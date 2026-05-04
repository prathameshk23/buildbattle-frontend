import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../providers/onboarding_provider.dart';

class StepNameScreen extends ConsumerStatefulWidget {
  const StepNameScreen({super.key});

  @override
  ConsumerState<StepNameScreen> createState() => _StepNameScreenState();
}

class _StepNameScreenState extends ConsumerState<StepNameScreen> {
  late final _name = TextEditingController(
    text: ref.read(onboardingProvider).name,
  );
  late final _email = TextEditingController(
    text: ref.read(onboardingProvider).email,
  );
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text('Who are you, Traveller?', style: AppTextStyles.displayHero),
        const SizedBox(height: 8),
        Text('Every legend starts with a name.', style: AppTextStyles.body),
        const SizedBox(height: 28),
        AppTextField(
          label: 'Display name',
          controller: _name,
          prefixIcon: LucideIcons.user,
          onChanged: (_) => _save(),
        ),
        const SizedBox(height: 14),
        AppTextField(
          label: 'Email',
          controller: _email,
          prefixIcon: LucideIcons.mail,
          onChanged: (_) => _save(),
        ),
        const SizedBox(height: 14),
        AppTextField(
          label: 'Password',
          controller: _password,
          prefixIcon: LucideIcons.lock,
          obscureText: true,
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: AppButton(
                label: 'Google',
                variant: AppButtonVariant.ghost,
                icon: LucideIcons.chrome,
                onPressed: () {},
              ),
            ),
            Expanded(
              child: AppButton(
                label: 'Apple',
                variant: AppButtonVariant.ghost,
                icon: LucideIcons.apple,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _save() => ref
      .read(onboardingProvider.notifier)
      .setIdentity(_name.text, _email.text);
}
