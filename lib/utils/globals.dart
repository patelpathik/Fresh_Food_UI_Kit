import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class Globals {
  Globals._();

  static Preference<bool> isDarkMode;

  static Future<void> updatePrefs() async {
    final preference = await StreamingSharedPreferences.instance;
    isDarkMode = preference.getBool("isDarkMode", defaultValue: false);
  }
}
