import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

hex(String hexColor) {
  hexColor = hexColor.replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  return Color(int.parse("0x$hexColor"));
}

TextStyle durationTheme =
    TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w500);

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return isDarkTheme ? AppTheme.lightTheme : AppTheme.darkTheme;
  }

  static AlertStyle alertStyle(BuildContext context) {
    return AlertStyle(
      animationType: AnimationType.grow,
      backgroundColor: Theme.of(context).backgroundColor,
      titleStyle: Theme.of(context).textTheme.headline3!,
      descStyle: Theme.of(context).textTheme.subtitle1!,
    );
  }
}

class AppTheme {
  AppTheme._();

  //Light theme data
  static final ThemeData lightTheme = ThemeData(
    // accentColor: hex('#415EB4'),
    backgroundColor: hex('#D4D4D4'),
    scaffoldBackgroundColor: hex('#D4D4D4'),
    dividerColor: hex('ededed'),
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
      secondary: hex('#415EB4'),
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
          fontFamily: 'Alata'),
      headline3:
          TextStyle(color: hex('#415EB4'), fontSize: 18, fontFamily: 'Alata'),
      subtitle1:
          TextStyle(color: hex('5a6a99'), fontSize: 14, fontFamily: 'Alata'),
      subtitle2: TextStyle(
        color: Colors.black38,
        fontSize: 12.0,
      ),
    ),
  );

  //Dark theme data
  static final ThemeData darkTheme = ThemeData(
    backgroundColor: hex('000000'),
    // accentColor: hex('809DF5'),
    dividerColor: hex('1a1a1a'),
    scaffoldBackgroundColor: hex('000000'),
    appBarTheme: AppBarTheme(
      color: hex('000000'),
      iconTheme: IconThemeData(
        color: hex('809DF5'),
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: hex('809DF5'),
      onPrimary: Colors.black,
      primaryVariant: Colors.black,
      secondary: hex('809DF5'),
    ),
    cardTheme: CardTheme(
      color: hex('000000'),
    ),
    iconTheme: IconThemeData(
      color: hex('#888888'),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
          color: hex('809DF5'),
          fontSize: 40.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Alata'),
      headline3:
          TextStyle(color: hex('809DF5'), fontSize: 18, fontFamily: 'Alata'),
      subtitle1:
          TextStyle(color: hex('5a6a99'), fontSize: 14, fontFamily: 'Alata'),
      subtitle2: TextStyle(
        color: hex('D4D4D4'),
        fontSize: 12,
      ),
    ),
  );
}
