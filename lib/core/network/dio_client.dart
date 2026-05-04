import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
    final token = await _storage.read(key: 'accessToken');
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 &&
        err.requestOptions.extra['retried'] != true) {
      final refreshToken = await _storage.read(key: 'refreshToken');
      if (refreshToken != null) {
        try {
          final response = await dio.post(
            ApiEndpoints.refresh,
            data: {'refreshToken': refreshToken},
          );
          final token = response.data['accessToken'] as String?;
          if (token != null) {
            await _storage.write(key: 'accessToken', value: token);
            final request = err.requestOptions..extra['retried'] = true;
            request.headers['Authorization'] = 'Bearer $token';
            handler.resolve(await dio.fetch(request));
            return;
          }
        } catch (_) {
          await _storage.delete(key: 'accessToken');
          await _storage.delete(key: 'refreshToken');
        }
      }
    }
    handler.next(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        error: AppException(
          err.response?.data?['message']?.toString() ??
              err.message ??
              'Network request failed',
          statusCode: err.response?.statusCode,
        ),
      ),
    );
  }
}
