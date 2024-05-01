import 'package:shared_preferences/shared_preferences.dart';

class MyLocalStorage {

  static setBool(String key, value) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setBool(key, value);
  }

  static setString(String key, value) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString(key, value);
  }

  static Future<bool?> getBool(String key) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.getBool(key);
  }

  static Future<String?> getString(String key) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.getString(key);
  }

  static setInt(String key, int value) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setInt(key, value);
  }

  static Future<int?> getInt(String key) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.getInt(key) ?? 0;
  }

  static dynamic clear() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return await storage.clear();
  }

}
