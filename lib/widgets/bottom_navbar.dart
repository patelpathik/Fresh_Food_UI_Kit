import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fresh_food/theme/app_theme.dart';
import 'package:fresh_food/theme/images.dart';
import 'package:fresh_food/utils/globals.dart';
import 'package:fresh_food/utils/sizeconfig.dart';

class BottomNavBar {
  static Widget bottomNavBar(BuildContext context) {
    SizeConfig().init(context);
    int index = Globals.homeNavStackIndex.getValue();
    return Container(
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
              color: index == 2 || index == 3
                  ? COLORS.GREEN
                  : COLORS.MEDIUM_DARK_GREY,
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
    );
  }
}
