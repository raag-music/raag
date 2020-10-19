import 'package:flutter/material.dart';

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
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.white,
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
      color: Colors.white70,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.white,
        fontSize: 40.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Passion One'
      ),
      headline3: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontFamily: 'Passion One'
      ),
      subtitle2: TextStyle(
        color: Colors.white70,
        fontSize: 16.0,
      ),
    ),
  );
}
