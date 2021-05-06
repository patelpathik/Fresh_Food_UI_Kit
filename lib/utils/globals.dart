import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class Globals {
  Globals._();

  static Preference<bool> isDarkMode;
  static Preference<int> homeNavStackIndex;

  static Future<bool> updatePrefs() async {
    final preference = await StreamingSharedPreferences.instance;
    isDarkMode = preference.getBool("isDarkMode", defaultValue: false);
    homeNavStackIndex = preference.getInt("homeNavStackIndex", defaultValue: 0);
    return true;
  }
}
