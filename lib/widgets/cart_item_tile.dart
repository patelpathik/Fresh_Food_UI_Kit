import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fresh_food/models/cart_item.dart';
import 'package:fresh_food/theme/app_theme.dart';
import 'package:fresh_food/theme/images.dart';
import 'package:fresh_food/utils/sizeconfig.dart';
import 'package:fresh_food/views/edit_quantity/edit_quantity_view.dart';

class ItemTile extends StatefulWidget {
  final bool isDark;
  final bool allowEdit;
  final CartItem itemDetails;

  const ItemTile({
    Key key,
    @required this.isDark,
    this.allowEdit = false,
    @required this.itemDetails,
  }) : super(key: key);

  @override
  _ItemTileState createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  bool showOptions = false;
  bool isDeleted = false;

  double hDragDX = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    double height = AppBar().preferredSize.height;
    double width = SizeConfig.screenWidth * 0.85;

    TextStyle titleTxtStyle = TextStyle(
      color: COLORS.MEDIUM_DARK_GREY,
    );
    TextStyle qtyTxtStyle = TextStyle(
      color: COLORS.MEDIUM_GREY,
    );
    TextStyle priceTxtStyle = TextStyle(
      color: COLORS.MEDIUM_DARK_GREY,
    );

    double cornerRadiusAmt = 10;

    Widget tile = Stack(
      children: [
        /* content */
        Row(
          children: [
            Container(
              height: height,
              width: height * 1.5,
              child: Image.asset(widget.itemDetails.imagePath),
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: height,
              child: Text(
                widget.itemDetails.text,
                style: titleTxtStyle,
              ),
            ),
            Expanded(
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 500),
                opacity: showOptions ? 0 : 1,
                child: Text(
                  widget.itemDetails.quantity,
                  textAlign: TextAlign.right,
                  style: qtyTxtStyle,
                ),
              ),
            ),
            SizedBox(width: SizeConfig.screenWidth * 0.03),
            Text(widget.itemDetails.price, style: priceTxtStyle),
            SizedBox(width: SizeConfig.screenWidth * 0.03),
          ],
        ),
        /* edit button */
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(cornerRadiusAmt)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, EditQuantity.TAG),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                  height: height,
                  width: showOptions ? height : 0,
                  color: widget.isDark == true
                      ? COLORS.MEDIUM_DARK_GREY
                      : COLORS.LIGHT_GREY,
                  padding: EdgeInsets.all(height * 0.25),
                  child: SvgPicture.asset(
                    ThemeIcon.EDIT,
                    color: COLORS.WHITE,
                    height: height * 0.8,
                    width: height * 0.8,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {if (mounted) setState(() => isDeleted = true);},
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                  height: height,
                  width: showOptions ? height : 0,
                  color: COLORS.MEDIUM_GREY,
                  padding: EdgeInsets.all(height * 0.25),
                  child: SvgPicture.asset(
                    ThemeIcon.TRASH,
                    color: COLORS.WHITE,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    return GestureDetector(
      onHorizontalDragStart: (details) {
        if (mounted) setState(() => hDragDX = details.globalPosition.dx);
      },
      onHorizontalDragEnd: (details) {
        if (mounted) setState(() => hDragDX = 0);
      },
      onHorizontalDragUpdate: (details) {
        if (widget.allowEdit) {
          if (hDragDX <= details.globalPosition.dx)
            if (mounted) setState(() => showOptions = false);
          else
            if (mounted) setState(() => showOptions = true);
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        height: isDeleted ? 0 : height,
        width: width,
        margin: isDeleted
            ? EdgeInsets.zero
            : EdgeInsets.only(
                top: SizeConfig.screenWidth * 0.03,
                bottom: SizeConfig.screenWidth * 0.03,
              ),
        decoration: BoxDecoration(
          color: widget.isDark ? COLORS.DARK_GREY : COLORS.LIGHTER_GREY,
          borderRadius: BorderRadius.all(Radius.circular(cornerRadiusAmt)),
        ),
        child: isDeleted ? Container() : tile,
      ),
    );
  }
}
