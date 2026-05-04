import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../auth/providers/auth_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(milliseconds: 2500), () {
      if (!mounted) return;
      final auth = ref.read(authProvider).value;
      if (auth?.isAuthenticated == true && auth?.onboardingComplete == true) {
        context.go('/home/dashboard');
      } else if (auth?.isAuthenticated == true) {
        context.go('/onboarding/name');
      } else {
        context.go('/auth/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                      width: 112,
                      height: 112,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.accentSaber,
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(color: AppColors.glowSaber, blurRadius: 28),
                        ],
                      ),
                    )
                    .animate(onPlay: (controller) => controller.repeat())
                    .scale(
                      begin: const Offset(0.8, 0.8),
                      end: const Offset(1.45, 1.45),
                      duration: 1600.ms,
                    )
                    .fadeOut(duration: 1600.ms),
                const Icon(
                  LucideIcons.compass,
                  color: AppColors.accentSaber,
                  size: 64,
                ),
                const Positioned(
                  bottom: 22,
                  child: Icon(
                    LucideIcons.swords,
                    color: AppColors.accentStraw,
                    size: 28,
                  ),
                ),
              ],
            ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.08),
            const SizedBox(height: 28),
            Text(
              'Your journey. Your power.',
              style: AppTextStyles.displayHero,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
