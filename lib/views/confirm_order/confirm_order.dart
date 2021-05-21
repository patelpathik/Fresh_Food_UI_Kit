import 'dart:math';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fresh_food/theme/app_theme.dart';
import 'package:fresh_food/theme/images.dart';
import 'package:fresh_food/utils/globals.dart';
import 'package:fresh_food/utils/sizeconfig.dart';
import 'package:fresh_food/widgets/appBar.dart';

class ConfirmOrder extends StatefulWidget {
  const ConfirmOrder({Key key}) : super(key: key);

  @override
  _ConfirmOrderState createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  bool isDark = false;
  int orderNumber;

  @override
  void initState() {
    super.initState();
    setState(() => orderNumber = generateOrderNumber());
  }

  int generateOrderNumber() {
    int number = Random().nextInt(9999);
    return number <= 1000 ? generateOrderNumber() : number;
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

    TextStyle descTxtStyle = Theme.of(context).textTheme.headline6.copyWith(
          fontWeight: FontWeight.w300,
          color: COLORS.MEDIUM_DARK_GREY,
        );
    TextStyle orderTxtStyle = Theme.of(context).textTheme.headline5.copyWith(
          fontWeight: FontWeight.w300,
          color: COLORS.GREEN,
        );

    return Scaffold(
      appBar: ThemeAppBar.appBar(
        context,
        title: "",
        trailing: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(55)),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: COLORS.GREEN,
              onTap: () => Globals.homeNavStackIndex.setValue(0),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: EdgeInsets.all(SizeConfig.screenWidth * 0.075),
            width: SizeConfig.screenWidth * 0.85,
            height: SizeConfig.screenWidth * 0.85,
            child: Image.asset(
              isDark ? Images.order_confirm_dark : Images.order_confirm,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Order Placed.", style: descTxtStyle),
              Text("Your order number is", style: descTxtStyle),
              SizedBox(height: 15),
              Text("#$orderNumber", style: orderTxtStyle),
            ],
          ),
        ],
      ),
    );
  }
}
