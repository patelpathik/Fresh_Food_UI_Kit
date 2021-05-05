import 'package:flutter/material.dart';
import 'package:fresh_food/responsive/orientation_layout.dart';
import 'package:fresh_food/responsive/screen_type_layout.dart';
import 'package:fresh_food/views/recipe_post/recipe_post_view_mobile.dart';

class RecipePost extends StatelessWidget {
  const RecipePost({Key key}) : super(key: key);

  static const String TAG = "/recipePost";

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: RecipePostMobilePortrait(),
      ),
    );
  }
}
