import 'package:flutter/material.dart';
import 'package:raag/model/SharedPreferences.dart';

class SettingsProvider extends ChangeNotifier{
  Preferences sharedPreference = Preferences();
  bool _darkTheme = false;
  bool _refreshComplete = false;

  bool get darkTheme => _darkTheme;
  bool get refreshComplete => _refreshComplete;

  set darkTheme(bool value) {
    _darkTheme = value;
    sharedPreference.setBool(Preferences.THEME_STATUS, value);
    notifyListeners();
  }

  void changeTheme() {
    darkTheme = darkTheme ? false : true;
    notifyListeners();
  }

  set refreshComplete(bool value) {
    _refreshComplete = value;
    notifyListeners();
  }
}