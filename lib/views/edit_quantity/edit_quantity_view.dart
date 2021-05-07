import 'package:flutter/material.dart';
import 'package:fresh_food/responsive/orientation_layout.dart';
import 'package:fresh_food/responsive/screen_type_layout.dart';

import 'edit_quantity_view_mobile.dart';

class EditQuantity extends StatelessWidget {
  const EditQuantity({Key key}) : super(key: key);

  static const TAG = "/editQuantity";

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: EditQuantityMobilePortrait(),
      ),
    );
  }
}
