import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fresh_food/theme/app_theme.dart';
import 'package:fresh_food/theme/images.dart';
import 'package:fresh_food/utils/globals.dart';
import 'package:fresh_food/utils/sizeconfig.dart';
import 'package:fresh_food/widgets/appBar.dart';
import 'package:fresh_food/widgets/bottom_curved_shadow.dart';

class RecipesMobilePortrait extends StatefulWidget {
  const RecipesMobilePortrait({Key key}) : super(key: key);

  @override
  _RecipesMobilePortraitState createState() => _RecipesMobilePortraitState();
}

class _RecipesMobilePortraitState extends State<RecipesMobilePortrait>
    with SingleTickerProviderStateMixin {
  bool isDark = false;
  AnimationController _animationController;
  Animation _animation;
  double titleBarH = AppBar().preferredSize.height + 20;

  List<String> filterOptions = ["All", "Vegan", "Keto", "Paleo"];
  int selectedFilterInd = 0;
  List<Recipe> recipes = [
    Recipe(
      title: "Mixed Berry Melody",
      desc: "Berries mixed together to make a tasty dish.",
      imagePath: Images.recipe_1,
    ),
    Recipe(
      title: "Mixed Berry Melody",
      desc: "Berries mixed together to make a tasty dish.",
      imagePath: Images.recipe_2,
    ),
    Recipe(
      title: "Mixed Berry Melody",
      desc: "Berries mixed together to make a tasty dish.",
      imagePath: Images.recipe_1,
    ),
    Recipe(
      title: "Mixed Berry Melody",
      desc: "Berries mixed together to make a tasty dish.",
      imagePath: Images.recipe_2,
    ),
  ];

  @override
  void initState() {
    super.initState();
    Globals.homeNavStackIndex.listen((value) {
      /* open the image */
      if (value == 2 && mounted) _animationController.forward();
    });
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _animation = IntTween(begin: 50, end: 0).animate(_animationController);
    _animation.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
    Widget optionsBar() {
      double height = AppBar().preferredSize.height;
      double width = SizeConfig.screenWidth * 0.9;
      double eleW = (width / filterOptions.length);
      return Container(
        height: height,
        width: width,
        margin: EdgeInsets.only(top: 10, bottom: 10),
        alignment: Alignment.center,
        child: Stack(
          children: [
            /* bg */
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              height: height,
              width: eleW,
              margin: EdgeInsets.only(
                top: 2,
                bottom: 2,
                left: selectedFilterInd * eleW,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: COLORS.GREEN,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
            ),
            /* options */
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: filterOptions.map(
                (e) {
                  Color txtColor = selectedFilterInd == filterOptions.indexOf(e)
                      ? COLORS.WHITE
                      : COLORS.MEDIUM_GREY;
                  return Container(
                    height: height,
                    margin: EdgeInsets.only(top: 2, bottom: 2),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: COLORS.GREEN,
                          onTap: () {
                            setState(() {
                              selectedFilterInd = filterOptions.indexOf(e);
                            });
                          },
                          child: Container(
                            height: height,
                            width: eleW,
                            margin: EdgeInsets.only(top: 2, bottom: 2),
                            alignment: Alignment.center,
                            child: Text(
                              e,
                              style: TextStyle(
                                color: txtColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ],
        ),
      );
    }

    List<Widget> recipesList() {
      List<Widget> elements = [];

      recipes.forEach((recipe) {
        double marginTB = SizeConfig.screenWidth * 0.025;
        double marginLR = SizeConfig.screenWidth * 0.05;
        Widget card = GestureDetector(
          onTap: () => Globals.homeNavStackIndex.setValue(3),
          child: Container(
            margin: EdgeInsets.fromLTRB(marginLR, marginTB, marginLR, marginTB),
            // height: SizeConfig.screenWidth * 0.9,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: isDark ? COLORS.DARK_GREY : COLORS.LIGHTER_GREY,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /* image */
                Container(
                  width: SizeConfig.screenWidth * 0.9,
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    child: Image.asset(
                      recipe.imagePath,
                      fit: BoxFit.fitWidth,
                      width: SizeConfig.screenWidth * 0.9,
                    ),
                  ),
                ),
                SizedBox(height: marginLR),
                /* description */
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: marginLR, right: marginLR),
                  child: Text(
                    recipe.title,
                    style: TextStyle(
                      color: COLORS.MEDIUM_DARK_GREY,
                    ),
                  ),
                ),
                SizedBox(height: marginLR / 2),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: marginLR, right: marginLR),
                  child: Text(
                    recipe.desc,
                    style: TextStyle(
                      color: COLORS.MEDIUM_GREY,
                      fontSize: Theme.of(context).textTheme.subtitle2.fontSize,
                    ),
                  ),
                ),
                SizedBox(height: marginLR),
              ],
            ),
          ),
        );

        elements.add(card);
      });

      return elements;
    }

    Widget bgImage = Container(
      decoration: CurvedShadowDecoration.getDecoration(isDark: isDark),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      Images.recipes_bg,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FittedBox(
                          child: Text(
                            "Eggalicious",
                            style: TextStyle(
                              color: COLORS.GREEN,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .fontSize,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        FittedBox(
                          child: Text(
                            "New Recipe",
                            style: TextStyle(
                              color: COLORS.WHITE,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .fontSize,
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          optionsBar(),
        ],
      ),
    );
    Widget appBar = AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: titleBarH * 2,
      decoration: _animation.value == 0
          ? CurvedShadowDecoration.getDecoration(
              isDark: isDark,
            )
          : BoxDecoration(),
      child: Column(
        children: [
          ThemeAppBar.appBar(
            context,
            title: "Recipes",
            trailing: ClipRRect(
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
                      ThemeIcon.SEARCH,
                      color: _animation.value == 0
                          ? COLORS.MEDIUM_DARK_GREY
                          : COLORS.WHITE,
                    ),
                  ),
                ),
              ),
            ),
          ),
          _animation.value == 0 ? optionsBar() : Container(),
        ],
      ),
    );
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /* image to scroll(animation) */
              Expanded(
                flex: _animation.value,
                child: _animation.value == 0
                    ? Container(height: titleBarH)
                    : bgImage,
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 250),
                height: _animation.value == 0 ? titleBarH + 20 : 0,
              ),
              /* content */
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                    top: SizeConfig.screenWidth * 0.025,
                    bottom: SizeConfig.screenWidth * 0.025,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: recipesList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          /* title */
          appBar,
        ],
      ),
    );
  }
}

class Recipe {
  final String title;
  final String desc;
  final String imagePath;

  Recipe({@required this.title, @required this.desc, @required this.imagePath});
}
