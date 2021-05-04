import 'package:flutter/material.dart';
import 'package:fresh_food/enums/device_screen_type.dart';
import 'package:fresh_food/responsive/responsive_builder.dart';
import 'package:fresh_food/widgets/centered_view/centered_view.dart';

class ScreenTypeLayout extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ScreenTypeLayout({
    Key key,
    this.mobile,
    this.tablet,
    this.desktop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.Tablet) {
          if (tablet != null) {
            return tablet;
          }
        }

        if (sizingInformation.deviceScreenType == DeviceScreenType.Desktop) {
          if (desktop != null) {
            return CenteredView(child: desktop);
          }
        }

        return mobile;
      },
    );
  }
}
