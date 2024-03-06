import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late LocalStorage _instance;
  static late SharedPreferences _preferences;

  static Future<LocalStorage> getInstance() async {
    _instance = LocalStorage();
    _preferences = await SharedPreferences.getInstance();
    return _instance;
  }

  // Save a String value
  Future<void> setString(String key, String value) async {
    await _preferences.setString(key, value);
  }

  // Get String value based on key
  String? getString(String key) {
    return _preferences.getString(key);
  }

  // Save a boolean value
  Future<void> setBool(String key, bool value) async {
    await _preferences.setBool(key, value);
  }

  // Get boolean value based on key
  bool? getBool(String key) {
    return _preferences.getBool(key);
  }

  // Remove a value based on key
  Future<void> remove(String key) async {
    await _preferences.remove(key);
  }
}
