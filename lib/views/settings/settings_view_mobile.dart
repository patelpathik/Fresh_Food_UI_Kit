import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fresh_food/theme/app_theme.dart';
import 'package:fresh_food/theme/images.dart';
import 'package:fresh_food/utils/globals.dart';
import 'package:fresh_food/utils/sizeconfig.dart';
import 'package:fresh_food/views/live_chat/live_chat_view.dart';
import 'package:fresh_food/views/user_account/user_account.dart';
import 'package:fresh_food/views/user_orders/user_orders.dart';
import 'package:fresh_food/widgets/appBar.dart';
import 'package:fresh_food/widgets/bottom_curved_shadow.dart';
import 'package:fresh_food/widgets/switch.dart';

class SettingsMobilePortrait extends StatefulWidget {
  const SettingsMobilePortrait({Key key}) : super(key: key);

  @override
  _SettingsMobilePortraitState createState() => _SettingsMobilePortraitState();
}

class _SettingsMobilePortraitState extends State<SettingsMobilePortrait> {
  bool isDark = false;

  String currentDarkModePref = "";

  List<Setting> options = [
    Setting(
      imagePath: ThemeIcon.ACCOUNT,
      title: "Your Account",
      routePath: UserAccount.TAG,
    ),
    Setting(
      imagePath: ThemeIcon.ORDERS,
      title: "Your Orders",
      routePath: UserOrders.TAG,
    ),
    Setting(
      imagePath: ThemeIcon.CHAT,
      title: "Live Chat",
      routePath: LiveChat.TAG,
    ),
  ];

  void changeThemeMode() {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    print(AdaptiveTheme.of(context).mode);
    if (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.system) {
      if (brightness == Brightness.dark)
        AdaptiveTheme.of(context).setDark();
      else
        AdaptiveTheme.of(context).setLight();
    } else {
      AdaptiveTheme.of(context).setSystem();
    }
    print(AdaptiveTheme.of(context).mode);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    if (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.system) {
      setState(() => isDark = Globals.systemDarkMode.getValue());
    } else if (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark) {
      setState(() => isDark = true);
    } else {
      setState(() => isDark = false);
    }

    if (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.system) {
      setState(() => currentDarkModePref = "System");
    } else {
      setState(() => currentDarkModePref = "Custom");
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
        Widget tile = GestureDetector(
          onTap: () => Navigator.pushNamed(context, element.routePath),
          child: settingsTile(
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
        title: "Theme Mode : $currentDarkModePref",
        trailing: Container(
          height: cardH,
          width: cardH,
          padding: EdgeInsets.all(10),
          child: ThemeSwitch(
            value: AdaptiveTheme.of(context).mode != AdaptiveThemeMode.system,
            onPress: changeThemeMode,
          ),
        ),
      );

      tiles.add(darkModeTile);

      Widget customDarkModeTile = AnimatedOpacity(
        duration: Duration(milliseconds: 500),
        opacity:
            AdaptiveTheme.of(context).mode != AdaptiveThemeMode.system ? 1 : 0,
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
          title: "Dark Mode",
          trailing: Container(
            height: cardH,
            width: cardH,
            padding: EdgeInsets.all(10),
            child: ThemeSwitch(
              value: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light,
              onPress: () {
                if (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark) {
                  AdaptiveTheme.of(context).setLight();
                } else {
                  AdaptiveTheme.of(context).setDark();
                }
              },
            ),
          ),
        ),
      );

      tiles.add(customDarkModeTile);

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: tiles,
      );
    }

    Widget logOut() {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pushReplacementNamed("/");
          Globals.homeNavStackIndex.setValue(0);
        },
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
  final String routePath;

  Setting({
    @required this.imagePath,
    @required this.title,
    @required this.routePath,
  });
}
