import 'package:flutter/material.dart';

class PVLongClickColorProvider extends ChangeNotifier {
  PVLongClickColorProvider({
    required this.onClickColor,
    required this.onEndClickColor,
  }) {
    currentColor = onEndClickColor;
  }

  final Color onClickColor;
  final Color onEndClickColor;

  Color? currentColor;

  void click() {
    currentColor = onClickColor;
    notifyListeners();
  }

  endClick() {
    currentColor = onEndClickColor;
    notifyListeners();
  }
}
