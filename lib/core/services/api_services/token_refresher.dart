import 'dart:async';

import 'package:dio/dio.dart';
import 'package:smart_label_software_engineering/core/services/api_services/api_endpoints.dart';
import 'package:smart_label_software_engineering/core/utils/secure_token_storage_helper.dart';

class TokenRefresher {
  static Timer? _timer;

  static void start() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(minutes: 18), (_) async {
      await _refreshToken();
    });
  }

  static Future<void> _refreshToken() async {
    final refreshToken = await SecureTokenStorage.getRefreshToken();
    if (refreshToken == null) return;

    try {
      final tokenDio = Dio();
      final response = await tokenDio.post(
        ApiEndpoints.refreshToken,
        data: {'refreshToken': refreshToken},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      final newAccessToken = response.data['data']['accessToken'];
      final newRefreshToken = response.data['data']['refreshToken'];

      await SecureTokenStorage.saveTokens(newAccessToken, newRefreshToken);

      print('[TokenRefresher] Token successfully refreshed.');
    } catch (e) {
      print('[TokenRefresher] Failed to refresh token: $e');
    }
  }

  static void stop() {
    _timer?.cancel();
  }
}
