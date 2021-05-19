import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fresh_food/theme/app_theme.dart';
import 'package:fresh_food/theme/images.dart';
import 'package:fresh_food/utils/globals.dart';
import 'package:fresh_food/utils/sizeconfig.dart';
import 'package:fresh_food/widgets/appBar.dart';
import 'package:fresh_food/widgets/bottom_curved_shadow.dart';
import 'package:fresh_food/widgets/counter.dart';
import 'package:fresh_food/widgets/menu_bar.dart';

class QuickShopMobilePortrait extends StatefulWidget {
  const QuickShopMobilePortrait({Key key}) : super(key: key);

  @override
  _QuickShopMobilePortraitState createState() =>
      _QuickShopMobilePortraitState();
}

class _QuickShopMobilePortraitState extends State<QuickShopMobilePortrait> {
  bool isDark = false;

  List<String> menuItems = ["All", "Fruit", "Veg", "Nuts"];
  int selectedMenuInd = 0;

  List<QuickShopItem> quickShopItems = [
    QuickShopItem(
      imagePathLight: Fruits.APPLE_LIGHT,
      imagePathDark: Fruits.APPLE_DARK,
      imagePathColoured: Fruits.APPLE_COLOURED,
      title: "Apple",
    ),
    QuickShopItem(
      imagePathLight: Fruits.BANANA_LIGHT,
      imagePathDark: Fruits.BANANA_DARK,
      imagePathColoured: Fruits.BANANA_COLOURED,
      title: "Banana",
    ),
    QuickShopItem(
      imagePathLight: Fruits.ORANGE_LIGHT,
      imagePathDark: Fruits.ORANGE_DARK,
      imagePathColoured: Fruits.ORANGE_COLOURED,
      title: "Orange",
    ),
    QuickShopItem(
      imagePathLight: Fruits.LEMON_LIGHT,
      imagePathDark: Fruits.LEMON_DARK,
      imagePathColoured: Fruits.LEMON_COLOURED,
      title: "Lemon",
    ),
    QuickShopItem(
      imagePathLight: Fruits.PEAR_LIGHT,
      imagePathDark: Fruits.PEAR_DARK,
      imagePathColoured: Fruits.PEAR_COLOURED,
      title: "Pear",
    ),
    QuickShopItem(
      imagePathLight: Fruits.AVOCADO_LIGHT,
      imagePathDark: Fruits.AVOCADO_DARK,
      imagePathColoured: Fruits.AVOCADO_COLOURED,
      title: "Avocado",
    ),
    QuickShopItem(
      imagePathLight: Fruits.STRAWBERRY_LIGHT,
      imagePathDark: Fruits.STRAWBERRY_DARK,
      imagePathColoured: Fruits.STRAWBERRY_COLOURED,
      title: "Strawberry",
    ),
    QuickShopItem(
      imagePathLight: Fruits.KIWI_LIGHT,
      imagePathDark: Fruits.KIWI_DARK,
      imagePathColoured: Fruits.KIWI_COLOURED,
      title: "Kiwi",
    ),
    QuickShopItem(
      imagePathLight: Fruits.PEACH_LIGHT,
      imagePathDark: Fruits.PEACH_DARK,
      imagePathColoured: Fruits.PEACH_COLOURED,
      title: "Peach",
    ),
    QuickShopItem(
      imagePathLight: Fruits.GRAPES_LIGHT,
      imagePathDark: Fruits.GRAPES_DARK,
      imagePathColoured: Fruits.GRAPES_COLOURED,
      title: "Grapes",
    ),
    QuickShopItem(
      imagePathLight: Fruits.PINEAPPLE_LIGHT,
      imagePathDark: Fruits.PINEAPPLE_DARK,
      imagePathColoured: Fruits.PINEAPPLE_COLOURED,
      title: "Pineapple",
    ),
    QuickShopItem(
      imagePathLight: Fruits.WATERMELON_LIGHT,
      imagePathDark: Fruits.WATERMELON_DARK,
      imagePathColoured: Fruits.WATERMELON_COLOURED,
      title: "Watermelon",
    ),
  ];

  bool isMenuControllerListenerSet = false;

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

    if (!isMenuControllerListenerSet) {
      if (mounted) setState(() => isMenuControllerListenerSet = true);
      Globals.quickShopMenuController.listen((v) {
        if (mounted) setState(() => selectedMenuInd = v);
      });
    }

    if (Globals.isDarkMode != null) {
      Globals.isDarkMode.listen((value) {
        if (mounted) setState(() => isDark = value);
      });
    }

    double contentW = SizeConfig.screenWidth * 0.8;

    Widget shopItemsGridView() {
      List<Widget> items = [];

      double cardW = contentW / 3;

      bool showColoured = false;

      quickShopItems.forEach((item) {
        String imagePath = isDark ? item.imagePathDark : item.imagePathLight;
        String imagePathColoured = item.imagePathColoured;
        if (Globals.quickShopMenuController.getValue() == 1)
          showColoured = true;

        Widget card = Container(
          width: cardW,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: cardW * 0.5,
                child: Stack(
                  children: [
                    Container(
                      height: cardW * 0.5,
                      child: SvgPicture.asset(imagePath),
                    ),
                    AnimatedOpacity(
                      opacity: showColoured ? 1 : 0,
                      duration: Duration(milliseconds: 500),
                      child: Container(
                        height: cardW * 0.5,
                        child: SvgPicture.asset(imagePathColoured),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: cardW * 0.28,
                alignment: Alignment.center,
                child: Text(
                  item.title,
                  style: TextStyle(
                    color: COLORS.MEDIUM_GREY,
                  ),
                ),
              ),
              Container(
                height: cardW * 0.32,
                width: cardW * 0.8,
                child: Counter(
                  height: cardW * 0.32,
                  width: cardW * 0.8,
                  isDark: isDark,
                ),
              ),
            ],
          ),
        );

        items.add(card);
      });
      return Container(
        child: GridView.count(
          padding: EdgeInsets.all(SizeConfig.screenWidth * 0.05),
          crossAxisCount: 3,
          mainAxisSpacing: 30,
          crossAxisSpacing: 10,
          childAspectRatio: cardW / (cardW * 1.11),
          children: items,
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          /* main content */
          Container(
            margin: EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.025),
            decoration: CurvedShadowDecoration.getDecoration(isDark: isDark),
            child: Column(
              children: [
                SizedBox(height: ThemeAppBar.titleBarH),
                SizedBox(height: MenuBar.height + (MenuBar.marginTB * 2)),
                SizedBox(height: 10),
                Expanded(
                  child: Container(
                    // padding: EdgeInsets.all(SizeConfig.screenWidth * 0.05),
                    child: Container(
                      alignment: Alignment.center,
                      child: shopItemsGridView(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          /* top bar  */
          Container(
            decoration: CurvedShadowDecoration.getDecoration(isDark: isDark),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ThemeAppBar.appBar(
                  context,
                  title: "Quick Shop",
                  leading: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(55)),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: COLORS.GREEN,
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          height: 35,
                          width: 55,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            ThemeIcon.REFRESH,
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
                        onTap: () => Globals.homeNavStackIndex.setValue(5),
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
                MenuBar.menuBarFromText(
                  context,
                  options: menuItems,
                  controller: Globals.quickShopMenuController,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class QuickShopItem {
  final String imagePathLight;
  final String imagePathDark;
  final String imagePathColoured;
  final String title;

  QuickShopItem({
    @required this.imagePathLight,
    @required this.imagePathDark,
    @required this.imagePathColoured,
    @required this.title,
  });
}
