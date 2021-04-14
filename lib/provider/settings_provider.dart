import 'package:flutter/material.dart';
import 'package:raag/model/SharedPreferences.dart';

class SettingsProvider extends ChangeNotifier{
  Preferences sharedPreference = Preferences();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;
  bool _appStorage = false;

  bool get appStorage => _appStorage;

  set darkTheme(bool value) {
    _darkTheme = value;
    sharedPreference.setBool(Preferences.THEME_STATUS, value);
    notifyListeners();
  }

  set appStorage(bool value) {
    _appStorage = value;
    sharedPreference.setBool(Preferences.DOWNLOAD_DIRECTORY, value);
    notifyListeners();
  }

  void changeTheme() {
    darkTheme = darkTheme ? false : true;
    notifyListeners();
  }

  bool _refreshComplete = false;

  bool get refreshComplete => _refreshComplete;

  set refreshComplete(bool value) {
    _refreshComplete = value;
    notifyListeners();
  }
}