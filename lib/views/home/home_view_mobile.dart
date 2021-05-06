import 'package:flutter/material.dart';
import 'package:fresh_food/utils/globals.dart';
import 'package:fresh_food/utils/sizeconfig.dart';
import 'package:fresh_food/views/recipe_post/recipe_post_view.dart';
import 'package:fresh_food/views/recipes/recipes_view.dart';
import 'package:fresh_food/views/search/search_view.dart';
import 'package:fresh_food/views/store/store_view.dart';
import 'package:fresh_food/widgets/bottom_navbar.dart';

class HomeMobilePortrait extends StatefulWidget {
  const HomeMobilePortrait({Key key}) : super(key: key);

  @override
  _HomeMobilePortraitState createState() => _HomeMobilePortraitState();
}

class _HomeMobilePortraitState extends State<HomeMobilePortrait> {
  int index = 0;

  @override
  void initState() {
    setState(() => index = Globals.homeNavStackIndex.getValue());
    Globals.homeNavStackIndex.listen((value) => setState(() => index = value));
    super.initState();
  }

  Future<bool> _onBackPressed() async {
    if (index == 1) {
      Globals.homeNavStackIndex.setValue(0);
      return false;
    } else if (index == 3) {
      Globals.homeNavStackIndex.setValue(2);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    List<Widget> content = [
      Store(),
      Search(),
      Recipes(),
      RecipePost(),
    ];
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: content[index],
        bottomNavigationBar: BottomNavBar.bottomNavBar(context),
      ),
    );
  }
}
