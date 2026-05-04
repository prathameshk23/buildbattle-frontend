import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
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
            const SizedBox(height: 72),
            Text('Welcome back.', style: AppTextStyles.displayHero),
            const SizedBox(height: 8),
            Text(
              'Sign in to continue tracking your health.',
              style: AppTextStyles.body,
            ),
            const SizedBox(height: 32),
            Form(
              key: _formKey,
              child: Column(
                children: [
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
              label: _busy ? 'Signing in' : 'Sign in',
              icon: LucideIcons.logIn,
              onPressed: _busy ? null : () async {
                if (!_formKey.currentState!.validate()) return;
                setState(() => _busy = true);
                try {
                  await ref
                      .read(authProvider.notifier)
                      .login(email: _email.text, password: _password.text);
                  if (context.mounted) context.go('/home/dashboard');
                } catch (error) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(error.toString())));
                  }
                } finally {
                  if (mounted) setState(() => _busy = false);
                }
              },
            ),
            const SizedBox(height: 12),
            AppButton(
              label: 'Create account',
              variant: AppButtonVariant.ghost,
              onPressed: () => context.go('/auth/register'),
            ),
          ],
        ),
      ),
    );
  }
}
