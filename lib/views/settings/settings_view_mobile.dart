import 'package:flutter/material.dart';
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
  int tappedDownInd = -1;

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

  @override
  void initState() {
    super.initState();
    if (Globals.isDarkMode != null) {
      if (mounted) setState(() => isDark = Globals.isDarkMode.getValue());
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    if (Globals.isDarkMode != null) {
      Globals.isDarkMode.listen((value) {
        if (mounted) setState(() => isDark = value);
      });
    }

    if (Globals.isCustomThemeSet != null &&
        Globals.customDarkModePref != null) {
      if (mounted)
        setState(() {
          currentDarkModePref =
              Globals.isCustomThemeSet.getValue() ? "Custom" : "System";
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
            value: Globals.isCustomThemeSet.getValue(),
            onPress: () => Globals.isCustomThemeSet
                .setValue(!Globals.isCustomThemeSet.getValue()),
          ),
        ),
      );

      tiles.add(darkModeTile);

      Widget customDarkModeTile = AnimatedOpacity(
        duration: Duration(milliseconds: 500),
        opacity: Globals.isCustomThemeSet.getValue() ? 1 : 0,
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
              value: !Globals.customDarkModePref.getValue(),
              onPress: () {
                Globals.customDarkModePref
                    .setValue(!Globals.customDarkModePref.getValue());
                if (mounted) setState(() {});
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
        // onTap: () => Navigator.of(context).pushReplacementNamed("/"),
        onTap: () {
          print("${Globals.isCustomThemeSet.getValue()}");
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
