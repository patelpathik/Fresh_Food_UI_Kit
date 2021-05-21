import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fresh_food/models/paragraph.dart';
import 'package:fresh_food/theme/app_theme.dart';
import 'package:fresh_food/theme/images.dart';
import 'package:fresh_food/utils/globals.dart';
import 'package:fresh_food/utils/sizeconfig.dart';
import 'package:fresh_food/widgets/button.dart';

class RecipePostMobilePortrait extends StatefulWidget {
  const RecipePostMobilePortrait({Key key}) : super(key: key);

  @override
  _RecipePostMobilePortraitState createState() =>
      _RecipePostMobilePortraitState();
}

class _RecipePostMobilePortraitState extends State<RecipePostMobilePortrait> {
  bool isDark = false;
  double titleBarH = AppBar().preferredSize.height + 20;

  int totalIngredients = 3;

  List<Para> nutritionalInfo = [
    Para(title: "Serving Size", desc: "250g"),
    Para(title: "Calories", desc: "455 Kcal"),
    Para(title: "Protein", desc: "10g"),
    Para(title: "Carbohydrates", desc: "20g"),
    Para(title: "Sugar", desc: "5g"),
    Para(title: "Fibre", desc: "2g"),
    Para(title: "Fat", desc: "5g"),
    Para(title: "Saturated Fat", desc: "3g"),
    Para(title: "Cholesterol", desc: "20mg"),
    Para(title: "Sodium", desc: "20mg"),
    Para(title: "Potassium", desc: "20mg"),
    Para(title: "Vitamin A", desc: "20mg"),
    Para(title: "Vitamin C", desc: "20mg"),
    Para(title: "Calcium Iron", desc: "20mg"),
  ];

  List<Ingredients> ingredientInfo = [
    Ingredients(name: "4 Mint Leaves", isSelected: true),
    Ingredients(name: "Raspberries", isSelected: true),
    Ingredients(name: "1 Strawberry", isSelected: true),
    Ingredients(name: "1/2 Lemon"),
    Ingredients(name: "2 Cherries"),
  ];

  List<RecipeDetails> recipeDetails = [
    RecipeDetails(imagePath: ThemeIcon.DIFFICULTY, text: "Easy"),
    RecipeDetails(imagePath: ThemeIcon.CLOCK, text: "Prep 20m"),
    RecipeDetails(imagePath: ThemeIcon.COOK, text: "Cook 5m"),
  ];

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
    double contentW = SizeConfig.screenWidth * 0.9;
    double spaceAmt = SizeConfig.screenWidth * 0.1;

    TextStyle titleTextStyle = TextStyle(
      color: COLORS.GREEN,
      fontSize: Theme.of(context).textTheme.headline6.fontSize,
    );
    TextStyle paraTextStyle = TextStyle(
      color: COLORS.MEDIUM_DARK_GREY,
      fontSize: Theme.of(context).textTheme.subtitle1.fontSize,
    );

    Widget title(String title) {
      return Container(
        alignment: Alignment.centerLeft,
        child: Text(title, style: titleTextStyle),
      );
    }

    Widget para(String text) {
      return Container(
        child: Text(text, style: paraTextStyle),
      );
    }

    List<Widget> nutritionalInformation() {
      List<Widget> desc = [];

      nutritionalInfo.forEach((info) {
        desc.add(
          Container(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  info.title,
                  style: TextStyle(
                    color: COLORS.MEDIUM_DARK_GREY,
                    fontSize: Theme.of(context).textTheme.subtitle1.fontSize,
                  ),
                ),
                Text(
                  info.desc,
                  style: TextStyle(
                    color: COLORS.MEDIUM_GREY,
                    fontSize: Theme.of(context).textTheme.subtitle1.fontSize,
                  ),
                ),
              ],
            ),
          ),
        );
      });

      return desc;
    }

    Widget ingredients() {
      List<Widget> ingredients = [];
      List<Widget> details = [];

      ingredientInfo.forEach((element) {
        Widget card = Container(
          margin: EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: GestureDetector(
                  onTap: () {
                    int ind = ingredientInfo.indexOf(element);
                    bool val = element.isSelected;

                    setState(() => ingredientInfo[ind].isSelected = !val);
                    int totalIngredientsSelected = 0;
                    ingredientInfo.forEach((e) {
                      if (e.isSelected) totalIngredientsSelected++;
                    });

                    setState(() => totalIngredients = totalIngredientsSelected);
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    color: element.isSelected
                        ? COLORS.GREEN
                        : (isDark ? COLORS.DARK_GREY : COLORS.LIGHTER_GREY),
                    height: 30,
                    width: 30,
                    padding: EdgeInsets.all(8),
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 500),
                      opacity: element.isSelected ? 1 : 0,
                      child: SvgPicture.asset(
                        ThemeIcon.SELECT,
                        color: COLORS.WHITE,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 15),
              Text(element.name, style: paraTextStyle),
            ],
          ),
        );

        ingredients.add(card);
      });

      recipeDetails.forEach((element) {
        Widget card = Container(
          child: Row(
            children: [
              /* icon */
              Container(
                height: 30,
                width: 30,
                margin: EdgeInsets.only(top: 5, bottom: 5),
                padding: EdgeInsets.all(8),
                child: SvgPicture.asset(
                  element.imagePath,
                  color: COLORS.MEDIUM_DARK_GREY,
                ),
              ),
              SizedBox(width: 15),
              /* label */
              Text(element.text, style: paraTextStyle),
            ],
          ),
        );

        details.add(card);
      });
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: contentW * 0.5,
              child: Column(children: ingredients),
            ),
            Container(
              width: contentW * 0.4,
              child: Column(children: details),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: titleBarH,
        flexibleSpace: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          height: titleBarH,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                height: 55,
                width: 55,
                margin: EdgeInsets.only(top: 20, left: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(55)),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: COLORS.GREEN,
                      onTap: () => Globals.homeNavStackIndex.setValue(2),
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
              ),
              Expanded(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                  height: 55,
                  alignment: Alignment.center,
                  child: Text(
                    "Mixed Berry Melody",
                    style: Theme.of(context)
                        .appBarTheme
                        .titleTextStyle
                        .copyWith(
                          fontSize:
                              Theme.of(context).textTheme.headline6.fontSize,
                          color: COLORS.MEDIUM_DARK_GREY,
                        ),
                  ),
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                height: 55,
                width: 55,
                margin: EdgeInsets.only(top: 20, right: 20),
                child: ClipRRect(
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
                          ThemeIcon.SHARE,
                          color: COLORS.MEDIUM_DARK_GREY,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: spaceAmt / 2, right: spaceAmt / 2),
          width: contentW,
          child: Column(
            children: [
              SizedBox(height: spaceAmt / 2),
              /* image */
              Container(
                width: contentW,
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  child: Image.asset(
                    Images.recipe_1,
                    fit: BoxFit.fitWidth,
                    width: contentW,
                  ),
                ),
              ),
              SizedBox(height: spaceAmt),
              title("Ingredients"),
              SizedBox(height: spaceAmt / 2),
              ingredients(),
              SizedBox(height: spaceAmt / 2),
              title("Instructions"),
              SizedBox(height: spaceAmt / 2),
              para(
                  "Start by taking the 4 raspberries, chop them into tiny segments and introduce the strawberry. Check to make sure that the raspberries and the strawberry sit well together, before slicing and dicing a lemon and adding it to this rather strange combination of fruits."),
              SizedBox(height: spaceAmt / 2),
              para(
                  "Peel the 2 cherries, if it’s even possible to peel a cherry, discard the stalks and place them neatly next to the other fruits."),
              SizedBox(height: spaceAmt / 2),
              para(
                  "Finish off this imaginary recipe by sourcing a mint leaf, and place it perfectly in the center of the bowl, taking care not to upset the other fruits that have already been placed."),
              SizedBox(height: spaceAmt / 2),
              title("Nutritional Information"),
              SizedBox(height: spaceAmt / 2),
              ...nutritionalInformation(),
              totalIngredients > 0
                  ? SizedBox(height: spaceAmt / 2)
                  : Container(),
              totalIngredients > 0
                  ? Button(
                      title: "ADD $totalIngredients INGREDIENTS TO CART",
                      onPressed: () {},
                      showCartIcon: true,
                    )
                  : Container(),
              SizedBox(height: spaceAmt / 2),
            ],
          ),
        ),
      ),
    );
  }
}

class Ingredients {
  bool isSelected;
  String name;

  Ingredients({this.isSelected = false, @required this.name});
}

class RecipeDetails {
  final String imagePath;
  final String text;

  RecipeDetails({@required this.imagePath, @required this.text});
}
