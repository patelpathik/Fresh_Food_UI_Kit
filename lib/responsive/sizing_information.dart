import 'package:flutter/material.dart';
import 'package:fresh_food/enums/device_screen_type.dart';

class SizingInformation {
  final DeviceScreenType deviceScreenType;
  final Size screenSize;
  final Size localWidgetSize;

  SizingInformation({
    this.deviceScreenType,
    this.screenSize,
    this.localWidgetSize,
  });

  @override
  String toString() {
    return 'DeviceScreenType: $deviceScreenType\nScreenSize: $screenSize\nLocalWidgetSize: $localWidgetSize';
  }
}
