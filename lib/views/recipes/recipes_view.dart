import 'package:flutter/material.dart';
import 'package:fresh_food/responsive/orientation_layout.dart';
import 'package:fresh_food/responsive/screen_type_layout.dart';
import 'package:fresh_food/views/recipes/recipes_view_mobile.dart';

class Recipes extends StatelessWidget {
  const Recipes({Key key}) : super(key: key);

  static const String TAG = "/recipes";

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: RecipesMobilePortrait(),
      ),
    );
  }
}
