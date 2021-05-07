import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fresh_food/theme/app_theme.dart';
import 'package:fresh_food/theme/images.dart';
import 'package:fresh_food/utils/globals.dart';
import 'package:fresh_food/utils/sizeconfig.dart';
import 'package:fresh_food/widgets/appBar.dart';
import 'package:fresh_food/widgets/button.dart';
import 'package:fresh_food/widgets/quantity_selector.dart';

class EditQuantityMobilePortrait extends StatefulWidget {
  const EditQuantityMobilePortrait({Key key}) : super(key: key);

  @override
  _EditQuantityMobilePortraitState createState() =>
      _EditQuantityMobilePortraitState();
}

class _EditQuantityMobilePortraitState
    extends State<EditQuantityMobilePortrait> {
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
    Widget appBar = ThemeAppBar.appBar(
      context,
      title: "Broccoli",
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
    );
    return Scaffold(
      appBar: appBar,
      body: Align(
        alignment: Alignment.center,
        child: Container(
          width: SizeConfig.screenWidth * 0.8,
          child: Column(
            children: [
              Container(
                height: SizeConfig.screenWidth * 0.7,
                width: SizeConfig.screenWidth * 0.8,
                child: Image.asset(
                  StoreImages.broccoli,
                  fit: BoxFit.fitWidth,
                  width: SizeConfig.screenWidth * 0.8,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: isDark ? COLORS.DARK_GREY : COLORS.LIGHTER_GREY,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 20),
                      height: AppBar().preferredSize.height,
                      child: Text(
                        "Broccoli",
                        style: TextStyle(
                          color: COLORS.MEDIUM_DARK_GREY,
                        ),
                      ),
                    ),
                    QuantitySelector.quantitySelector(isDark: isDark),
                  ],
                ),
              ),
              Expanded(child: Container()),
              Button(
                title: "SELECT",
                onPressed: () => Navigator.of(context).pop(),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
