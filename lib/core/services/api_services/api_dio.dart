import 'package:dio/dio.dart';
import 'package:smart_label_software_engineering/core/services/api_services/api_endpoints.dart';
import 'package:smart_label_software_engineering/core/utils/secure_token_storage_helper.dart';

class ApiService {
  final Dio _dio;

  ApiService()
      : _dio = Dio(BaseOptions(
          baseUrl: 'http://smartlabel1.runasp.net/api/',
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {
            'Content-Type': 'application/json',
          },
        )) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await SecureTokenStorage.getAccessToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException error, handler) async {
        if (error.response?.statusCode == 401) {
          final refreshToken = await SecureTokenStorage.getRefreshToken();
          if (refreshToken != null) {
            try {
              final newTokenResponse =
                  await _dio.post(ApiEndpoints.refreshToken, data: {
                'refreshToken': refreshToken,
              });

              final newAccessToken =
                  newTokenResponse.data['data']['accessToken'];
              final newRefreshToken =
                  newTokenResponse.data['data']['refreshToken'];

              await SecureTokenStorage.saveTokens(
                  newAccessToken, newRefreshToken);

              final opts = error.requestOptions;
              opts.headers['Authorization'] = 'Bearer $newAccessToken';
              final clonedResponse = await _dio.request(
                opts.path,
                options: Options(
                  method: opts.method,
                  headers: opts.headers,
                ),
                data: opts.data,
                queryParameters: opts.queryParameters,
              );

              return handler.resolve(clonedResponse);
            } catch (e) {
              return handler.reject(error);
            }
          }
        }
        return handler.next(error);
      },
    ));
  }

  // GET request
  Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParams,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParams,
        options: Options(headers: headers),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // POST request
  Future<Response> post(String endpoint, Map<String, dynamic> data,
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
  Future<Response> put(String endpoint, Map<String, dynamic> data,
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
