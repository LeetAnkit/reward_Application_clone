import 'package:flutter/material.dart';

class ColorHelper {
  static Color keepOrWhite(Color textColor, Color backgroundColor,
      [Color? alternateColor]) {   // optional value
    if (isDark(textColor) && isDark(backgroundColor))
      return alternateColor ?? Colors.white;
    return textColor;
  }

  static bool isDark(Color color) {
    return color.computeLuminance() < 0.5;
  }
}

//Nullable types allow for optional data For example, a user do not
// not provide their middle name, so then middle name field will be nullable.
