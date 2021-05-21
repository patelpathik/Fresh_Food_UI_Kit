import 'package:animated_rotation/animated_rotation.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fresh_food/models/cart_item.dart';
import 'package:fresh_food/models/paragraph.dart';
import 'package:fresh_food/theme/app_theme.dart';
import 'package:fresh_food/theme/images.dart';
import 'package:fresh_food/utils/sizeconfig.dart';
import 'package:fresh_food/widgets/appBar.dart';
import 'package:fresh_food/widgets/bottom_curved_shadow.dart';

class UserOrdersMobilePortrait extends StatefulWidget {
  const UserOrdersMobilePortrait({Key key}) : super(key: key);

  @override
  _UserOrdersMobilePortraitState createState() =>
      _UserOrdersMobilePortraitState();
}

class _UserOrdersMobilePortraitState extends State<UserOrdersMobilePortrait> {
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
    Para(title: "Delivery", desc: "£4.99"),
    Para(title: "Total", desc: "£14.29"),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    Widget appBar = Container(
      alignment: Alignment.center,
      decoration: CurvedShadowDecoration.getDecoration(isDark: isDark),
      child: ThemeAppBar.appBar(
        context,
        title: "Your Orders",
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
      ),
    );

    return Scaffold(
      body: Column(
        children: [
          appBar,
          SizedBox(height: SizeConfig.screenWidth * 0.05),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Order(title: "Order #5678", isDark: isDark),
                  Order(title: "Order #4722", isDark: isDark),
                  Order(title: "Order #3008", isDark: isDark),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Order extends StatefulWidget {
  final String title;
  final bool isDark;

  const Order({
    Key key,
    @required this.title,
    @required this.isDark,
  }) : super(key: key);

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  ExpandableController _expandableController;

  @override
  void initState() {
    super.initState();
    _expandableController = new ExpandableController();
    _expandableController.addListener(() {
      /* call setState
      *  as `_expandableController` never calls setState upon change
      * */
      setState(() {});
    });
  }

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
    Para(title: "Delivery", desc: "£4.99"),
    Para(title: "Total", desc: "£14.29"),
  ];

  Widget orderDetails() {
    TextStyle titleTxtStyle = Theme.of(context).textTheme.subtitle2.copyWith(
          fontWeight: FontWeight.w400,
          color: COLORS.MEDIUM_DARK_GREY,
        );
    TextStyle qtyTxtStyle = Theme.of(context).textTheme.subtitle2.copyWith(
          fontWeight: FontWeight.w400,
          color: COLORS.MEDIUM_GREY,
        );
    TextStyle priceTxtStyle = Theme.of(context).textTheme.subtitle2.copyWith(
          fontWeight: FontWeight.w400,
          color: COLORS.MEDIUM_DARK_GREY,
        );
    List<Widget> items = cartItems
        .map(
          (e) => Container(
            padding: EdgeInsets.symmetric(
              vertical: SizeConfig.screenWidth * 0.005,
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(e.text, style: titleTxtStyle),
                Expanded(
                  child: Text(
                    e.quantity,
                    textAlign: TextAlign.right,
                    style: qtyTxtStyle,
                  ),
                ),
                Text(e.price.padLeft(10, ' '), style: priceTxtStyle),
              ],
            ),
          ),
        )
        .toList();

    List<Widget> summary = this
        .summary
        .map(
          (e) => Container(
            padding: EdgeInsets.symmetric(
              vertical: SizeConfig.screenWidth * 0.005,
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    e.title,
                    textAlign: TextAlign.right,
                    style: qtyTxtStyle,
                  ),
                ),
                Text(e.desc.padLeft(10, ' '), style: priceTxtStyle),
              ],
            ),
          ),
        )
        .toList();
    return Container(
      margin: EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.025),
      child: Column(
        children: [
          ...items,
          SizedBox(height: 20),
          Row(
            children: [
              Row(
                children: [
                  SizedBox(width: 5),
                  Container(
                    height: 25,
                    width: 25,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: COLORS.GREEN,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      ThemeIcon.SELECT,
                      color: COLORS.WHITE,
                    ),
                  ),
                  SizedBox(width: 15),
                  Text(
                    "Shipped",
                    style: titleTxtStyle.copyWith(color: COLORS.GREEN),
                  ),
                ],
              ),
              Expanded(
                child: Column(children: summary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle titleTxtStyle = Theme.of(context).textTheme.subtitle1.copyWith(
          color: COLORS.MEDIUM_DARK_GREY,
        );
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: SizeConfig.screenWidth * 0.05,
        vertical: SizeConfig.screenWidth * 0.025,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.screenWidth * 0.035,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: widget.isDark ? COLORS.DARK_GREY : COLORS.LIGHTER_GREY,
      ),
      child: ExpandablePanel(
        controller: _expandableController,
        theme: ExpandableThemeData(
          hasIcon: false,
          tapBodyToCollapse: true,
          tapHeaderToExpand: true,
          tapBodyToExpand: true,
          animationDuration: Duration(milliseconds: 500),
        ),
        collapsed: Container(),
        expanded: orderDetails(),
        header: Container(
          height: AppBar().preferredSize.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.title, style: titleTxtStyle),
              Container(
                height: 25,
                width: 25,
                padding: EdgeInsets.all(5),
                child: AnimatedRotation(
                  angle: _expandableController.expanded ? 180 : 0,
                  duration: Duration(milliseconds: 500),
                  child: SvgPicture.asset(ThemeIcon.CHEVRON),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
