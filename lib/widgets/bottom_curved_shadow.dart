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
          color: isDark ? Colors.black38 : Colors.grey,
          offset: Offset(0, 0),
          blurRadius: 25,
          spreadRadius: 5,
        ),
      ],
    );
  }
}
