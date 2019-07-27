/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get main => ThemeData(
      fontFamily: 'Roboto',
      primaryColor: AppColors.white,
      accentColor: AppColors.black,
      scaffoldBackgroundColor: AppColors.white,
      cardColor: AppColors.white,
      errorColor: AppColors.white,
      indicatorColor: AppColors.lightGray,
    );
}

class AppColors {
  static Color get transparent => const Color(0x00000000);
  static Color get black => const Color(0xFF161616);
  static Color get white => const Color(0xFFFFFFFF);
  static Color get yellow => const Color(0xFFF1C40F);
  static Color get orange => const Color(0xFFD35400);
  static Color get red => const Color(0xFFFF3838);
  static Color get green => const Color(0xFF27AE60);
  static Color get lightGreen => const Color(0xFFBADC58);
  static Color get blue => const Color(0xFF22A7F0);
  static Color get gray => const Color(0xFFE9E9E9);
  static Color get lightGray => const Color(0xFFBDBDBD);
  static Color get darkGray => const Color(0xFF6E6E6E);
}

class AppTextStyles {
  static TextStyle get header1 => TextStyle(fontSize: 24, fontFamily: 'Roboto', fontWeight: FontWeight.bold);
  static TextStyle get header2 => TextStyle(fontSize: 20, letterSpacing: 0.25, fontFamily: 'Roboto', fontWeight: FontWeight.bold);
  static TextStyle get subtitle1 => TextStyle(fontSize: 16, letterSpacing: 0.15, fontFamily: 'Roboto', fontWeight: FontWeight.bold);
  static TextStyle get subtitle2 => TextStyle(fontSize: 14, letterSpacing: 0.1, fontFamily: 'Roboto', fontWeight: FontWeight.bold);
  static TextStyle get body1 => TextStyle(fontSize: 16, letterSpacing: 0.5, fontFamily: 'Roboto', fontWeight: FontWeight.w400);
  static TextStyle get body2 => TextStyle(fontSize: 14, letterSpacing: 0.25, fontFamily: 'Roboto', fontWeight: FontWeight.w400);
  static TextStyle get body3 => TextStyle(fontSize: 12, letterSpacing: 0.25, fontFamily: 'Roboto', fontWeight: FontWeight.w400);
  static TextStyle get button => TextStyle(fontSize: 14, letterSpacing: 1.25, fontFamily: 'Roboto');
  static TextStyle get caption => TextStyle(fontSize: 12, letterSpacing: 2, fontFamily: 'Roboto', fontWeight: FontWeight.w400);
}

class AppLengths {
  static const double tiny = 5.0;
  static const double small = 15.0;
  static const double medium = 30.0;
  static const double large = 60.0;
}

class AppEdges {
  static const EdgeInsets noneAll = const EdgeInsets.all(0.0);
  static const EdgeInsets tinyAll = const EdgeInsets.all(AppLengths.tiny);
  static const EdgeInsets tinyHorizontal = const EdgeInsets.symmetric(horizontal: AppLengths.tiny);
  static const EdgeInsets tinyVertical = const EdgeInsets.symmetric(vertical: AppLengths.tiny);
  static const EdgeInsets smallAll = const EdgeInsets.all(AppLengths.small);
  static const EdgeInsets smallHorizontal = const EdgeInsets.symmetric(horizontal: AppLengths.small);
  static const EdgeInsets smallVertical = const EdgeInsets.symmetric(vertical: AppLengths.small);
  static const EdgeInsets mediumAll = const EdgeInsets.all(AppLengths.medium);
  static const EdgeInsets mediumHorizontal = const EdgeInsets.symmetric(horizontal: AppLengths.medium);
  static const EdgeInsets mediumVertical = const EdgeInsets.symmetric(vertical: AppLengths.medium);
  static const EdgeInsets largeAll = const EdgeInsets.all(AppLengths.large);
  static const EdgeInsets largeHorizontal = const EdgeInsets.symmetric(horizontal: AppLengths.large);
  static const EdgeInsets largeVertical = const EdgeInsets.symmetric(vertical: AppLengths.large);
}

class AppBorders {
  static get bezel => RoundedRectangleBorder(borderRadius: bezelGeom);
  static get bezelGeom => BorderRadius.circular(15.0);
}