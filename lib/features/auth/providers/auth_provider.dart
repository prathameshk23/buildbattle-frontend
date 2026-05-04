import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthState {
  const AuthState({this.token, this.onboardingComplete = false});

  final String? token;
  final bool onboardingComplete;

  bool get isAuthenticated => token != null && token!.isNotEmpty;

  AuthState copyWith({
    String? token,
    bool? onboardingComplete,
    bool clearToken = false,
  }) {
    return AuthState(
      token: clearToken ? null : token ?? this.token,
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
    );
  }
}

final authProvider = AsyncNotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

class AuthNotifier extends AsyncNotifier<AuthState> {
  final _storage = const FlutterSecureStorage();

  @override
  Future<AuthState> build() async {
    final prefs = await SharedPreferences.getInstance();
    final token = await _storage.read(key: 'accessToken');
    return AuthState(
      token: token,
      onboardingComplete: prefs.getBool('onboardingComplete') ?? false,
    );
  }

  Future<void> login({required String email, required String password}) async {
    await _storage.write(key: 'accessToken', value: 'mock-access-token');
    await _storage.write(key: 'refreshToken', value: 'mock-refresh-token');
    final prefs = await SharedPreferences.getInstance();
    state = AsyncData(
      AuthState(
        token: 'mock-access-token',
        onboardingComplete: prefs.getBool('onboardingComplete') ?? false,
      ),
    );
  }

  Future<void> completeOnboarding() async {
    await _storage.write(key: 'accessToken', value: 'mock-access-token');
    await _storage.write(key: 'refreshToken', value: 'mock-refresh-token');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingComplete', true);
    state = const AsyncData(
      AuthState(token: 'mock-access-token', onboardingComplete: true),
    );
  }

  Future<void> signOut() async {
    await _storage.delete(key: 'accessToken');
    await _storage.delete(key: 'refreshToken');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingComplete', false);
    state = const AsyncData(AuthState());
  }
}
