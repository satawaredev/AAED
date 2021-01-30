import 'package:flutter/material.dart';

import 'constants.dart';

enum AppTheme {
  LightTheme,
  DarkTheme,Red,Green,Orange,Purple,Yellow,
}

final appThemeData = {

  AppTheme.LightTheme: ThemeData(
    brightness: Brightness.light,
    platform: TargetPlatform.iOS,
    scaffoldBackgroundColor: Colors.white,
    toggleableActiveColor: kColorPrimary,
    appBarTheme: AppBarTheme(
      elevation: 1,
      color: Colors.white,
      brightness: Brightness.light,
      iconTheme: IconThemeData(
        color: kColorPrimary,
      ),
      actionsIconTheme: IconThemeData(
        color: kColorPrimary,
      ),
      textTheme: TextTheme(
        headline6: TextStyle(
          color: kColorDarkBlue,
          fontFamily: 'NunitoSans',
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    dividerColor: Colors.grey[300],
    textTheme: TextTheme(
      button: kTextStyleButton,
      subtitle1: kTextStyleSubtitle1.copyWith(color: kColorPrimaryDark),
      subtitle2: kTextStyleSubtitle2.copyWith(color: kColorPrimaryDark),
      bodyText2: kTextStyleBody2.copyWith(color: kColorPrimaryDark),
      headline6: kTextStyleHeadline6.copyWith(color: kColorPrimaryDark),
    ),
    iconTheme: IconThemeData(
      color: kColorPrimary,
    ),
    fontFamily: 'NunitoSans',
    cardTheme: CardTheme(
      elevation: 0,
      color: Color(0xffEBF2F5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        //side: BorderSide(width: 1, color: Colors.grey[200]),
      ),
    ),
  ),
  AppTheme.Red: ThemeData(
    appBarTheme: AppBarTheme(centerTitle: true,
      color: Colors.redAccent,
      iconTheme: IconThemeData(
        color: Colors.white,
      )
    ),
    brightness: Brightness.light,
    primaryColor: Colors.redAccent,
  ),
  AppTheme.Green: ThemeData(
    appBarTheme: AppBarTheme(centerTitle: true,
      color: Colors.green,
      iconTheme: IconThemeData(
        color: Colors.white,
      )),
    brightness: Brightness.light,
    primaryColor: Colors.green,
  ),
  AppTheme.Purple: ThemeData(
    appBarTheme: AppBarTheme(centerTitle: true,
        color: Colors.purple,
        iconTheme: IconThemeData(
          color: Colors.white,
        )),
    brightness: Brightness.light,
    primaryColor: Colors.purple,
  ),
  AppTheme.Orange: ThemeData(
    appBarTheme: AppBarTheme(centerTitle: true,
        color: Colors.deepOrange,
        iconTheme: IconThemeData(
          color: Colors.white,
        )),
    brightness: Brightness.light,
    primaryColor: Colors.deepOrange,
  ),
  AppTheme.Yellow: ThemeData(
    appBarTheme: AppBarTheme(centerTitle: true,
        color: Colors.yellow,
        iconTheme: IconThemeData(
          color: Colors.black,
        )),
    brightness: Brightness.light,
    primaryColor: Colors.yellow,
  ),
  AppTheme.DarkTheme: ThemeData(
    brightness: Brightness.dark,
    platform: TargetPlatform.iOS,
    toggleableActiveColor: kColorPrimary,
    accentColor: kColorPrimary,
    appBarTheme: AppBarTheme(
      elevation: 1,
      brightness: Brightness.dark,
      iconTheme: IconThemeData(
        color: kColorPrimary,
      ),
      actionsIconTheme: IconThemeData(
        color: kColorPrimary,
      ),
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.white,
          fontFamily: 'NunitoSans',
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    dividerColor: Colors.white54,
    textTheme: TextTheme(
      button: kTextStyleButton,
      subtitle1:
          kTextStyleSubtitle1.copyWith(color: Colors.white.withOpacity(0.87)),
      subtitle2:
          kTextStyleSubtitle2.copyWith(color: Colors.white.withOpacity(0.87)),
      bodyText2:
          kTextStyleBody2.copyWith(color: Colors.white.withOpacity(0.87)),
      headline6:
          kTextStyleHeadline6.copyWith(color: Colors.white.withOpacity(0.87)),
    ),
    iconTheme: IconThemeData(
      color: kColorPrimary,
    ),
    fontFamily: 'NunitoSans',
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: BorderSide(width: 0, color: Colors.transparent),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white.withOpacity(0.87),
        ),
      ),
    ),
  ),
};
