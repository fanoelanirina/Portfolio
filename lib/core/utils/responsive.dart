import 'package:flutter/material.dart';

enum DeviceType { mobile, tablet, desktop }

class Responsive {
  Responsive._();

  static DeviceType of(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 600) return DeviceType.mobile;
    if (width < 1024) return DeviceType.tablet;
    return DeviceType.desktop;
  }

  static bool isMobile(BuildContext context) =>
      of(context) == DeviceType.mobile;
}