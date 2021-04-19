import 'package:flutter/material.dart';
import 'package:g_shop/constants/colors.dart';

List<ThemeData> getThemes() {
  return [
    ThemeData(
      brightness: brightnessDark,
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorBlackGray,
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: colorVeryLightGreen.withOpacity(0.5),
        selectionHandleColor: colorVeryLightGreen,
      ),
      textTheme: TextTheme(
        button: const TextStyle(color: colorWhite, fontSize: 18),
        headline4: const TextStyle(color: colorWhite),
        headline3: const TextStyle(color: colorWhite, fontSize: 18, fontWeight: FontWeight.w400),
        headline2: const TextStyle(color: colorWhite, fontSize: 22, fontWeight: FontWeight.w400),
        headline1: const TextStyle(color: colorWhite, fontSize: 24, fontWeight: FontWeight.w400),
        bodyText1: const TextStyle(color: colorWhite, fontSize: 16, fontWeight: FontWeight.w400),
        bodyText2: TextStyle(color: colorWhite.withOpacity(0.6), fontSize: 14),
      ),
      appBarTheme: const AppBarTheme(
        brightness: brightnessDark,
        color: colorBlackGray,
        iconTheme: const IconThemeData(
          color: colorWhite,
        ),
      ),
      cardTheme: CardTheme(
        color: colorGray_3,
        shadowColor: colorBlack,
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.only(top: 8.0, right: 10.0, left: 10.0),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorLightGreen,
        foregroundColor: colorWhite.withOpacity(0.3),
      ),
      iconTheme: const IconThemeData(
        color: colorWhite,
      ),
      buttonColor: colorLightGreen,
      accentColor: colorLightGreen,
      primaryColor: colorBlackGray,
      scaffoldBackgroundColor: colorMediumGray,
      cardColor: colorGray_3,
      dividerColor: colorWhite,
    ),
    ThemeData(
      brightness: brightnessLight,
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorWhite,
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: colorVeryLightGreen.withOpacity(0.5),
        selectionHandleColor: colorVeryLightGreen,
      ),
      textTheme: TextTheme(
        button: const TextStyle(color: colorWhite, fontSize: 18),
        headline4: const TextStyle(color: colorBlackGray),
        headline3: const TextStyle(color: colorBlackGray, fontSize: 18, fontWeight: FontWeight.w400),
        headline2: const TextStyle(color: colorWhite, fontSize: 22, fontWeight: FontWeight.w400),
        headline1: const TextStyle(color: colorBlackGray, fontSize: 24, fontWeight: FontWeight.w400),
        bodyText1: const TextStyle(color: colorBlackGray, fontSize: 16, fontWeight: FontWeight.w400),
        bodyText2: TextStyle(color: colorBlackGray.withOpacity(0.6), fontSize: 14),
      ),
      appBarTheme: const AppBarTheme(
        brightness: brightnessDark,
        color: colorLightGreen,
        iconTheme: const IconThemeData(
          color: colorWhite,
        ),
      ),
      cardTheme: CardTheme(
        color: colorWhite,
        shadowColor: colorBlack,
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.only(top: 8.0, right: 10.0, left: 10.0),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorLightGreen,
        foregroundColor: colorWhite.withOpacity(0.3),
      ),
      iconTheme: const IconThemeData(
        color: colorWhite,
      ),
      buttonColor: colorLightGreen,
      accentColor: colorLightGreen,
      primaryColor: colorLightGreen,
      scaffoldBackgroundColor: colorWhite,
      cardColor: colorWhite,
      dividerColor: colorBlack,
    ),
  ];
}
