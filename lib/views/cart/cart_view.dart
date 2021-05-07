import 'package:flutter/material.dart';
import 'package:fresh_food/responsive/orientation_layout.dart';
import 'package:fresh_food/responsive/screen_type_layout.dart';

import 'cart_view_mobile.dart';

class Cart extends StatelessWidget {
  const Cart({Key key}) : super(key: key);

  static const TAG = "/cart";

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: CartMobilePortrait(),
      ),
    );
  }
}
