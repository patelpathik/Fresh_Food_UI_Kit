import 'package:flutter/material.dart';
import 'package:fresh_food/responsive/orientation_layout.dart';
import 'package:fresh_food/responsive/screen_type_layout.dart';
import 'package:fresh_food/views/settings/settings_view_mobile.dart';

class Settings extends StatelessWidget {
  const Settings({Key key}) : super(key: key);

  static const TAG = "/settings";

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: SettingsMobilePortrait(),
      ),
    );
  }
}
