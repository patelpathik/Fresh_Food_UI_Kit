import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fresh_food/theme/app_theme.dart';
import 'package:fresh_food/theme/images.dart';
import 'package:fresh_food/utils/globals.dart';
import 'package:fresh_food/utils/sizeconfig.dart';
import 'package:fresh_food/views/product/product_view.dart';
import 'package:fresh_food/views/voice_search/voice_search_view.dart';
import 'package:fresh_food/widgets/bottom_curved_shadow.dart';

class SearchMobilePortrait extends StatefulWidget {
  const SearchMobilePortrait({Key key}) : super(key: key);

  @override
  _SearchMobilePortraitState createState() => _SearchMobilePortraitState();
}

class _SearchMobilePortraitState extends State<SearchMobilePortrait> {
  bool isDark =
      Globals.isDarkMode != null ? Globals.isDarkMode.getValue() : false;
  String searchQuery = "";

  TextEditingController _searchController = new TextEditingController();
  List<CatalogItem> products = [
    CatalogItem(title: "Apple", imagePath: StoreImages.apple),
    CatalogItem(title: "Banana", imagePath: StoreImages.banana),
    CatalogItem(title: "Broccoli", imagePath: StoreImages.broccoli),
    CatalogItem(title: "Kale", imagePath: StoreImages.kale),
    CatalogItem(title: "Lemon", imagePath: StoreImages.lemon),
    CatalogItem(title: "Orange", imagePath: StoreImages.orange),
    CatalogItem(title: "Pepper", imagePath: StoreImages.pepper),
    CatalogItem(title: "Strawberry", imagePath: StoreImages.strawberry),
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
      height: (AppBar().preferredSize.height + 20) * 2,
      decoration: CurvedShadowDecoration.getDecoration(isDark: isDark),
      child: Column(
        children: [
          /* search text & x button */
          Container(
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
                      "Search",
                      style: Theme.of(context)
                          .appBarTheme
                          .titleTextStyle
                          .copyWith(
                            fontSize:
                                Theme.of(context).textTheme.headline6.fontSize,
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
                        onTap: () => Globals.homeNavStackIndex.setValue(0),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          height: 35,
                          width: 55,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(ThemeIcon.CLOSE),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          /* search icon, text field &  voice button */
          Container(
            height: AppBar().preferredSize.height + 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 10),
                /* search icon */
                Container(
                  height: AppBar().preferredSize.height,
                  width: AppBar().preferredSize.height,
                  padding: EdgeInsets.all(AppBar().preferredSize.height * 0.25),
                  child: SvgPicture.asset(ThemeIcon.SEARCH),
                ),
                SizedBox(width: 10),
                /* text field */
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {if (mounted) setState(() => searchQuery = value);},
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "What are you searching for?",
                      hintStyle: TextStyle(color: COLORS.MEDIUM_GREY),
                    ),
                    style: TextStyle(color: COLORS.MEDIUM_GREY),
                  ),
                ),
                SizedBox(width: 10),
                /* mic button */
                Container(
                  height: AppBar().preferredSize.height * 0.7,
                  width: AppBar().preferredSize.height * 0.7,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppBar().preferredSize.height * 0.8),
                    ),
                    child: Material(
                      color: COLORS.GREEN,
                      child: InkWell(
                        splashColor: COLORS.DARKER_GREY,
                        onTap: () async {
                          dynamic val = await Navigator.pushNamed(
                            context,
                            VoiceSearch.TAG,
                          );
                          if (val == true)
                            if (mounted) setState(() {
                              searchQuery = "broccoli";
                              _searchController.text = "broccoli";
                            });
                        },
                        child: Container(
                          height: AppBar().preferredSize.height * 0.8,
                          width: AppBar().preferredSize.height * 0.8,
                          padding: EdgeInsets.all(
                            AppBar().preferredSize.height * 0.15,
                          ),
                          child: SvgPicture.asset(ThemeIcon.VOICE),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15),
              ],
            ),
          ),
        ],
      ),
    );

    List<Widget> searchResult() {
      List<Widget> result = [];
      searchQuery = searchQuery.trim().toLowerCase();
      products.forEach((product) {
        if (product.title.toLowerCase().contains(searchQuery)) {
          Widget card = Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            color: Theme.of(context).scaffoldBackgroundColor,
            margin: EdgeInsets.all(10),
            elevation: 5.0,
            child: Container(
              height: 200,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: new Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                    height: 100,
                    alignment: Alignment.center,
                    child: Image.asset(product.imagePath),
                  ),
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      product.title,
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.subtitle1.fontSize,
                        color: COLORS.MEDIUM_DARK_GREY,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
          result.add(GestureDetector(
            onTap: () => Navigator.pushNamed(context, Product.TAG),
            child: card,
          ));
        }
      });
      return result;
    }

    return Scaffold(
      body: Column(
        children: [
          appBar,
          SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(10),
              children: searchQuery == "" ? [] : searchResult(),
            ),
          ),
        ],
      ),
    );
  }
}

class CatalogItem {
  final String imagePath;
  final String title;

  CatalogItem({this.imagePath, this.title});
}
