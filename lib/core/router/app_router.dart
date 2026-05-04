import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/diary/screens/diary_screen.dart';
import '../../features/onboarding/screens/onboarding_shell.dart';
import '../../features/onboarding/screens/splash_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/progress/screens/progress_screen.dart';
import '../theme/app_colors.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  redirect: (context, state) async {
    final path = state.uri.path;
    if (path == '/splash') return null;

    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'accessToken');
    final prefs = await SharedPreferences.getInstance();
    final onboardingComplete = prefs.getBool('onboardingComplete') ?? false;
    final hasToken = token != null && token.isNotEmpty;
    final isAuth = path.startsWith('/auth');
    final isOnboarding = path.startsWith('/onboarding');
    final isHome = path.startsWith('/home');

    if (!hasToken && isHome) {
      return '/auth/login';
    }
    if (hasToken && !onboardingComplete && !isOnboarding) {
      return '/onboarding/name';
    }
    if (hasToken && onboardingComplete && (isAuth || isOnboarding)) {
      return '/home/dashboard';
    }
    return null;
  },
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/auth/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/auth/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/onboarding/:step',
      builder: (context, state) => OnboardingShell(
        initialStep: _stepIndex(state.pathParameters['step']),
      ),
    ),
    ShellRoute(
      builder: (context, state, child) =>
          HomeShell(location: state.uri.path, child: child),
      routes: [
        GoRoute(
          path: '/home/dashboard',
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: '/home/diary',
          builder: (context, state) => const DiaryScreen(),
        ),
        GoRoute(
          path: '/home/progress',
          builder: (context, state) => const ProgressScreen(),
        ),
        GoRoute(
          path: '/home/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
  ],
);

int _stepIndex(String? step) => switch (step) {
  'biometrics' => 1,
  'goal' => 2,
  'targets' => 3,
  'summary' => 4,
  _ => 0,
};

class HomeShell extends StatelessWidget {
  const HomeShell({super.key, required this.location, required this.child});

  final String location;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final tabs = const [
      '/home/dashboard',
      '/home/diary',
      '/home/progress',
      '/home/profile',
    ];
    final index = tabs.indexWhere(location.startsWith);
    return Scaffold(
      body: SafeArea(child: child),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundCard,
          border: const Border(top: BorderSide(color: AppColors.borderLight)),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowButton,
              blurRadius: index == -1 ? 0 : 10,
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: index == -1 ? 0 : index,
          onTap: (value) => context.go(tabs[value]),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.bookOpen),
              label: 'Diary',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.lineChart),
              label: 'Progress',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.user),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
