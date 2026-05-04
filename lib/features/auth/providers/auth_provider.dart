import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/auth/auth_storage_keys.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/network/dio_client.dart';

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
    final token = await _storage.read(key: AuthStorageKeys.accessToken);
    if (token == null) {
      await _storage.delete(key: AuthStorageKeys.legacyAccessToken);
      await _storage.delete(key: AuthStorageKeys.legacyRefreshToken);
    }
    return AuthState(
      token: token,
      onboardingComplete: prefs.getBool('onboardingComplete') ?? false,
    );
  }

  Future<void> login({required String email, required String password}) async {
    final dio = ref.read(dioClientProvider).dio;
    final response = await dio.post(
      ApiEndpoints.login,
      data: {'email': email.trim(), 'password': password},
    );
    final data = response.data['data'] as Map<String, dynamic>;
    final accessToken = data['access_token'] as String;
    final refreshToken = data['refresh_token'] as String;
    await _storage.write(key: AuthStorageKeys.accessToken, value: accessToken);
    await _storage.write(key: AuthStorageKeys.refreshToken, value: refreshToken);
    final prefs = await SharedPreferences.getInstance();
    state = AsyncData(
      AuthState(
        token: accessToken,
        onboardingComplete: prefs.getBool('onboardingComplete') ?? false,
      ),
    );
  }

  Future<void> register({
    required String email,
    required String password,
    required String displayName,
  }) async {
    final dio = ref.read(dioClientProvider).dio;
    final response = await dio.post(
      ApiEndpoints.register,
      data: {
        'email': email.trim(),
        'password': password,
        if (displayName.trim().isNotEmpty) 'display_name': displayName.trim(),
      },
    );
    final data = response.data['data'] as Map<String, dynamic>;
    final session = data['session'] as Map<String, dynamic>?;
    final accessToken = session?['access_token'] as String?;
    final refreshToken = session?['refresh_token'] as String?;
    if (accessToken == null || refreshToken == null) {
      throw const AppException('Account created. Confirm email, then sign in.');
    }
    await _storage.write(key: AuthStorageKeys.accessToken, value: accessToken);
    await _storage.write(key: AuthStorageKeys.refreshToken, value: refreshToken);
    state = AsyncData(AuthState(token: accessToken));
  }

  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingComplete', true);
    final token = await _storage.read(key: AuthStorageKeys.accessToken);
    state = AsyncData(AuthState(token: token, onboardingComplete: true));
  }

  Future<void> signOut() async {
    await _storage.delete(key: AuthStorageKeys.accessToken);
    await _storage.delete(key: AuthStorageKeys.refreshToken);
    await _storage.delete(key: AuthStorageKeys.legacyAccessToken);
    await _storage.delete(key: AuthStorageKeys.legacyRefreshToken);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingComplete', false);
    state = const AsyncData(AuthState());
  }
}
