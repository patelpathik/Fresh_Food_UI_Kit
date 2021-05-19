import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fresh_food/theme/app_theme.dart';
import 'package:fresh_food/theme/images.dart';
import 'package:fresh_food/utils/globals.dart';
import 'package:fresh_food/utils/sizeconfig.dart';
import 'package:fresh_food/views/product/product_view.dart';
import 'package:fresh_food/widgets/bottom_curved_shadow.dart';

class StoreMobilePortrait extends StatefulWidget {
  const StoreMobilePortrait({Key key}) : super(key: key);

  @override
  _StoreMobilePortraitState createState() => _StoreMobilePortraitState();
}

class _StoreMobilePortraitState extends State<StoreMobilePortrait> {
  static bool isDark = false;

  List<StoreBottomCarousel> bottomCarousel = [
    StoreBottomCarousel(
      imagePath: StoreImages.strawberry,
      text: "Berries",
      bgColor: Color(0xFFDD4040),
    ),
    StoreBottomCarousel(
      imagePath: StoreImages.orange,
      text: "Citrus",
      bgColor: Color(0xFFFFA700),
    ),
    StoreBottomCarousel(
      imagePath: StoreImages.banana,
      text: "Tropical",
      bgColor: Color(0xFFFFD958),
    ),
    StoreBottomCarousel(
      imagePath: StoreImages.broccoli,
      text: "Vegetable",
      bgColor: Color(0xFFD2F475),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    if (Globals.isDarkMode != null) {
      Globals.isDarkMode.listen((value) {
        if (mounted) setState(() => isDark = value);
      });
    }
    Widget appBar = Container(
      height: AppBar().preferredSize.height + 20,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(height: 55, width: 75),
          Expanded(
            child: Container(
              height: 55,
              alignment: Alignment.center,
              child: Text(
                "Store",
                style: Theme.of(context).appBarTheme.titleTextStyle.copyWith(
                      fontSize: Theme.of(context).textTheme.headline6.fontSize,
                    ),
              ),
            ),
          ),
          Container(
            height: 55,
            width: 55,
            margin: EdgeInsets.only(top: 20, right: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(55)),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: COLORS.GREEN,
                  onTap: () {
                    Globals.homeNavStackIndex.setValue(1);
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    height: 35,
                    width: 55,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(ThemeIcon.SEARCH),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    Widget storeImage = GestureDetector(
      onTap: () => Navigator.pushNamed(context, Product.TAG),
      child: Image.asset(StoreImages.broccoli),
    );

    Widget getBottomCarouselCard(int index) {
      double marginL = 10;
      double marginR = 10;

      if (index == 0) marginL = 20;
      if (index == (bottomCarousel.length - 1)) marginR = 20;

      return Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        color: bottomCarousel[index].bgColor,
        // margin: EdgeInsets.fromLTRB(10, 30, 10, 30),
        margin: EdgeInsets.fromLTRB(marginL, 30, marginR, 30),
        child: Container(
          width: 150,
          color: Colors.transparent,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Container(),
              ),
              Expanded(
                flex: 5,
                child: Image.asset(bottomCarousel[index].imagePath),
              ),
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    bottomCarousel[index].text,
                    style: TextStyle(
                      color: COLORS.WHITE,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          /* main image */
          Expanded(
            flex: 7,
            child: Container(
              decoration: CurvedShadowDecoration.getDecoration(isDark: isDark),
              child: Column(
                children: [
                  appBar,
                  SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      child: storeImage,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Vegetables",
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.headline6.fontSize,
                      color: COLORS.MEDIUM_DARK_GREY,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Browse",
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.subtitle2.fontSize,
                      color: COLORS.MEDIUM_GREY,
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
          /* bottom scroll view */
          Expanded(
            flex: 4,
            child: Container(
              // padding: EdgeInsets.only(left: 15, right: 15),
              child: ListView.builder(
                itemCount: bottomCarousel.length,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) => getBottomCarouselCard(index),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StoreBottomCarousel {
  String imagePath;
  String text;
  Color bgColor;

  StoreBottomCarousel({
    @required this.imagePath,
    @required this.text,
    @required this.bgColor,
  });
}
