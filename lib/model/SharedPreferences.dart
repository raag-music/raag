import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences prefs;

class DarkThemePreference {
  static const THEME_STATUS = "THEMESTATUS";

  setDarkTheme(bool value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATUS, value);
  }

  Future<bool> getTheme() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_STATUS) ?? false;
  }
}

class DBStatus{
  static const DB_POPULATED = "DB_POPULATED";

  setDBStatus(bool value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool(DB_POPULATED, value);
  }

  Future<bool> isDBPopulated() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool(DB_POPULATED) ?? false;
  }
}