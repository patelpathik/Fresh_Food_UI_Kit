import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fresh_food/theme/app_theme.dart';
import 'package:fresh_food/theme/images.dart';
import 'package:fresh_food/utils/globals.dart';
import 'package:fresh_food/utils/sizeconfig.dart';
import 'package:fresh_food/views/on_boarding/on_boarding_view.dart';
import 'package:fresh_food/widgets/bottom_curved_shadow.dart';
import 'package:fresh_food/widgets/button.dart';
import 'package:fresh_food/widgets/input_field.dart';

class SignInMobilePortrait extends StatefulWidget {
  @override
  _SignInMobilePortraitState createState() => _SignInMobilePortraitState();
}

class _SignInMobilePortraitState extends State<SignInMobilePortrait> {
  static List<Widget> signIn = [];
  static List<Widget> signUp = [];

  static bool isSignUp = false;

  bool isDark = false;

  double bottomBoxH = AppBar().preferredSize.height * 2;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    if (Globals.isDarkMode != null) {
      Globals.isDarkMode.listen((value) {
        setState(() => isDark = value);
      });
    }

    signIn = [
      SizedBox(height: 100),
      Text(
        "Sign In",
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.headline5.fontSize,
          color: COLORS.GREEN,
        ),
      ),
      SizedBox(height: 25),
      InputField(
        prefix: SvgPicture.asset(ThemeIcon.MAIL),
        hintText: "Email",
      ),
      SizedBox(height: 25),
      InputField(
        prefix: SvgPicture.asset(ThemeIcon.PADLOCK),
        hintText: "Password",
        obscureText: true,
      ),
      SizedBox(height: 25),
      CleanButton(
        title: "Forgot Password?",
        onPressed: () {},
      ),
      SizedBox(height: 30),
      Button(
        title: "SIGN IN",
        onPressed: () => Navigator.pushReplacementNamed(
          context,
          OnBoarding.TAG,
        ),
      ),
      SizedBox(height: 100),
    ];
    signUp = [
      SizedBox(height: 100),
      Text(
        "Create Account",
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.headline5.fontSize,
          color: COLORS.GREEN,
        ),
      ),
      SizedBox(height: 25),
      InputField(
        prefix: SvgPicture.asset(ThemeIcon.ACCOUNT),
        hintText: "Full Name",
        obscureText: true,
      ),
      SizedBox(height: 25),
      InputField(
        prefix: SvgPicture.asset(ThemeIcon.MAIL),
        hintText: "Email",
      ),
      SizedBox(height: 25),
      InputField(
        prefix: SvgPicture.asset(ThemeIcon.PADLOCK),
        hintText: "Password",
        obscureText: true,
      ),
      SizedBox(height: 30),
      Button(
        title: "CREATE ACCOUNT",
        onPressed: () => Navigator.pushReplacementNamed(
          context,
          OnBoarding.TAG,
        ),
      ),
      SizedBox(height: 100),
    ];

    return Scaffold(
      body: Stack(
        children: [
          /* bottom text button to switch from sign in <-> sign up */
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: bottomBoxH,
              padding: EdgeInsets.only(top: bottomBoxH * 0.15),
              child: Center(
                child: CleanButton(
                  title: isSignUp ? "SIGN IN" : "CREATE ACCOUNT",
                  onPressed: () => setState(() => isSignUp = !isSignUp),
                ),
              ),
            ),
          ),
          /* scroll view */
          Column(
            children: [
              Expanded(
                child: Container(
                  width: SizeConfig.screenWidth,
                  padding: EdgeInsets.only(
                    left: SizeConfig.screenWidth * 0.1,
                    right: SizeConfig.screenWidth * 0.1,
                  ),
                  decoration: CurvedShadowDecoration.getDecoration(
                    isDark: isDark,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 50),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: isSignUp ? signUp : signIn,
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
              SizedBox(height: bottomBoxH),
            ],
          ),
          /* close button for create account case */
          AnimatedOpacity(
            duration: new Duration(milliseconds: 500),
            opacity: isSignUp ? 1 : 0,
            curve: Curves.fastOutSlowIn,
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(
                  top: SizeConfig.screenWidth * 0.15,
                  right: SizeConfig.screenWidth * 0.1,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: COLORS.GREEN,
                      onTap: () => setState(() => isSignUp = false),
                      child: Container(
                        height: 35,
                        width: 35,
                        padding: EdgeInsets.all(10),
                        child: SvgPicture.asset(ThemeIcon.CLOSE),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
