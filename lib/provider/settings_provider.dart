import 'package:flutter/material.dart';
import 'package:raag/model/SharedPreferences.dart';
import 'package:raag/model/strings.dart';

class SettingsProvider extends ChangeNotifier {
  Preferences sharedPreference = Preferences();
  bool _darkTheme = false;
  bool _refreshComplete = false;
  String? _downloadPath;

  bool get darkTheme => _darkTheme;
  bool get refreshComplete => _refreshComplete;
  String get downloadPath {
    if (_downloadPath == null || _downloadPath!.isEmpty) {
      return "/storage/emulated/0/Music/$appName";
    } else
      return _downloadPath!;
  }

  set downloadPath(String value) {
    _downloadPath = value;
    sharedPreference.setString(Preferences.DOWNLOAD_PATH, value);
    notifyListeners();
  }

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
