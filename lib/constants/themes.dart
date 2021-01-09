import 'package:flutter/material.dart';
import 'package:g_shop/constants/colors.dart';

List<ThemeData> getThemes() {
  return [
    ThemeData(
      brightness: brightnessDark,
      textTheme: TextTheme(
        button: const TextStyle(color: whiteColor, fontSize: 18),
        headline4: const TextStyle(color: whiteColor),
        headline3: const TextStyle(color: whiteColor, fontSize: 18, fontWeight: FontWeight.w400),
        headline2: const TextStyle(color: whiteColor, fontSize: 22, fontWeight: FontWeight.w400),
        headline1: const TextStyle(color: whiteColor, fontSize: 24, fontWeight: FontWeight.w400),
        bodyText1: const TextStyle(color: whiteColor, fontSize: 16, fontWeight: FontWeight.w400),
        bodyText2: TextStyle(color: whiteColor.withOpacity(0.6), fontSize: 14),
      ),
      appBarTheme: const AppBarTheme(
        brightness: brightnessDark,
        color: blackGrayColor,
        iconTheme: const IconThemeData(
          color: whiteColor,
        ),
      ),
      cardTheme: CardTheme(
        color: grayColor_3,
        shadowColor: blackColor,
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.only(top: 8.0, right: 10.0, left: 10.0),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: lightGreen,
        foregroundColor: whiteColor.withOpacity(0.3),
      ),
      iconTheme: const IconThemeData(
        color: whiteColor,
      ),
      buttonColor: lightGreen,
      accentColor: lightGreen,
      primaryColor: blackGrayColor,
      scaffoldBackgroundColor: mediumGray,
      cardColor: mediumGray,
    ),
    ThemeData(
      brightness: brightnessLight,
      textTheme: TextTheme(
        button: const TextStyle(color: whiteColor, fontSize: 18),
        headline4: const TextStyle(color: blackGrayColor),
        headline3: const TextStyle(color: blackGrayColor, fontSize: 18, fontWeight: FontWeight.w400),
        headline2: const TextStyle(color: whiteColor, fontSize: 22, fontWeight: FontWeight.w400),
        headline1: const TextStyle(color: blackGrayColor, fontSize: 24, fontWeight: FontWeight.w400),
        bodyText1: const TextStyle(color: blackGrayColor, fontSize: 16, fontWeight: FontWeight.w400),
        bodyText2: TextStyle(color: blackGrayColor.withOpacity(0.6), fontSize: 14),
      ),
      appBarTheme: const AppBarTheme(
        brightness: brightnessDark,
        color: lightGreen,
        iconTheme: const IconThemeData(
          color: whiteColor,
        ),
      ),
      cardTheme: CardTheme(
        color: whiteColor,
        shadowColor: blackColor,
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.only(top: 8.0, right: 10.0, left: 10.0),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: lightGreen,
        foregroundColor: whiteColor.withOpacity(0.3),
      ),
      iconTheme: const IconThemeData(
        color: whiteColor,
      ),
      buttonColor: lightGreen,
      accentColor: lightGreen,
      primaryColor: lightGreen,
      scaffoldBackgroundColor: whiteGray,
      cardColor: whiteColor,
    ),
  ];
}
