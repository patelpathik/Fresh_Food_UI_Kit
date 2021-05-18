import 'package:flutter/material.dart';

import 'package:fresh_food/responsive/orientation_layout.dart';
import 'package:fresh_food/responsive/screen_type_layout.dart';
import 'package:fresh_food/views/checkout/checkout_view_mobile.dart';

class Checkout extends StatelessWidget {
  const Checkout({Key key}) : super(key: key);
  static const TAG = "/checkout";

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: CheckoutMobilePortrait(),
      ),
    );
  }
}
