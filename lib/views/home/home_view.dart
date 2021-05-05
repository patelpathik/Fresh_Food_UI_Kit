import 'package:flutter/material.dart';
import 'package:fresh_food/responsive/orientation_layout.dart';
import 'package:fresh_food/responsive/screen_type_layout.dart';
import 'package:fresh_food/views/home/home_view_desktop.dart';

import 'home_view_mobile.dart';
import 'home_view_tablet.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  static const TAG = "/home";

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: HomeMobilePortrait(),
      ),
      tablet: OrientationLayout(
        portrait: HomeTabletPortrait(),
      ),
      desktop: OrientationLayout(
        portrait: HomeDesktopPortrait(),
      ),
    );
  }
}
