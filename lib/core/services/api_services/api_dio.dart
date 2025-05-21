import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:smart_label_software_engineering/core/services/api_services/api_endpoints.dart';
import 'package:smart_label_software_engineering/core/utils/secure_token_storage_helper.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  late final Dio _dio;

  ApiService._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {'Content-Type': 'application/json'},
    ));

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await SecureTokenStorage.getAccessToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
            log('[DIO] Attached token: Bearer $token');
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          print('[DIO] Error occurred: ${error.response?.statusCode}');

          if (error.response?.statusCode == 401 ||
              error.response?.statusCode == 403) {
           // TokenRefresher.start();
            print('[DIO] Attempting to refresh token...');
            final refreshToken = await SecureTokenStorage.getRefreshToken();
            final oldAccessToken = await SecureTokenStorage.getAccessToken();
            print(
                '[DIO] Stored tokens → Access: $oldAccessToken, Refresh: $refreshToken');

            if (refreshToken == null) {
              print('[DIO] No refresh token found.');
              return handler.next(error);
            }
            try {
              final tokenDio = Dio(); // clean instance to avoid interceptors
              final response = await tokenDio.post(
                ApiEndpoints.refreshToken,
                data: {'refreshToken': refreshToken},
                options: Options(headers: {'Content-Type': 'application/json'}),
              );

              final newAccessToken = response.data['data']['accessToken'];
              final newRefreshToken = response.data['data']['refreshToken'];
              print('[DIO] Token refresh successful.');

              await SecureTokenStorage.saveTokens(
                  newAccessToken, newRefreshToken);

              // Retry the original request
              final requestOptions = error.requestOptions;
              requestOptions.headers['Authorization'] =
                  'Bearer $newAccessToken';

              print('[DIO] Retrying request: ${requestOptions.uri}');
              final retryResponse = await _dio.request(
                requestOptions.path,
                options: Options(
                  method: requestOptions.method,
                  headers: requestOptions.headers,
                ),
                data: requestOptions.data,
                queryParameters: requestOptions.queryParameters,
              );

              return handler.resolve(retryResponse);
            } catch (e) {
              print('[DIO] Token refresh failed: $e');

              if (e is DioException) {
                final statusCode = e.response?.statusCode;
                if (statusCode == 401 || statusCode == 403) {
                  print('[DIO] Refresh token expired or invalid.');
                  await SecureTokenStorage.clearTokens();
                } else {
                  print('[DIO] Other token refresh error.');
                }
              }

              return handler.reject(error); // Pass original error forward
            } finally {
              print('[DIO] Token refresh completed.');
            }
          }

          return handler.next(error);
        },
      ),
    );
  }
  // GET request
  Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParams,
      Map<String, dynamic>? headers}) async {
    try {
      final requestHeaders = Map<String, dynamic>.from(_dio.options.headers);
      if (headers != null) {
        requestHeaders.addAll(headers);
      }

      final response = await _dio.get(
        endpoint,
        queryParameters: queryParams,
        options: Options(headers: requestHeaders),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // POST request
  Future<Response> post(String endpoint, dynamic data,
      {Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        options: Options(headers: headers),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // PUT request
  Future<Response> put(String endpoint, dynamic data,
      {Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: data,
        options: Options(headers: headers),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // DELETE request
  Future<Response> delete(String endpoint,
      {Map<String, dynamic>? headers}) async {
    try {
      final response =
          await _dio.delete(endpoint, options: Options(headers: headers));
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
