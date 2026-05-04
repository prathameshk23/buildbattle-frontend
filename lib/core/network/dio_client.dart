import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/auth_storage_keys.dart';
import '../config/env.dart';
import 'api_endpoints.dart';

class AppException implements Exception {
  const AppException(this.message, {this.statusCode});
  final String message;
  final int? statusCode;

  @override
  String toString() => message;
}

class DioClient {
  DioClient({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage(),
      dio = Dio(BaseOptions(baseUrl: Env.apiBaseUrl)) {
    dio.interceptors.add(AuthInterceptor(dio: dio, storage: _storage));
  }

  final Dio dio;
  final FlutterSecureStorage _storage;
}

final dioClientProvider = Provider<DioClient>((ref) => DioClient());

class AuthInterceptor extends Interceptor {
  AuthInterceptor({required this.dio, required FlutterSecureStorage storage})
    : _storage = storage;

  final Dio dio;
  final FlutterSecureStorage _storage;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _storage.read(key: AuthStorageKeys.accessToken);
    final isAuthRoute = options.path.startsWith('/auth/');
    if (!isAuthRoute && token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.requestOptions.path == ApiEndpoints.refresh) {
      handler.next(err);
      return;
    }
    if (err.response?.statusCode == 401 &&
        err.requestOptions.extra['retried'] != true) {
      final refreshToken = await _storage.read(key: AuthStorageKeys.refreshToken);
      if (refreshToken != null) {
        try {
          final response = await dio.post(
            ApiEndpoints.refresh,
            data: {'refresh_token': refreshToken},
            options: Options(extra: {'retried': true}),
          );
          final body = response.data['data'] as Map<String, dynamic>?;
          final token = body?['access_token'] as String?;
          final nextRefreshToken = body?['refresh_token'] as String?;
          if (token != null) {
            await _storage.write(key: AuthStorageKeys.accessToken, value: token);
            if (nextRefreshToken != null) {
              await _storage.write(
                key: AuthStorageKeys.refreshToken,
                value: nextRefreshToken,
              );
            }
            final request = err.requestOptions..extra['retried'] = true;
            request.headers['Authorization'] = 'Bearer $token';
            handler.resolve(await dio.fetch(request));
            return;
          }
        } catch (_) {
          await _storage.delete(key: AuthStorageKeys.accessToken);
          await _storage.delete(key: AuthStorageKeys.refreshToken);
          await _storage.delete(key: AuthStorageKeys.legacyAccessToken);
          await _storage.delete(key: AuthStorageKeys.legacyRefreshToken);
        }
      }
    }
    handler.next(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        error: AppException(
          err.response?.data?['error']?['message']?.toString() ??
              err.response?.data?['message']?.toString() ??
              err.message ??
              'Network request failed',
          statusCode: err.response?.statusCode,
        ),
      ),
    );
  }
}
