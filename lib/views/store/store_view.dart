import 'package:flutter/material.dart';
import 'package:fresh_food/responsive/orientation_layout.dart';
import 'package:fresh_food/responsive/screen_type_layout.dart';
import 'package:fresh_food/views/store/store_view_mobile.dart';
import 'package:fresh_food/views/store/store_view_tablet_desktop.dart';

class Store extends StatelessWidget {
  const Store({Key key}) : super(key: key);

  static const TAG = "/store";

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: StoreMobilePortrait(),
      ),
      tablet: OrientationLayout(
        portrait: StoreTabletDesktopPortrait(),
      ),
      desktop: OrientationLayout(
        portrait: StoreTabletDesktopPortrait(),
      ),
    );
  }
}
