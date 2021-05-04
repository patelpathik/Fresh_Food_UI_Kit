import 'package:flutter/material.dart';
import 'package:fresh_food/responsive/orientation_layout.dart';
import 'package:fresh_food/responsive/screen_type_layout.dart';
import 'package:fresh_food/views/product/product_view_mobile.dart';
import 'package:fresh_food/views/product/product_view_tablet_desktop.dart';

class Product extends StatelessWidget {
  const Product({Key key}) : super(key: key);

  static const String TAG = "/product";

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: ProductMobilePortrait(),
      ),
      tablet: OrientationLayout(
        portrait: ProductTabletDesktopPortrait(),
      ),
      desktop: OrientationLayout(
        portrait: ProductTabletDesktopPortrait(),
      ),
    );
  }
}
