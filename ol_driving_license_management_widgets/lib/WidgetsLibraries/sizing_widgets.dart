import 'package:flutter/material.dart';

class SizingWidgets {
  SizingWidgets._();

  static double getPecentSuitableWidgetWidth(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double widthFactor;
    if (screenWidth < 600) {
      widthFactor = 0.9; // موبايل
    } else if (screenWidth < 1000) {
      widthFactor = 0.7; // تابلت
    } else {
      widthFactor = 0.4; // شاشات أكبر
    }

    return widthFactor;
  }
}
