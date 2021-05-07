import 'package:flutter/material.dart';
import 'package:fresh_food/theme/app_theme.dart';

class ThemeAppBar {
  static double titleBarH = AppBar().preferredSize.height + 20;

  static AppBar appBar(
    BuildContext context, {
    String title = "",
    Widget leading = const SizedBox(),
    Widget trailing = const SizedBox(),
  }) {
    return AppBar(
      leading: Container(),
      backgroundColor: Colors.transparent,
      toolbarHeight: titleBarH,
      flexibleSpace: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        height: titleBarH,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              height: 55,
              width: 55,
              margin: EdgeInsets.only(top: 20, left: 20),
              child: leading,
            ),
            Expanded(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                height: 55,
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: Theme.of(context).appBarTheme.titleTextStyle.copyWith(
                        fontSize:
                            Theme.of(context).textTheme.headline6.fontSize,
                        color: COLORS.MEDIUM_DARK_GREY,
                      ),
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              height: 55,
              width: 55,
              margin: EdgeInsets.only(top: 20, right: 20),
              child: trailing,
            ),
          ],
        ),
      ),
    );
  }
}
