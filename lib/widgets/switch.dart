import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fresh_food/theme/app_theme.dart';
import 'package:fresh_food/theme/images.dart';

class ThemeSwitch extends StatefulWidget {
  final bool value;
  final Function onPress;

  const ThemeSwitch({
    Key key,
    @required this.value,
    @required this.onPress,
  }) : super(key: key);

  @override
  _ThemeSwitchState createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  EdgeInsets margin = EdgeInsets.only(left: 0, right: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPress,
      child: Container(
        height: 30,
        width: 50,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 25,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  border: Border.all(
                    color: widget.value ? COLORS.MEDIUM_DARK_GREY : COLORS.GREEN,
                  ),
                ),
              ),
            ),
            AnimatedContainer(
              duration: new Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              height: 40,
              width: 50,
              margin: EdgeInsets.only(
                left: widget.value ? 10 : 0,
                right: widget.value ? 0 : 10,
              ),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.value ? COLORS.MEDIUM_DARK_GREY : COLORS.GREEN,
              ),
              child: SvgPicture.asset(
                widget.value ? ThemeIcon.CLOSE : ThemeIcon.SELECT,
                color: COLORS.WHITE,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
