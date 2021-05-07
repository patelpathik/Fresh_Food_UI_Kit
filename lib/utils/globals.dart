import 'package:flutter/material.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class Globals {
  Globals._();

  static double menuBarH = AppBar().preferredSize.height + 20;

  static Preference<bool> isDarkMode;
  static Preference<int> homeNavStackIndex;
  static Preference<int> lastKnownHomeNavStackIndex;
  static Preference<int> quickShopMenuController;

  static Future<bool> updatePrefs() async {
    final preference = await StreamingSharedPreferences.instance;
    isDarkMode = preference.getBool("isDarkMode", defaultValue: false);
    homeNavStackIndex = preference.getInt("homeNavStackIndex", defaultValue: 0);
    lastKnownHomeNavStackIndex = preference.getInt(
      "lastKnownHomeNavStackIndex",
      defaultValue: 0,
    );
    quickShopMenuController = preference.getInt(
      "quickShopMenuController",
      defaultValue: 0,
    );
    return true;
  }
}
