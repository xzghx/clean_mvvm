import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';
import 'values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    //Set Color
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primaryOpacity70,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
    splashColor: ColorManager.primaryOpacity70,
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: ColorManager.grey),
    //Set appBar
    appBarTheme: AppBarTheme(
      color: ColorManager.primary,
      shadowColor: ColorManager.grey,
      titleTextStyle: regularTextStyle(
        color: ColorManager.white,
        fontSize: FontSizeManager.s16,
      ),
    ),
    //Set CardView
    cardTheme: CardTheme(
        elevation: AppSize.s4,
        color: ColorManager.white,
        shadowColor: ColorManager.primaryOpacity70),
    //Button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.grey1,
      splashColor: ColorManager.primaryOpacity70,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: regularTextStyle(color: ColorManager.white),
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    //Set TextTheme
    textTheme: TextTheme(
      //headline 1
      displayLarge: semiBoldTextStyle(
          fontSize: FontSizeManager.s16, color: ColorManager.darkGrey),
      //subtitle 1
      titleMedium: mediumTextStyle(
          fontSize: FontSizeManager.s14, color: ColorManager.lightGrey),
      //caption
      bodySmall: regularTextStyle(color: ColorManager.grey1),
      //bodyText1
      bodyLarge: regularTextStyle(color: ColorManager.grey),
    ),
    //Set InputDecoration
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPaddings.p8),
      hintStyle: regularTextStyle(
        color: ColorManager.grey1,
      ),
      labelStyle: mediumTextStyle(color: ColorManager.darkGrey),
      errorStyle: regularTextStyle(color: ColorManager.error),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.error, width: AppSize.s1_5),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
    ),
  );
}
