import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetMonitor {
  static final InternetMonitor _instance = InternetMonitor._internal();
  factory InternetMonitor() => _instance;
  InternetMonitor._internal();

  late StreamSubscription _subscription;
  final ValueNotifier<bool> isConnected = ValueNotifier(true);

  // This will store the current SnackBar controller
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>?
      _snackBarController;

  void startMonitoring(BuildContext context) {
    _subscription = Connectivity().onConnectivityChanged.listen((_) async {
      final hasInternet =
          await InternetConnectionChecker.instance.hasConnection;
      isConnected.value = hasInternet;

      final scaffoldMessenger = ScaffoldMessenger.of(context);

      if (hasInternet) {
        // Connection is back, dismiss the SnackBar
        _snackBarController?.close();
        _snackBarController = null;
      } else {
        // Show persistent SnackBar if no internet
        _snackBarController ??= scaffoldMessenger.showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            backgroundColor: Colors.transparent,
            elevation: 0,
            dismissDirection: DismissDirection.none,
            padding: EdgeInsets.zero,
            duration: const Duration(days: 365), // "infinite" snackbar
            content: Container(
              padding:
                  const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              decoration: BoxDecoration(
                color: Colors.red.shade600,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.wifi_off, color: Colors.white),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'No internet connection',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    });
  }

  void stopMonitoring() {
    _subscription.cancel();
    // Make sure to remove the snackbar if monitoring stops
    _snackBarController?.close();
    _snackBarController = null;
  }
}
