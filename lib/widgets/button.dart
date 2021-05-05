import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fresh_food/theme/app_theme.dart';
import 'package:fresh_food/theme/images.dart';

class Button extends StatelessWidget {
  final String title;
  final Function onPressed;
  final bool showCartIcon;

  const Button({
    Key key,
    @required this.title,
    @required this.onPressed,
    this.showCartIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = TextStyle(
      fontSize: Theme.of(context).textTheme.caption.fontSize,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(50)),
      child: Material(
        color: COLORS.GREEN,
        child: InkWell(
          splashColor: COLORS.LIGHT_GREY,
          onTap: onPressed,
          child: Container(
            padding: EdgeInsets.only(top: 13, bottom: 13),
            height: AppBar().preferredSize.height,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  showCartIcon ? ThemeIcon.ADD_CART : ThemeIcon.ARROW_SMALL,
                ),
                SizedBox(width: 10),
                Text(title, style: titleStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CleanButton extends StatefulWidget {
  final String title;
  final Function onPressed;

  const CleanButton({
    Key key,
    @required this.title,
    @required this.onPressed,
  }) : super(key: key);

  @override
  _CleanButtonState createState() => _CleanButtonState();
}

class _CleanButtonState extends State<CleanButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        widget.title,
        style: TextStyle(color: COLORS.MEDIUM_GREY),
      ),
      onPressed: widget.onPressed,
    );
  }
}
