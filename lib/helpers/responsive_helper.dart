import 'package:flutter/material.dart';

enum DeviceType { mobile, largeMobile, tablet }

DeviceType getDeviceType(BuildContext context) {
  final shortestSide = MediaQuery.of(context).size.shortestSide;
  final longestSide = MediaQuery.of(context).size.longestSide;

  // Determine if we should use mobile layout or not, 600 here is
  // a common breakpoint for a typical 7-inch tablet.
  return shortestSide < 600
      ? longestSide > 800
          ? DeviceType.largeMobile
          : DeviceType.mobile
      : DeviceType.tablet;
}

bool isTablet(BuildContext context) {
  return getDeviceType(context) == DeviceType.tablet;
}
