import 'package:flutter/material.dart';
import 'package:fresh_food/responsive/orientation_layout.dart';
import 'package:fresh_food/responsive/screen_type_layout.dart';
import 'package:fresh_food/views/user_account/user_account_mobile.dart';

class UserAccount extends StatelessWidget {
  const UserAccount({Key key}) : super(key: key);
  static const TAG = "/userAccount";

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: UserAccountMobilePortrait(),
      ),
    );
  }
}
