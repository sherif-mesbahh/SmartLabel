import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences _prefs;

  // Keys
  static const String _onBoardingFinishedKey = 'isOnBoardingFinished';

  // Init - must be called before accessing SharedPrefs
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save onboarding flag
  static Future<void> setOnBoardingFinished(bool value) async {
    await _prefs.setBool(_onBoardingFinishedKey, value);
  }

  // Get onboarding flag
  static bool isOnBoardingFinished() {
    return _prefs.getBool(_onBoardingFinishedKey) ?? false;
  }

  // Optionally: Clear all preferences (if needed)
  static Future<void> clearAll() async {
    await _prefs.clear();
  }
}
