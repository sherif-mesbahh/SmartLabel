import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://smartlabel1.runasp.net/api/',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Content-Type': 'application/json',
    },
  ));

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
