import 'dart:async';

import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:smart_label_software_engineering/core/services/api_services/api_endpoints.dart';
import 'package:smart_label_software_engineering/core/utils/secure_token_storage_helper.dart';

class TokenRefresher {
  static Timer? _timer;
  static bool _isRefreshing = false;

  static void start() async {
    _timer?.cancel();

    final accessToken = await SecureTokenStorage.getAccessToken();
    if (accessToken == null || JwtDecoder.isExpired(accessToken)) {
      print('[TokenRefresher] Access token is missing or already expired.');
      return;
    }

    final expirationDate = JwtDecoder.getExpirationDate(accessToken);
    final now = DateTime.now();
    final timeLeft = expirationDate.difference(now);

    // Refresh 2 minutes before actual expiry (safe buffer)
    final refreshDuration = timeLeft - const Duration(minutes: 2);

    if (refreshDuration.isNegative) {
      print('[TokenRefresher] Token is close to expiring. Refreshing now.');
      await _refreshToken();
      return;
    }

    print(
        '[TokenRefresher] Scheduling token refresh in ${refreshDuration.inSeconds} seconds.');
    _timer = Timer(refreshDuration, () async {
      if (!_isRefreshing) {
        await _refreshToken();
      }
    });
  }

  static Future<void> _refreshToken() async {
    final refreshToken = await SecureTokenStorage.getRefreshToken();
    if (refreshToken == null) return;

    _isRefreshing = true;

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

      print('[TokenRefresher] Token refreshed successfully.');
      start(); // restart timer based on new token
    } catch (e) {
      print('[TokenRefresher] Token refresh failed: $e');
    } finally {
      _isRefreshing = false;
    }
  }

  static void stop() {
    _timer?.cancel();
  }
}
