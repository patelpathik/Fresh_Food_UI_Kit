import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fresh_food/theme/app_theme.dart';
import 'package:fresh_food/theme/images.dart';
import 'package:fresh_food/utils/globals.dart';
import 'package:fresh_food/utils/sizeconfig.dart';
import 'package:intl/intl.dart';

class DeliveryOptions extends StatefulWidget {
  const DeliveryOptions({Key key}) : super(key: key);

  @override
  _DeliveryOptionsState createState() => _DeliveryOptionsState();
}

class _DeliveryOptionsState extends State<DeliveryOptions> {
  bool isDark = false;

  int selectedDeliverySpeed = 0;
  List<String> availableDates = [];
  int selectedDateInd = -1;

  List<String> availableTimes = ["8:00 am", "8:30 am", "9:00 am", "9:30 am"];
  int selectedTimeInd = -1;

  @override
  void initState() {
    super.initState();
    if (Globals.isDarkMode != null) {
      setState(() => isDark = Globals.isDarkMode.getValue());
    }
    for (int i = 0; i <= 3; i++) {
      DateTime date = DateTime.now().add(Duration(days: i + 1));
      var formatter = DateFormat.MMM();
      String dt = date.day.toString().padLeft(2, '0');
      String mon = formatter.format(date);
      availableDates.add("$dt $mon");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Globals.isDarkMode != null) {
      Globals.isDarkMode.listen((value) {
        setState(() => isDark = value);
      });
    }

    TextStyle titleTxtStyle = Theme.of(context).textTheme.headline6.copyWith(
          color: COLORS.MEDIUM_DARK_GREY,
          fontWeight: FontWeight.w400,
        );
    Widget getTitle({@required String title}) => Container(
          margin: EdgeInsets.all(SizeConfig.screenWidth * 0.05),
          alignment: Alignment.centerLeft,
          child: Text(title, style: titleTxtStyle),
        );

    Widget selectSpeed() {
      double cardW = SizeConfig.screenWidth * 0.425;
      return Container(
        margin: EdgeInsets.fromLTRB(
          SizeConfig.screenWidth * 0.05,
          SizeConfig.screenWidth * 0.025,
          SizeConfig.screenWidth * 0.05,
          SizeConfig.screenWidth * 0.025,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => setState(() => selectedDeliverySpeed = 0),
              child: Container(
                height: cardW,
                width: cardW,
                decoration: BoxDecoration(
                  color: isDark ? COLORS.DARK_GREY : COLORS.LIGHTER_GREY,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: SvgPicture.asset(
                        ThemeIcon.DELIVERY,
                        color: COLORS.MEDIUM_GREY,
                        height: 25,
                        width: 25,
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      child: Text(
                        "Standard",
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                              color: COLORS.MEDIUM_DARK_GREY,
                            ),
                      ),
                    ),
                    SizedBox(height: 3),
                    Container(
                      child: Text(
                        "2-3 days (free)",
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              color: COLORS.MEDIUM_GREY,
                            ),
                      ),
                    ),
                    SizedBox(height: 15),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      height: 25,
                      width: 25,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selectedDeliverySpeed == 0
                            ? COLORS.GREEN
                            : isDark
                                ? COLORS.DARKER_GREY
                                : COLORS.LIGHT_GREY,
                      ),
                      child: SvgPicture.asset(
                        ThemeIcon.SELECT,
                        color: selectedDeliverySpeed == 0
                            ? COLORS.WHITE
                            : Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => setState(() => selectedDeliverySpeed = 1),
              child: Container(
                height: cardW,
                width: cardW,
                decoration: BoxDecoration(
                  color: isDark ? COLORS.DARK_GREY : COLORS.LIGHTER_GREY,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: SvgPicture.asset(
                        ThemeIcon.FAST_DELIVERY,
                        color: COLORS.MEDIUM_GREY,
                        height: 25,
                        width: 25,
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      child: Text(
                        "Supersonic",
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                              color: COLORS.MEDIUM_DARK_GREY,
                            ),
                      ),
                    ),
                    SizedBox(height: 3),
                    Container(
                      child: Text(
                        "Next day (£4.99)",
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              color: COLORS.MEDIUM_GREY,
                            ),
                      ),
                    ),
                    SizedBox(height: 15),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      height: 25,
                      width: 25,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selectedDeliverySpeed == 1
                            ? COLORS.GREEN
                            : isDark
                                ? COLORS.DARKER_GREY
                                : COLORS.LIGHT_GREY,
                      ),
                      child: SvgPicture.asset(
                        ThemeIcon.SELECT,
                        color: selectedDeliverySpeed == 1
                            ? COLORS.WHITE
                            : Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget selectDate() => HScrollView(items: availableDates, isDark: isDark);

    Widget selectTime() => HScrollView(items: availableTimes, isDark: isDark);
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20),
          getTitle(title: "Select Speed"),
          selectSpeed(),
          getTitle(title: "Select Date"),
          selectDate(),
          getTitle(title: "Select Time"),
          selectTime(),
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              print(availableDates);
            },
          ),
        ],
      ),
    );
  }
}

class HScrollView extends StatefulWidget {
  final List<String> items;
  final bool isDark;

  const HScrollView({Key key, this.items, this.isDark}) : super(key: key);

  @override
  _HScrollViewState createState() => _HScrollViewState();
}

class _HScrollViewState extends State<HScrollView> {
  int controller = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      margin: EdgeInsets.only(
        top: SizeConfig.screenWidth * 0.025,
        bottom: SizeConfig.screenWidth * 0.025,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            widget.items.length,
            (index) {
              double edgeMarginLR = SizeConfig.screenWidth * 0.05;
              double defMarginLR = 10;
              bool isFirst = index == 0;
              bool isLast = index == widget.items.length - 1;
              return GestureDetector(
                onTap: () => setState(() => controller = index),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  height: 55,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  margin: EdgeInsets.only(
                    left: isFirst ? edgeMarginLR : defMarginLR,
                    right: isLast ? edgeMarginLR : defMarginLR,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: controller == index
                        ? COLORS.GREEN
                        : widget.isDark
                            ? COLORS.DARK_GREY
                            : COLORS.LIGHTER_GREY,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Text(
                    widget.items[index],
                    style: TextStyle(
                      color: controller == index
                          ? COLORS.WHITE
                          : COLORS.MEDIUM_DARK_GREY,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
