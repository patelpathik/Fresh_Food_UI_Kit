import 'package:flutter/material.dart';
import 'package:fresh_food/theme/app_theme.dart';

class CurvedShadowDecoration {
  static BoxDecoration getDecoration({@required bool isDark}) {
    return BoxDecoration(
      color: isDark ? COLORS.DARKER_GREY : COLORS.WHITE,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(40),
        bottomRight: Radius.circular(40),
      ),
      boxShadow: [
        BoxShadow(
          color: isDark ? Colors.black38 : Color(0xFFE1E1E1).withOpacity(0.75),
          offset: Offset(0, 20),
          blurRadius: 50,
          spreadRadius: -1,
        ),
      ],
    );
  }
}
