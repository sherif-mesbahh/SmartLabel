import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    const DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> showNotification(String body) async {
    final AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'default_channel', // Must match the channel defined in initialization
      'Default Channel',
      channelDescription: 'Channel for Smart Label notifications',
      importance: Importance.max,
      priority: Priority.high,

      // 🟦 Blue color theme
      color: Color(0xFF2196F3),
      colorized: true, // Enables dynamic color theme for newer Android versions

      // 🔊 Sound and vibration
      playSound: true,
      enableVibration: true,

      // 🧾 Big text style for longer messages
      styleInformation: BigTextStyleInformation(
        body,
        contentTitle: 'Smart Label Notification',
        summaryText: 'Tap to open Smart Label',
      ),

      // 🖼️ Large icon (optional - make sure you have it in res/drawable/)
      largeIcon:
          DrawableResourceAndroidBitmap('@mipmap/launcher_icon'), // or a custom one

      ticker: 'Smart Label Alert',
      visibility:
          NotificationVisibility.public, // Makes it visible on lock screen
      autoCancel: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      0,
      'Smart Label Notification',
      body,
      notificationDetails,
    );
  }
}
