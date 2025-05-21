import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/services/api_services/token_refresher.dart';
import 'package:smart_label_software_engineering/core/utils/secure_token_storage_helper.dart';

class LifecycleWatcher extends StatefulWidget {
  final Widget child;
  const LifecycleWatcher({required this.child, super.key});

  @override
  State<LifecycleWatcher> createState() => _LifecycleWatcherState();
}

class _LifecycleWatcherState extends State<LifecycleWatcher>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      final accessToken = await SecureTokenStorage.getAccessToken();
      if (accessToken != null) {
        print('[Lifecycle] App resumed — restarting token refresher');
        TokenRefresher.start();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
