import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://smartlabel1.runasp.net/api/',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWQiOiIxMiIsIlVzZXJOYW1lIjoiYW1pcmtoYWlyeTkwM0BnbWFpbC5jb20iLCJFbWFpbCI6ImFtaXJraGFpcnk5MDNAZ21haWwuY29tIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjpbIlVzZXIiLCJBZG1pbiJdLCJhdWQiOiJXZWJzaXRlQW5kTW9iaWxlQXBwIiwiaXNzIjoiU21hcnRMYWJlbFByb2plY3QiLCJleHAiOjE3NDQzOTgzOTgsImlhdCI6MTc0NDM5NzQ5OCwibmJmIjoxNzQ0Mzk3NDk4fQ.fh3PayXcMv1q_ZM1kdl4LyRR9R3p_yO0HC5-hNo7HAU',
    },
  ));

  // GET request
  Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: queryParams);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // POST request
  Future<Response> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // PUT request
  Future<Response> put(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // DELETE request
  Future<Response> delete(String endpoint) async {
    try {
      final response = await _dio.delete(endpoint);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
