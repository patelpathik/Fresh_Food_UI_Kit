import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:fresh_food/responsive/orientation_layout.dart';
import 'package:fresh_food/responsive/screen_type_layout.dart';
import 'package:fresh_food/views/sign_in/sign_in_view_mobile.dart';
import 'package:fresh_food/views/sign_in/sign_in_view_tablet_desktop.dart';

class SignIn extends StatelessWidget {
  static const String TAG = "/signIn";

  const SignIn({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: SignInMobilePortrait(),
      ),
      tablet: OrientationLayout(
        portrait: SignInTabletDesktopPortrait(),
      ),
      desktop: OrientationLayout(
        portrait: SignInTabletDesktopPortrait(),
      ),
    );
  }
}
