import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fresh_food/theme/app_theme.dart';
import 'package:fresh_food/utils/sizeconfig.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class MenuBar {
  MenuBar._();

  static double height = AppBar().preferredSize.height;
  static double marginTB = 10;

  static Widget menuBarFromText(
    BuildContext context, {
    @required List<String> options,
    Preference<int> controller,
  }) {
    SizeConfig().init(context);
    int selectedOptionInd = controller == null ? 0 : controller.getValue();

    return StatefulBuilder(
      builder: (context, setState) {
        double width = SizeConfig.screenWidth * 0.9;
        double marginLR = SizeConfig.screenWidth * 0.05;
        double eleW = (width / options.length);
        return Container(
          child: Container(
            height: height,
            width: width,
            margin: EdgeInsets.fromLTRB(marginLR, marginTB, marginLR, marginTB),
            alignment: Alignment.center,
            child: Stack(
              children: [
                /* bg */
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                  height: height,
                  width: eleW,
                  margin: EdgeInsets.only(
                    top: 2,
                    bottom: 2,
                    left: selectedOptionInd * eleW,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: COLORS.GREEN,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                ),
                /* options */
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: options.map(
                    (e) {
                      Color txtColor = selectedOptionInd == options.indexOf(e)
                          ? COLORS.WHITE
                          : COLORS.MEDIUM_GREY;
                      return Container(
                        height: height,
                        margin: EdgeInsets.only(top: 2, bottom: 2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: COLORS.GREEN,
                              onTap: () {
                                setState(() {
                                  selectedOptionInd = options.indexOf(e);
                                });
                                if (controller != null)
                                  controller.setValue(selectedOptionInd);
                              },
                              child: Container(
                                height: height,
                                width: eleW,
                                margin: EdgeInsets.only(top: 2, bottom: 2),
                                alignment: Alignment.center,
                                child: Text(
                                  e,
                                  style: TextStyle(
                                    color: txtColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget menuBarIcons(
    BuildContext context, {
    @required List<String> icons,
    Preference<int> controller,
  }) {
    SizeConfig().init(context);
    int selectedOptionInd = controller == null ? 0 : controller.getValue();

    return StatefulBuilder(
      builder: (context, setState) {
        double width = SizeConfig.screenWidth * 0.9;
        double marginLR = SizeConfig.screenWidth * 0.05;
        double eleW = (width / icons.length);
        return Container(
          child: Container(
            height: height,
            width: width,
            margin: EdgeInsets.fromLTRB(marginLR, marginTB, marginLR, marginTB),
            alignment: Alignment.center,
            child: Stack(
              children: [
                /* bg */
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                  height: height,
                  width: eleW,
                  margin: EdgeInsets.only(
                    top: 2,
                    bottom: 2,
                    left: selectedOptionInd * eleW,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: COLORS.GREEN,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                ),
                /* options */
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: icons.map(
                    (e) {
                      Color iconColor = selectedOptionInd == icons.indexOf(e)
                          ? COLORS.WHITE
                          : icons.indexOf(e) < selectedOptionInd
                              ? COLORS.GREEN
                              : COLORS.MEDIUM_GREY;
                      return Container(
                        height: height,
                        margin: EdgeInsets.only(top: 2, bottom: 2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: COLORS.GREEN,
                              onTap: () {
                                setState(() {
                                  selectedOptionInd = icons.indexOf(e);
                                });
                                if (controller != null)
                                  controller.setValue(selectedOptionInd);
                              },
                              child: Container(
                                height: height,
                                width: eleW,
                                margin: EdgeInsets.only(top: 2, bottom: 2),
                                alignment: Alignment.center,
                                child: SvgPicture.asset(e, color: iconColor),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
