import 'package:flutter/material.dart';

const primaryColor = Color(0xFF12073D);
const secondaryColor = Color(0xFF5CE2E7);

TextStyle getTextStyle({
  Color color = Colors.black,
  double size = 16,
  FontWeight weight = FontWeight.normal,
  FontStyle style = FontStyle.normal,
  double letterSpacing = 0,
  double wordSpacing = 0,
  TextDecoration decoration = TextDecoration.none,
  TextDecorationStyle decorationStyle = TextDecorationStyle.solid,
  double height = 1.5,
  String fontFamily = 'Roboto',
}) {
  return TextStyle(
    color: color,
    fontSize: size,
    fontWeight: weight,
    fontStyle: style,
    letterSpacing: letterSpacing,
    wordSpacing: wordSpacing,
    decoration: decoration,
    decorationStyle: decorationStyle,
    height: height,
    fontFamily: fontFamily,
  );
}
