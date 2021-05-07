import 'package:flutter/material.dart';
import 'package:fresh_food/responsive/orientation_layout.dart';
import 'package:fresh_food/responsive/screen_type_layout.dart';
import 'package:fresh_food/views/quick_shop/quick_shop_view_mobile.dart';

class QuickShop extends StatelessWidget {
  const QuickShop({Key key}) : super(key: key);

  static const TAG = "/quickShop";

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: QuickShopMobilePortrait(),
      ),
    );
  }
}
