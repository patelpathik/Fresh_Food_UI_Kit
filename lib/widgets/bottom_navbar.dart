import 'package:badges/badges.dart';
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
              child: GestureDetector(
                onTap: () {
                  if (Globals.homeNavStackIndex.getValue() != 4)
                    Globals.homeNavStackIndex.setValue(4);
                  else {
                    int ind = Globals.lastKnownHomeNavStackIndex.getValue();
                    Globals.homeNavStackIndex.setValue(ind);
                  }
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  color: Globals.homeNavStackIndex.getValue() == 4
                      ? COLORS.GREEN
                      : COLORS.MEDIUM_DARK_GREY,
                  height: AppBar().preferredSize.height * 0.8,
                  width: AppBar().preferredSize.height * 0.8,
                  padding: EdgeInsets.all(
                    AppBar().preferredSize.height * 0.2,
                  ),
                  child: SvgPicture.asset(
                    Globals.homeNavStackIndex.getValue() == 4
                        ? ThemeIcon.CLOSE
                        : ThemeIcon.PLUS,
                    color: COLORS.WHITE,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Globals.homeNavStackIndex.setValue(5),
            child: Badge(
              badgeContent: Text(
                "4",
                style: TextStyle(
                  color: COLORS.WHITE,
                  fontSize: Theme.of(context).textTheme.caption.fontSize * 0.9,
                ),
              ),
              badgeColor: COLORS.GREEN,
              elevation: 0.0,
              position: BadgePosition.bottomEnd(),
              child: SvgPicture.asset(
                ThemeIcon.CART,
                color: Globals.homeNavStackIndex.getValue() == 5
                    ? COLORS.GREEN
                    : COLORS.MEDIUM_DARK_GREY,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Globals.homeNavStackIndex.setValue(6),
            child: SvgPicture.asset(
              ThemeIcon.SETTINGS,
              color: Globals.homeNavStackIndex.getValue() == 6
                  ? COLORS.GREEN
                  : COLORS.MEDIUM_DARK_GREY,
            ),
          ),
        ],
      ),
    );
  }
}
