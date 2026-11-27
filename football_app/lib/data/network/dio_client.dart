import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:football_app/data/storage/token_storage.dart';

class DioClient {
  static Dio create({
    required TokenStorage tokenStorage,
    required String baseUrl, // e.g. 'https://your-api.com/api'
    required VoidCallback onUnauthorized,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 20),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        // Attach the JWT to every request.
        onRequest: (options, handler) async {
          final token = await tokenStorage.readToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        // Expired or invalid token: same behaviour as NetworkApiServices.
        onError: (e, handler) {
          if (e.response?.statusCode == 401) onUnauthorized();
          handler.next(e);
        },
      ),
    );

    return dio;
  }
}