import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fresh_food/theme/app_theme.dart';
import 'package:fresh_food/theme/images.dart';
import 'package:fresh_food/utils/globals.dart';
import 'package:fresh_food/utils/sizeconfig.dart';
import 'package:fresh_food/views/recipe_post/recipe_post_view.dart';
import 'package:fresh_food/views/recipes/recipes_view.dart';
import 'package:fresh_food/views/search/search_view.dart';
import 'package:fresh_food/views/store/store_view.dart';

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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    List<Widget> content = [Store(), Search(), Recipes(), RecipePost()];
    return Scaffold(
      body: IndexedStack(
        children: content,
        index: index,
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        height: AppBar().preferredSize.height,
        width: SizeConfig.screenWidth * 0.8,
        margin: EdgeInsets.fromLTRB(
          SizeConfig.screenWidth * 0.1,
          0,
          SizeConfig.screenWidth * 0.1,
          10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Globals.homeNavStackIndex.setValue(0),
              child: SvgPicture.asset(
                ThemeIcon.STORE,
                color: index == 0 || index == 1
                    ? COLORS.GREEN
                    : COLORS.MEDIUM_DARK_GREY,
              ),
            ),
            GestureDetector(
              onTap: () => Globals.homeNavStackIndex.setValue(2),
              child: SvgPicture.asset(
                ThemeIcon.RECIPES,
                color: index == 2 ? COLORS.GREEN : COLORS.MEDIUM_DARK_GREY,
              ),
            ),
            Container(
              height: AppBar().preferredSize.height * 0.8,
              width: AppBar().preferredSize.height * 0.8,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  // color: COLORS.MEDIUM_DARK_GREY,
                  // shape: BoxShape.circle,
                  ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(AppBar().preferredSize.height * 0.8),
                ),
                child: Material(
                  color: COLORS.MEDIUM_DARK_GREY,
                  child: InkWell(
                    child: Container(
                      height: AppBar().preferredSize.height * 0.8,
                      width: AppBar().preferredSize.height * 0.8,
                      padding: EdgeInsets.all(
                        AppBar().preferredSize.height * 0.2,
                      ),
                      child: SvgPicture.asset(
                        ThemeIcon.PLUS,
                        color: COLORS.WHITE,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SvgPicture.asset(
              ThemeIcon.CART,
              color: COLORS.MEDIUM_DARK_GREY,
            ),
            SvgPicture.asset(
              ThemeIcon.SETTINGS,
              color: COLORS.MEDIUM_DARK_GREY,
            ),
          ],
        ),
      ),
    );
  }
}
