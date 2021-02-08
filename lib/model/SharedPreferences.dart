import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences prefs;

class Preferences {
  static const THEME_STATUS = 'THEME_STATUS';
  static const DB_POPULATED = 'DB_POPULATED';
  static const ON_BOARDING_DONE = 'ON_BOARDING_DONE';
  static const DOWNLOAD_DIRECTORY = 'DOWNLOAD_DIRECTORY';

  void setBool(String key, bool value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  Future<bool> getBool(String key) async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  void setString (String key, String value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<String> getString (String key) async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}