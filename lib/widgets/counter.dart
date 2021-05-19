import 'package:flutter/material.dart';
import 'package:fresh_food/theme/app_theme.dart';

class Counter extends StatefulWidget {
  final double height;
  final double width;
  final bool isDark;

  const Counter({
    Key key,
    @required this.height,
    @required this.width,
    @required this.isDark,
  }) : super(key: key);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int counterValue = 0;

  void increaseCounter() {
    if (mounted) setState(() => counterValue = counterValue + 1);
  }

  void decreaseCounter() {
    if (counterValue != 0) if (mounted) setState(() => counterValue = counterValue - 1);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
      color: COLORS.MEDIUM_DARK_GREY,
      fontSize: Theme.of(context).textTheme.subtitle1.fontSize,
    );
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: widget.isDark ? COLORS.DARK_GREY : COLORS.LIGHTER_GREY,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: decreaseCounter,
            child: Container(
              height: widget.height,
              width: widget.width / 3,
              alignment: Alignment.center,
              color: Colors.transparent,
              child: Text(
                "-",
                style: style,
              ),
            ),
          ),
          Container(
            height: widget.height,
            width: widget.width / 3,
            alignment: Alignment.center,
            child: Text(
              "$counterValue",
              style: style,
            ),
          ),
          GestureDetector(
            onTap: increaseCounter,
            child: Container(
              color: Colors.transparent,
              height: widget.height,
              width: widget.width / 3,
              alignment: Alignment.center,
              child: Text(
                "+",
                style: style,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
