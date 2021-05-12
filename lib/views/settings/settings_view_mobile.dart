import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fresh_food/theme/app_theme.dart';
import 'package:fresh_food/theme/images.dart';
import 'package:fresh_food/utils/globals.dart';
import 'package:fresh_food/utils/sizeconfig.dart';
import 'package:fresh_food/widgets/appBar.dart';
import 'package:fresh_food/widgets/bottom_curved_shadow.dart';

import 'package:fresh_food/theme/images.dart';
import 'package:fresh_food/widgets/switch.dart';

class SettingsMobilePortrait extends StatefulWidget {
  const SettingsMobilePortrait({Key key}) : super(key: key);

  @override
  _SettingsMobilePortraitState createState() => _SettingsMobilePortraitState();
}

class _SettingsMobilePortraitState extends State<SettingsMobilePortrait> {
  bool isDark = false;
  int tappedDownInd = -1;

  List<Setting> options = [
    Setting(imagePath: ThemeIcon.ACCOUNT, title: "Your Account"),
    Setting(imagePath: ThemeIcon.ORDERS, title: "Your Orders"),
    Setting(imagePath: ThemeIcon.CHAT, title: "Live Chat"),
  ];

  @override
  void initState() {
    super.initState();
    if (Globals.isDarkMode != null) {
      setState(() => isDark = Globals.isDarkMode.getValue());
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    if (Globals.isDarkMode != null) {
      Globals.isDarkMode.listen((value) {
        setState(() => isDark = value);
      });
    }

    double cardH = AppBar().preferredSize.height;

    Widget settingsTile({
      @required Widget leading,
      @required String title,
      @required Widget trailing,
    }) {
      Color bgColor = isDark ? COLORS.DARK_GREY : COLORS.LIGHTER_GREY;
      Widget tiles = Container(
        margin: EdgeInsets.only(
          top: 2,
          bottom: 2,
          left: SizeConfig.screenWidth * 0.075,
          right: SizeConfig.screenWidth * 0.075,
        ),
        padding: EdgeInsets.only(
          left: SizeConfig.screenWidth * 0.025,
          right: SizeConfig.screenWidth * 0.025,
        ),
        height: cardH,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: [
            leading,
            Expanded(
              child: Text(
                title,
                style: TextStyle(color: COLORS.MEDIUM_DARK_GREY),
              ),
            ),
            trailing,
          ],
        ),
      );
      return tiles;
    }

    Widget settingsOptions() {
      List<Widget> tiles = [];

      options.forEach((element) {
        Widget tile = settingsTile(
          leading: Container(
            height: cardH,
            width: cardH,
            padding: EdgeInsets.all(cardH * 0.3),
            child: SvgPicture.asset(
              element.imagePath,
              color: COLORS.GREEN,
            ),
          ),
          title: element.title,
          trailing: Container(
            height: cardH,
            width: cardH,
            padding: EdgeInsets.all(cardH * 0.4),
            child: RotatedBox(
              quarterTurns: 3,
              child: SvgPicture.asset(
                ThemeIcon.CHEVRON,
                color: COLORS.MEDIUM_DARK_GREY,
              ),
            ),
          ),
        );
        tiles.add(tile);
      });

      Widget darkModeTile = settingsTile(
        leading: Container(
          height: cardH,
          width: cardH,
          padding: EdgeInsets.all(cardH * 0.3),
          child: SvgPicture.asset(
            ThemeIcon.BULB,
            color: COLORS.GREEN,
          ),
        ),
        title: "Dark Mode",
        trailing: Container(
          height: cardH,
          width: cardH,
          padding: EdgeInsets.all(10),
          // child: ThemeSwitch(
          //   value: !isDark,
          //   onPress: () {
          //     // Globals.isDarkMode.setValue(!isDark);
          //     // debugPrint(Globals.isDarkMode.getValue().toString());
          //     // setState(() => isDark = !isDark);
          //     // AppTheme().switchTheme(isDark);
          //   },
          // ),
        ),
      );

      tiles.add(darkModeTile);

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: tiles,
      );
    }

    Widget logOut() {
      return GestureDetector(
        onTap: () => Navigator.of(context).pushReplacementNamed("/"),
        child: settingsTile(
          leading: Container(
            height: cardH,
            width: cardH,
            padding: EdgeInsets.all(cardH * 0.3),
            child: SvgPicture.asset(
              ThemeIcon.BULB,
              color: COLORS.GREEN,
            ),
          ),
          title: "Sign Out",
          trailing: Container(),
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: CurvedShadowDecoration.getDecoration(isDark: isDark),
            child: ThemeAppBar.appBar(context, title: "Settings"),
          ),
          SizedBox(height: SizeConfig.screenWidth * 0.05),
          Expanded(child: settingsOptions()),
          Expanded(child: Container()),
          logOut(),
          SizedBox(height: SizeConfig.screenWidth * 0.025),
        ],
      ),
    );
  }
}

class Setting {
  final String imagePath;
  final String title;

  Setting({@required this.imagePath, @required this.title});
}
