import 'package:flutter/material.dart';
import 'package:fresh_food/models/cart_item.dart';
import 'package:fresh_food/models/paragraph.dart';
import 'package:fresh_food/theme/app_theme.dart';
import 'package:fresh_food/theme/images.dart';
import 'package:fresh_food/utils/globals.dart';
import 'package:fresh_food/utils/sizeconfig.dart';
import 'package:fresh_food/views/checkout/checkout_view.dart';
import 'package:fresh_food/widgets/appBar.dart';
import 'package:fresh_food/widgets/bottom_curved_shadow.dart';
import 'package:fresh_food/widgets/button.dart';
import 'package:fresh_food/widgets/cart_item_tile.dart';

class CartMobilePortrait extends StatefulWidget {
  const CartMobilePortrait({Key key}) : super(key: key);

  @override
  _CartMobilePortraitState createState() => _CartMobilePortraitState();
}

class _CartMobilePortraitState extends State<CartMobilePortrait> {
  bool isDark = false;

  List<CartItem> cartItems = [
    CartItem(
      imagePath: StoreImages.broccoli,
      text: "Broccoli",
      quantity: "2 heads",
      price: "£0.80",
    ),
    CartItem(
      imagePath: StoreImages.kale,
      text: "Kale",
      quantity: "300g",
      price: "£3.00",
    ),
    CartItem(
      imagePath: StoreImages.pepper,
      text: "Red Peppers",
      quantity: "5",
      price: "£1.50",
    ),
    CartItem(
      imagePath: StoreImages.strawberry,
      text: "Strawberries",
      quantity: "2 punnets",
      price: "£4.00",
    ),
  ];
  List<Para> summary = [
    Para(title: "Sub-total", desc: "£9.30"),
    Para(title: "Delivery", desc: "Standard(free)"),
  ];

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
    Widget appBar = Container(
      alignment: Alignment.center,
      decoration: CurvedShadowDecoration.getDecoration(isDark: isDark),
      child: ThemeAppBar.appBar(context, title: "Cart"),
    );

    Widget cartItems() {
      List<Widget> cartList = [];

      this.cartItems.forEach((item) {
        Widget card = ItemTile(
          isDark: isDark,
          allowEdit: true,
          itemDetails: item,
        );
        cartList.add(card);
      });

      return Container(
        margin: EdgeInsets.only(top: SizeConfig.screenWidth * 0.03),
        width: SizeConfig.screenWidth * 0.85,
        alignment: Alignment.center,
        child: Column(
          children: cartList,
        ),
      );
    }

    Widget summary() {
      List<Widget> summaryList = [];

      TextStyle txtStyle = TextStyle(
        color: COLORS.MEDIUM_DARK_GREY,
        fontSize: Theme.of(context).textTheme.subtitle1.fontSize,
      );

      TextStyle totalTxtStyle = txtStyle.copyWith(
        fontSize: Theme.of(context).textTheme.headline6.fontSize,
      );

      this.summary.forEach((element) {
        Widget row = Container(
          child: Row(
            children: [
              Text(element.title, style: txtStyle),
              Expanded(
                child: Text(
                  element.desc,
                  textAlign: TextAlign.right,
                  style: txtStyle,
                ),
              ),
            ],
          ),
        );

        summaryList.add(row);
        summaryList.add(SizedBox(height: SizeConfig.screenWidth * 0.025));
      });

      return Container(
        width: SizeConfig.screenWidth * 0.85,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ...summaryList,
            Row(
              children: [
                Text("Total", style: totalTxtStyle),
                Expanded(
                  child: Text(
                    "£9.30",
                    textAlign: TextAlign.right,
                    style: totalTxtStyle,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          appBar,
          SizedBox(height: SizeConfig.screenWidth * 0.025),
          cartItems(),
          Expanded(
            child: summary(),
          ),
          SizedBox(height: SizeConfig.screenWidth * 0.05),
          Container(
            width: SizeConfig.screenWidth * 0.85,
            child: Button(
              title: "CHECKOUT",
              onPressed: () => Navigator.pushNamed(context, Checkout.TAG),
            ),
          ),
          SizedBox(height: SizeConfig.screenWidth * 0.025),
        ],
      ),
    );
  }
}
