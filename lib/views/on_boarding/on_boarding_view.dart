import 'package:flutter/material.dart';
import 'package:fresh_food/responsive/screen_type_layout.dart';
import 'package:fresh_food/responsive/orientation_layout.dart';
import 'package:fresh_food/views/on_boarding/on_boarding_view_tablet_desktop.dart';

import 'on_boarding_view_mobile.dart';

class OnBoarding extends StatelessWidget {
  static const TAG = "/onBoarding";

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: OnBoardingMobilePortrait(),
      ),
      tablet: OrientationLayout(
        portrait: OnBoardingTabletDesktopPortrait(),
      ),
      desktop: OrientationLayout(
        portrait: OnBoardingTabletDesktopPortrait(),
      ),
    );
  }
}
