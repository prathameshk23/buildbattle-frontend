import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../providers/auth_provider.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _busy = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const SizedBox(height: 56),
            Text('Create account.', style: AppTextStyles.displayHero),
            const SizedBox(height: 8),
            Text('Email and password for now.', style: AppTextStyles.body),
            const SizedBox(height: 28),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  AppTextField(
                    label: 'Name',
                    controller: _name,
                    prefixIcon: LucideIcons.user,
                    validator: (value) => (value?.trim().isNotEmpty ?? false)
                        ? null
                        : 'Enter your name',
                  ),
                  const SizedBox(height: 14),
                  AppTextField(
                    label: 'Email',
                    controller: _email,
                    prefixIcon: LucideIcons.mail,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => value != null && value.contains('@')
                        ? null
                        : 'Enter a valid email',
                  ),
                  const SizedBox(height: 14),
                  AppTextField(
                    label: 'Password',
                    controller: _password,
                    prefixIcon: LucideIcons.lock,
                    obscureText: true,
                    validator: (value) => (value?.length ?? 0) >= 8
                        ? null
                        : 'Use at least 8 characters',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            AppButton(
              label: _busy ? 'Creating' : 'Create account',
              icon: LucideIcons.userPlus,
              onPressed: _busy ? null : _submit,
            ),
            const SizedBox(height: 12),
            AppButton(
              label: 'Back to sign in',
              variant: AppButtonVariant.ghost,
              onPressed: () => context.go('/auth/login'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _busy = true);
    try {
      await ref.read(authProvider.notifier).register(
            email: _email.text,
            password: _password.text,
            displayName: _name.text,
          );
      if (mounted) context.go('/onboarding/name');
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.toString())));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }
}
