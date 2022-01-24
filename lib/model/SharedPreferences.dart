import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

class Preferences {
  static const THEME_STATUS = 'THEME_STATUS';
  static const DOWNLOAD_PATH = 'DOWNLOAD_PATH';
  static const ON_BOARDING_DONE = 'ON_BOARDING_DONE';

  void setBool(String key, bool value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  Future<bool> getBool(String key) async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  void setString(String key, String value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}
