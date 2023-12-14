import 'package:clean_mvvm_project/presentation/resources/font_manager.dart';
import 'package:flutter/material.dart';

TextStyle _getTextStyle(
    {required String fontFamily,
    required FontWeight fontWeight,
    required double fontSize,
    required Color color}) {
  return TextStyle(
    fontFamily: fontFamily,
    fontWeight: fontWeight,
    fontSize: fontSize,
    color: color,
  );
}

TextStyle lightTextStyle(
    {double fontSize = FontSizeManager.s18, Color color = Colors.black}) {
  return _getTextStyle(
      fontFamily: FontManager.fontFamily,
      fontWeight: FontWeightManager.light,
      fontSize: fontSize,
      color: color);
}

TextStyle regularTextStyle(
    {double fontSize = FontSizeManager.s18, Color color = Colors.black}) {
  return _getTextStyle(
      fontFamily: FontManager.fontFamily,
      fontWeight: FontWeightManager.regular,
      fontSize: fontSize,
      color: color);
}

TextStyle mediumTextStyle(
    {double fontSize = FontSizeManager.s18, Color color = Colors.black}) {
  return _getTextStyle(
      fontFamily: FontManager.fontFamily,
      fontWeight: FontWeightManager.medium,
      fontSize: fontSize,
      color: color);
}

TextStyle semiBoldTextStyle(
    {double fontSize = FontSizeManager.s18, Color color = Colors.black}) {
  return _getTextStyle(
      fontFamily: FontManager.fontFamily,
      fontWeight: FontWeightManager.semiBold,
      fontSize: fontSize,
      color: color);
}

TextStyle boldTextStyle(
    {double fontSize = FontSizeManager.s18, Color color = Colors.black}) {
  return _getTextStyle(
      fontFamily: FontManager.fontFamily,
      fontWeight: FontWeightManager.bold,
      fontSize: fontSize,
      color: color);
}
