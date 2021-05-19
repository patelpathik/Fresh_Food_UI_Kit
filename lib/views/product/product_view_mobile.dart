import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fresh_food/models/paragraph.dart';
import 'package:fresh_food/theme/app_theme.dart';
import 'package:fresh_food/theme/images.dart';
import 'package:fresh_food/utils/globals.dart';
import 'package:fresh_food/utils/sizeconfig.dart';
import 'package:fresh_food/widgets/button.dart';
import 'package:fresh_food/widgets/quantity_selector.dart';

class ProductMobilePortrait extends StatefulWidget {
  const ProductMobilePortrait({Key key}) : super(key: key);

  @override
  _ProductMobilePortraitState createState() => _ProductMobilePortraitState();
}

class _ProductMobilePortraitState extends State<ProductMobilePortrait> {
  bool isDark = false;

  ExpandableController _expandableController = new ExpandableController();

  List<String> type = ["grams", "lbs", "heads", "packs", "punnets"];
  List<Para> details = [
    Para(
      title: "Description",
      desc:
          "Broccoli is a lovely green cruciferous vegetable. It’s healthy, delicious and nutritious, and there’s honestly nothing more you need to know.",
    ),
    Para(
      title: "Storage",
      desc: "For maximum freshness, keep refrigerated. Wash before use.",
    ),
    Para(
      title: "Origin",
      desc:
          "Produce of United Kingdom, Republic of Ireland, Germany, Italy, Netherlands, Poland, Spain, USA",
    ),
    Para(
      title: "Preparation & Usage",
      desc: "Wash before use. Trim as required.",
    ),
  ];
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

  @override
  void initState() {
    _expandableController.addListener(() {
      /* call setState
      *  as `_expandableController` never calls if (mounted) setState upon change
      * */
      if (mounted) setState(() {});
    });
    super.initState();
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
      height: AppBar().preferredSize.height,
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            margin: EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: COLORS.GREEN,
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: EdgeInsets.all(10),
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
            child: Center(
              child: Text(
                "Broccoli",
                style: Theme.of(context).appBarTheme.titleTextStyle.copyWith(
                      fontSize: Theme.of(context).textTheme.headline6.fontSize,
                    ),
              ),
            ),
          ),
          SizedBox(height: 48, width: 48),
        ],
      ),
    );
    Widget quantitySelector = ExpandablePanel(
      controller: _expandableController,
      header: Container(
        height: AppBar().preferredSize.height + 10,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Broccoli",
              style: TextStyle(
                color: COLORS.MEDIUM_DARK_GREY,
              ),
            ),
            AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: _expandableController.expanded ? 0 : 1,
              child: Text(
                "2 heads",
                style: TextStyle(
                  color: COLORS.MEDIUM_GREY,
                ),
              ),
            ),
            AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: _expandableController.expanded ? 0 : 1,
              child: Text(
                "£0.80",
                style: TextStyle(
                  color: COLORS.MEDIUM_DARK_GREY,
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              height: 50,
              width: 50,
              padding: EdgeInsets.all(15),
              child: RotatedBox(
                quarterTurns: _expandableController.expanded ? 2 : 0,
                child: SvgPicture.asset(
                  ThemeIcon.CHEVRON,
                  color: COLORS.MEDIUM_DARK_GREY,
                ),
              ),
            ),
          ],
        ),
      ),
      collapsed: Container(),
      expanded: QuantitySelector.quantitySelector(isDark: isDark),
      theme: ExpandableThemeData(
        hasIcon: false,
        tapHeaderToExpand: true,
        tapBodyToCollapse: true,
      ),
    );

    List<Widget> productDescription() {
      List<Widget> desc = [];
      details.forEach((element) => desc.add(Description(detail: element)));

      desc.add(SizedBox(height: 15));

      desc.add(
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Nutritional Information",
            style: TextStyle(
              color: COLORS.GREEN,
              fontSize: Theme.of(context).textTheme.headline6.fontSize,
            ),
          ),
        ),
      );

      desc.add(SizedBox(height: 20));

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

      desc.add(SizedBox(height: 20));

      return desc;
    }

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            /* app bar */
            appBar,
            SizedBox(height: 10),
            Expanded(
              child: Container(
                // width: SizeConfig.screenWidth * 0.8,
                padding: EdgeInsets.only(
                  left: SizeConfig.screenWidth * 0.1,
                  right: SizeConfig.screenWidth * 0.1,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      /* product image  */
                      Container(
                        height: SizeConfig.screenWidth * 0.8,
                        width: SizeConfig.screenWidth * 0.8,
                        child: Image.asset(StoreImages.broccoli),
                      ),
                      SizedBox(height: 20),
                      /* accordion - select quantity */
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Container(
                          color:
                              isDark ? COLORS.DARK_GREY : COLORS.LIGHTER_GREY,
                          child: quantitySelector,
                        ),
                      ),
                      SizedBox(height: 20),
                      /* button */
                      Button(
                        title: _expandableController.expanded
                            ? "SELECT"
                            : "ADD TO CART",
                        onPressed: () {
                          if (mounted)
                            setState(() {
                              if (_expandableController.expanded)
                                _expandableController.toggle();
                            });
                        },
                        showCartIcon: !_expandableController.expanded,
                      ),
                      SizedBox(height: 10),
                      ...productDescription(),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Description extends StatelessWidget {
  final Para detail;
  final double spacing;

  const Description({
    Key key,
    @required this.detail,
    this.spacing = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle titleTxtStyle = TextStyle(
      color: COLORS.GREEN,
      fontSize: Theme.of(context).textTheme.headline6.fontSize,
    );
    TextStyle descTxtStyle = TextStyle(
      color: COLORS.MEDIUM_DARK_GREY,
      fontSize: Theme.of(context).textTheme.subtitle1.fontSize,
    );
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: spacing / 1.5),
          Text(
            detail.title,
            style: titleTxtStyle,
            textAlign: TextAlign.start,
          ),
          SizedBox(height: spacing),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              detail.desc,
              style: descTxtStyle,
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(height: spacing / 2),
        ],
      ),
    );
  }
}
