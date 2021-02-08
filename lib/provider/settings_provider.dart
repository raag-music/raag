import 'package:flutter/material.dart';
import 'package:raag/model/SharedPreferences.dart';

class SettingsProvider extends ChangeNotifier{
  Preferences darkThemePreference = Preferences();
  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setBool(Preferences.THEME_STATUS,value);
    notifyListeners();
  }

  void changeTheme(){
    darkTheme = darkTheme ? false : true ;
    notifyListeners();
  }

  bool _refreshComplete = false;
  bool get refreshComplete => _refreshComplete;

  set refreshComplete(bool value){
    _refreshComplete = value;
    notifyListeners();
  }
}