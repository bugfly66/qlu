import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;
class Storage {
  static Future<bool> setData(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(key, value);
  }

  static Future<bool> setListDate(String key, List<String> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setStringList(key, value);
  }

  static Future<String?> getData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<List<String>?> getListData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }
}