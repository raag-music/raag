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

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return isDarkTheme ? AppTheme.lightTheme : AppTheme.darkTheme;
  }
}

class AppTheme {
  AppTheme._();

  //Light theme data
  static final ThemeData lightTheme = ThemeData(
    accentColor: hex('#415EB4'),
    backgroundColor: hex('#D4D4D4'),
    scaffoldBackgroundColor: hex('#D4D4D4'),
    dividerColor: hex('999999'),
    appBarTheme: AppBarTheme(
      color: hex('#D4D4D4'),
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
      color: hex('#D4D4D4'),
    ),

    iconTheme: IconThemeData(
      color: Colors.black26,
    ),

    textTheme: TextTheme(
      headline1: TextStyle(
          color: hex('#415EB4'),
          fontSize: 40.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Alata'
      ),
      headline3: TextStyle(
          color: hex('#415EB4'),
          fontSize: 20.0,
          fontFamily: 'Alata'
      ),
      subtitle2: TextStyle(
        color: Colors.black38,
        fontSize: 14.0,
      ),

    ),
  );

  //Dark theme data
  static final ThemeData darkTheme = ThemeData(
    backgroundColor: hex('262626'),
    accentColor: hex('809DF5'),
    dividerColor: hex('404040'),
    scaffoldBackgroundColor: hex('262626'),
    appBarTheme: AppBarTheme(
      color: hex('262626'),
      iconTheme: IconThemeData(
        color: hex('809DF5'),
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: hex('809DF5'),
      onPrimary: Colors.black,
      primaryVariant: Colors.black,
      secondary: Colors.red,
    ),
    cardTheme: CardTheme(
      color: hex('262626'),
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
          fontSize: 20.0,
          fontFamily: 'Alata'
      ),
      subtitle2: TextStyle(
        color: hex('D4D4D4'),
        fontSize: 16.0,
      ),
    ),
  );
}