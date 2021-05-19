import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fresh_food/theme/app_theme.dart';
import 'package:fresh_food/theme/images.dart';
import 'package:fresh_food/utils/globals.dart';
import 'package:fresh_food/utils/sizeconfig.dart';
import 'package:fresh_food/views/checkout/payment_method/payment_method.dart';
import 'package:fresh_food/widgets/appBar.dart';
import 'package:fresh_food/widgets/bottom_curved_shadow.dart';
import 'package:fresh_food/widgets/input_field.dart';
import 'package:fresh_food/widgets/switch.dart';

class UserAccountMobilePortrait extends StatefulWidget {
  const UserAccountMobilePortrait({Key key}) : super(key: key);

  @override
  _UserAccountMobilePortraitState createState() =>
      _UserAccountMobilePortraitState();
}

class _UserAccountMobilePortraitState extends State<UserAccountMobilePortrait> {
  bool isDark = false;

  bool prefNotification = true;
  bool prefNewsletter = false;

  TextEditingController txtFName = new TextEditingController();
  TextEditingController txtAddress = new TextEditingController();
  TextEditingController txtEmail = new TextEditingController();
  TextEditingController txtPass = new TextEditingController();

  @override
  void initState() {
    super.initState();
    if (Globals.isDarkMode != null) {
      if (mounted) setState(() => isDark = Globals.isDarkMode.getValue());
    }
    initValues();
  }

  void initValues() {
    if (mounted) setState(() {
      txtFName.text = "Orlando Smith";
      txtAddress.text = "42 Wallabe Way, London, United Kingdom";
      txtEmail.text = "orlando.smith@gmail.com";
      txtPass.text = "is it really required";
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    if (Globals.isDarkMode != null) {
      Globals.isDarkMode.listen((value) {
        if (mounted) setState(() => isDark = value);
      });
    }

    Widget appBar = Container(
      alignment: Alignment.center,
      decoration: CurvedShadowDecoration.getDecoration(isDark: isDark),
      child: ThemeAppBar.appBar(
        context,
        title: "Your Account",
        leading: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(55)),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: COLORS.GREEN,
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                height: 35,
                width: 55,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  ThemeIcon.ARROW,
                  color: COLORS.MEDIUM_DARK_GREY,
                ),
              ),
            ),
          ),
        ),
        trailing: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(55)),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: COLORS.GREEN,
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                height: 35,
                width: 55,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  ThemeIcon.SELECT,
                  color: COLORS.GREEN,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Widget title({@required String text}) {
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth * 0.05,
          vertical: SizeConfig.screenWidth * 0.025,
        ),
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: Theme.of(context).textTheme.headline6.copyWith(
                fontWeight: FontWeight.w400,
                color: COLORS.MEDIUM_DARK_GREY,
              ),
        ),
      );
    }

    Widget userInformation() {
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth * 0.05,
          vertical: SizeConfig.screenWidth * 0.025,
        ),
        padding: EdgeInsets.all(SizeConfig.screenWidth * 0.025),
        decoration: BoxDecoration(
          color: isDark ? COLORS.DARK_GREY : COLORS.LIGHTER_GREY,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            InputField(
              hintText: "Full Name",
              controller: txtFName,
              suffix: SvgPicture.asset(
                ThemeIcon.EDIT,
                color: COLORS.MEDIUM_DARK_GREY,
              ),
            ),
            SizedBox(height: SizeConfig.screenWidth * 0.015),
            InputField(
              hintText: "Address",
              controller: txtAddress,
              suffix: SvgPicture.asset(
                ThemeIcon.EDIT,
                color: COLORS.MEDIUM_DARK_GREY,
              ),
            ),
            SizedBox(height: SizeConfig.screenWidth * 0.015),
            InputField(
              hintText: "Email",
              controller: txtEmail,
              suffix: SvgPicture.asset(
                ThemeIcon.EDIT,
                color: COLORS.MEDIUM_DARK_GREY,
              ),
            ),
            SizedBox(height: SizeConfig.screenWidth * 0.015),
            InputField(
              hintText: "Password",
              controller: txtPass,
              obscureText: true,
              suffix: SvgPicture.asset(
                ThemeIcon.EDIT,
                color: COLORS.MEDIUM_DARK_GREY,
              ),
            ),
          ],
        ),
      );
    }

    Widget preferences() {
      TextStyle prefTxtStyle = Theme.of(context).textTheme.subtitle1.copyWith(
            fontWeight: FontWeight.w400,
            color: COLORS.MEDIUM_DARK_GREY,
          );
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth * 0.05,
          vertical: SizeConfig.screenWidth * 0.025,
        ),
        decoration: BoxDecoration(
          color: isDark ? COLORS.DARK_GREY : COLORS.LIGHTER_GREY,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(
                SizeConfig.screenWidth * 0.05,
                SizeConfig.screenWidth * 0.05,
                SizeConfig.screenWidth * 0.05,
                SizeConfig.screenWidth * 0.025,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Notifications", style: prefTxtStyle),
                  ThemeSwitch(
                    value: prefNotification,
                    onPress: () {
                      if (mounted) setState(() => prefNotification = !prefNotification);
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                SizeConfig.screenWidth * 0.05,
                SizeConfig.screenWidth * 0.025,
                SizeConfig.screenWidth * 0.05,
                SizeConfig.screenWidth * 0.05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Newsletter", style: prefTxtStyle),
                  ThemeSwitch(
                    value: prefNewsletter,
                    onPress: () {
                      if (mounted) setState(() => prefNewsletter = !prefNewsletter);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        body: Column(
          children: [
            appBar,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.screenWidth * 0.05),
                    title(text: "Your Information"),
                    userInformation(),
                    title(text: "Your Preferences"),
                    preferences(),
                    title(text: "Payment Methods"),
                    PaymentMethod(readOnly: true),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
