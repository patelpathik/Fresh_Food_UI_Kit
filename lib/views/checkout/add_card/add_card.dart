import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fresh_food/theme/app_theme.dart';
import 'package:fresh_food/theme/images.dart';
import 'package:fresh_food/utils/globals.dart';
import 'package:fresh_food/utils/sizeconfig.dart';
import 'package:fresh_food/widgets/appBar.dart';
import 'package:fresh_food/widgets/input_field.dart';

class AddCard extends StatefulWidget {
  const AddCard({Key key}) : super(key: key);
  static const TAG = "/addCard";

  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  bool isDark = false;

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
    return Scaffold(
      appBar: ThemeAppBar.appBar(
        context,
        title: "Add Card",
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
                  ThemeIcon.CLOSE,
                  color: COLORS.MEDIUM_DARK_GREY,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth * 0.05,
          ),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenWidth * 0.05),
              InputField(
                hintText: "Cardholder Name",
                prefix: SvgPicture.asset(
                  ThemeIcon.ACCOUNT,
                  color: COLORS.MEDIUM_GREY,
                ),
              ),
              SizedBox(height: SizeConfig.screenWidth * 0.025),
              InputField(
                hintText: "Card Number",
                prefix: SvgPicture.asset(
                  ThemeIcon.PAYMENT,
                  color: COLORS.MEDIUM_GREY,
                ),
              ),
              SizedBox(height: SizeConfig.screenWidth * 0.025),
              InputField(
                hintText: "Expiry Date",
                prefix: SvgPicture.asset(
                  ThemeIcon.CALENDAR,
                  color: COLORS.MEDIUM_GREY,
                ),
              ),
              SizedBox(height: SizeConfig.screenWidth * 0.025),
              InputField(
                hintText: "Security Number",
                prefix: SvgPicture.asset(
                  ThemeIcon.SECURE,
                  color: COLORS.MEDIUM_GREY,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
