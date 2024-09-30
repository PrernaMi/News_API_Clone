import 'dart:ui';

import 'package:flutter/material.dart';

class mTextStyle {

  static TextStyle mStyle({
    FontWeight fontWeight = FontWeight.normal,
    Color fontColor = Colors.black,
    double fontSize = 20,
  }) {
    return TextStyle(
        fontWeight: fontWeight, fontSize: fontSize, color: fontColor);
  }
}
