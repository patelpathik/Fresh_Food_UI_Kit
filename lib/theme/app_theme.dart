import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class COLORS {
  COLORS._();

  static const Color GREEN = Color(0xFF7bed8d);
  static const Color WHITE = Color(0xFFffffff);
  static const Color LIGHTER_GREY = Color(0xFFf0f4f8);
  static const Color LIGHT_GREY = Color(0xFFdbe2ed);
  static const Color MEDIUM_GREY = Color(0xFFa6bcd0);
  static const Color MEDIUM_DARK_GREY = Color(0xFF748a9d);
  static const Color DARK_GREY = Color(0xFF4e5d6a);
  static const Color DARKER_GREY = Color(0xFF404e5a);
}

class AppTheme {
  String fontFamily = GoogleFonts.encodeSansSemiCondensed().fontFamily;

  ThemeData getAppTheme() {
    return ThemeData(
      fontFamily: fontFamily,
      scaffoldBackgroundColor: COLORS.WHITE,
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        backgroundColor: COLORS.WHITE,
        titleTextStyle: TextStyle(
          color: COLORS.MEDIUM_DARK_GREY,
        ),
      ),
    );
  }

  ThemeData getDarkTheme() {
    return ThemeData(
      fontFamily: fontFamily,
      scaffoldBackgroundColor: COLORS.DARKER_GREY,
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        backgroundColor: COLORS.DARKER_GREY,
        titleTextStyle: TextStyle(
          color: COLORS.MEDIUM_DARK_GREY,
        ),
      ),
    );
  }
}
