import 'package:flutter/material.dart';
import 'package:fresh_food/responsive/orientation_layout.dart';
import 'package:fresh_food/responsive/screen_type_layout.dart';
import 'package:fresh_food/views/user_orders/user_orders_mobile.dart';

class UserOrders extends StatelessWidget {
  const UserOrders({Key key}) : super(key: key);
  static const String TAG = "/user_order";

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: UserOrdersMobilePortrait(),
      ),
    );
  }
}
