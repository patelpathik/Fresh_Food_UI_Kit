import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fresh_food/theme/app_theme.dart';
import 'package:fresh_food/utils/globals.dart';
import 'package:fresh_food/utils/sizeconfig.dart';
import 'package:fresh_food/views/sign_in/sign_in.dart';

class SplashScreen extends StatefulWidget {
  static const TAG = "/splashScreen";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static double hw = 150;
  static double dashBorderRadius = 30;
  static double curveHW = 0;
  static Color dashColor = COLORS.WHITE;

  bool isAnimationComplete = false;
  bool isDark =
      Globals.isDarkMode != null ? Globals.isDarkMode.getValue() : false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    if (Globals.isDarkMode != null) {
      setState(() => isDark = Globals.isDarkMode.getValue());
      Globals.isDarkMode.listen((value) {
        setState(() => isDark = value);
      });
    }

    if (!isAnimationComplete) {
      setState(() => isAnimationComplete = true);
      Timer(
        Duration(seconds: 2),
        () {
          setState(() {
            hw = 100;
            dashColor = COLORS.GREEN;
            curveHW = 75;
            // curveOpacity = 0.5;
          });
          Timer(
            Duration(milliseconds: 1500),
            () => Navigator.pushReplacementNamed(context, SignIn.TAG),
          );
        },
      );
    }
    return Scaffold(
      body: Stack(
        children: [
          /* main green circle */
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: COLORS.GREEN,
                shape: BoxShape.circle,
              ),
            ),
          ),
          /* white canvas */
          Align(
            alignment: Alignment.center,
            child: AnimatedContainer(
              duration: new Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              height: hw,
              width: hw,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isDark ? COLORS.DARKER_GREY : COLORS.WHITE,
                shape: BoxShape.circle,
              ),
            ),
          ),
          /* dash (inside circle from left) */
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: new Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                  height: 30,
                  width: 75,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(dashBorderRadius),
                      bottomLeft: Radius.circular(dashBorderRadius),
                    ),
                    color: dashColor,
                  ),
                ),
                SizedBox(height: 30, width: 75),
              ],
            ),
          ),
          /* top right opaque curve */
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 150,
              width: 150,
              alignment: Alignment.topRight,
              child: AnimatedContainer(
                duration: new Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
                height: curveHW,
                width: curveHW,
                color: isDark
                    ? COLORS.DARKER_GREY.withOpacity(0.5)
                    : COLORS.WHITE.withOpacity(0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
