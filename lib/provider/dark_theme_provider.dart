import 'package:flutter/material.dart';
import 'package:raag/model/SharedPreferences.dart';

class DarkThemeProvider with ChangeNotifier {
  Preferences darkThemePreference = Preferences();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setBool(Preferences.THEME_STATUS,value);
    notifyListeners();
  }
}
