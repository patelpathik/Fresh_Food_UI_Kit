import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fresh_food/theme/app_theme.dart';
import 'package:fresh_food/theme/images.dart';
import 'package:fresh_food/utils/globals.dart';
import 'package:fresh_food/utils/sizeconfig.dart';
import 'package:fresh_food/views/checkout/add_card/add_card.dart';

class PaymentMethod extends StatefulWidget {
  final bool readOnly;

  const PaymentMethod({Key key, this.readOnly = false}) : super(key: key);

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  bool isDark = false;

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

    BorderRadius radius = BorderRadius.all(Radius.circular(10));
    Widget addNewCard = GestureDetector(
      onTap: () => Navigator.pushNamed(context, AddCard.TAG),
      child: Container(
        margin: EdgeInsets.all(SizeConfig.screenWidth * 0.025),
        decoration: BoxDecoration(
          borderRadius: radius,
          color: isDark ? COLORS.DARK_GREY : COLORS.LIGHTER_GREY,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(13),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 1,
                  color: COLORS.MEDIUM_DARK_GREY,
                ),
              ),
              child: SvgPicture.asset(
                ThemeIcon.PLUS,
                color: COLORS.MEDIUM_DARK_GREY,
                height: 38,
                width: 38,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "ADD CARD",
              style: TextStyle(
                color: COLORS.MEDIUM_DARK_GREY,
              ),
            ),
          ],
        ),
      ),
    );

    Widget savedCard() {
      TextStyle numberStyle = Theme.of(context).textTheme.headline6;
      numberStyle = numberStyle.copyWith(color: COLORS.WHITE);
      TextStyle nameStyle = Theme.of(context).textTheme.headline6;
      nameStyle = nameStyle.copyWith(
        color: COLORS.WHITE,
        fontWeight: FontWeight.normal,
      );
      return Container(
        margin: EdgeInsets.all(SizeConfig.screenWidth * 0.025),
        decoration: BoxDecoration(
          borderRadius: radius,
          color: COLORS.MEDIUM_DARK_GREY,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth * 0.05,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              alignment: Alignment.centerLeft,
              child: Text(
                "DEBIT",
                style: Theme.of(context).textTheme.headline5.copyWith(
                      color: COLORS.WHITE,
                    ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("* * * *", style: numberStyle),
                Text(" * * * *", style: numberStyle),
                Text(" * * * *", style: numberStyle),
                Text(" 2 3 5 6", style: numberStyle),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Chris Capello", style: nameStyle),
                  Text("06 / 22", style: nameStyle),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      width: SizeConfig.screenWidth,
      height: 225,
      margin: EdgeInsets.only(
        top: widget.readOnly ? 0 : SizeConfig.screenWidth * 0.05,
      ),
      child: Swiper(
        viewportFraction: 0.85,
        scale: 1,
        itemCount: 2,
        scrollDirection: Axis.horizontal,
        loop: false,
        autoplay: false,
        itemBuilder: (context, index) {
          if (index == 1) {
            /* return card */
            return savedCard();
          }
          /* return add card */
          return widget.readOnly ? savedCard() : addNewCard;
        },
      ),
    );
  }
}
