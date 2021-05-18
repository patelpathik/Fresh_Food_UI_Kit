import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fresh_food/theme/app_theme.dart';
import 'package:fresh_food/theme/images.dart';
import 'package:fresh_food/utils/sizeconfig.dart';
import 'package:fresh_food/widgets/input_field.dart';

class DeliveryAddress extends StatefulWidget {
  const DeliveryAddress({Key key}) : super(key: key);

  @override
  _DeliveryAddressState createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends State<DeliveryAddress> {
  TextEditingController txtFullName = new TextEditingController();
  TextEditingController txtHouseNo = new TextEditingController();
  TextEditingController txtAddress = new TextEditingController();
  TextEditingController txtTown = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Widget validIcon = AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: 25,
      width: 25,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(color: COLORS.GREEN, shape: BoxShape.circle),
      child: SvgPicture.asset(ThemeIcon.SELECT, color: COLORS.WHITE),
    );
    return Container(
      margin: EdgeInsets.all(SizeConfig.screenWidth * 0.05),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: AppBar().preferredSize.height,
              margin: EdgeInsets.symmetric(vertical: 5),
              child: InputField(
                hintText: "Full Name",
                controller: txtFullName,
                suffix: txtTown.text.isNotEmpty ? validIcon : null,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: AppBar().preferredSize.height,
              margin: EdgeInsets.symmetric(vertical: 5),
              child: InputField(
                hintText: "House No., Building Name",
                controller: txtHouseNo,
                suffix: txtTown.text.isNotEmpty ? validIcon : null,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: AppBar().preferredSize.height,
              margin: EdgeInsets.symmetric(vertical: 5),
              child: InputField(
                hintText: "Street Address",
                controller: txtAddress,
                suffix: txtTown.text.isNotEmpty ? validIcon : null,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: AppBar().preferredSize.height,
              margin: EdgeInsets.symmetric(vertical: 5),
              child: InputField(
                hintText: "Town/City",
                controller: txtTown,
                suffix: txtTown.text.isNotEmpty ? validIcon : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
