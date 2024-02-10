import 'package:flutter/material.dart';

class ResponsiveUI {
  final BuildContext context;
  ResponsiveUI({
    required this.context,
  });

  double getScreenWidth() {
    return MediaQuery.of(context).size.width;
  }

  double getScreenHeight() {
    return MediaQuery.of(context).size.height;
  }

  bool isMobile() {
    return getScreenWidth() <= 850;
  }

  bool isTablet() {
    return getScreenWidth() > 850 && getScreenWidth() <= 1200;
  }

  bool isDesktop() {
    return getScreenWidth() > 1200;
  }

  Widget getResponsiveWidget({
    required Widget mobile,
    Widget? tablet,
    required Widget desktop,
  }) {
    if (isMobile()) {
      return mobile;
    } else if (isTablet()) {
      return tablet ?? desktop;
    } else {
      return desktop;
    }
  }
}
