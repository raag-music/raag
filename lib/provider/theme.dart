import 'package:flutter/material.dart';

Color hex(String hexColor) {
  hexColor = hexColor.replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  if (hexColor.length == 8) {
    return Color(int.parse("0x$hexColor"));
  }
}

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),

    colorScheme: ColorScheme.light(
      primary: Colors.white,
      onPrimary: Colors.black,
      primaryVariant: Colors.white38,
      secondary: Colors.red,
    ),

    cardTheme: CardTheme(
      color: Colors.white,
    ),

    iconTheme: IconThemeData(
      color: Colors.black,
    ),

    textTheme: TextTheme(
      headline1: TextStyle(
          color: Colors.black,
          fontSize: 40.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Passion One'
      ),
      headline3: TextStyle(
          color: Colors.black,
          fontSize: 24.0,
          fontFamily: 'Passion One'
      ),
      subtitle2: TextStyle(
        color: Colors.black38,
        fontSize: 16.0,
      ),

    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: hex('262626'),
    appBarTheme: AppBarTheme(
      color: hex('262626'),
      iconTheme: IconThemeData(
        color: hex('809DF5'),
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.black,
      onPrimary: Colors.black,
      primaryVariant: Colors.black,
      secondary: Colors.red,
    ),
    cardTheme: CardTheme(
      color: Colors.black38,
    ),
    iconTheme: IconThemeData(
      color: hex('#888888'),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: hex('809DF5'),
        fontSize: 40.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Alata'
      ),
      headline3: TextStyle(
          color: hex('809DF5'),
          fontSize: 24.0,
          fontFamily: 'Alata'
      ),
      subtitle2: TextStyle(
        color: hex('D4D4D4'),
        fontSize: 16.0,
      ),
    ),
  );
}
