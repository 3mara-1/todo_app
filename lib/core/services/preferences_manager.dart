import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  static final PreferencesManager _instanc = PreferencesManager._internal();

  factory PreferencesManager() {
    return _instanc;
  }
  late final SharedPreferences _preference;

  PreferencesManager._internal();

  init() async {
    _preference = await SharedPreferences.getInstance();
  }

  String? getString(String key) {
    return _preference.getString(key);
  }

  Future<bool> setString(String key, value) async {
    return await _preference.setString(key, value);
  }

  double? getDouble(String key) {
    return _preference.getDouble(key);
  }

  Future<bool> setDouble(String key, value) async {
    return await _preference.setDouble(key, value);
  }

  int? getInt(String key) {
    return _preference.getInt(key);
  }

  Future<bool> setInt(String key,int value) async {
    return await _preference.setInt(key, value);
  }
 bool? getBool(String key) {
    return _preference.getBool(key);
  }

  Future<bool> setBool(String key,bool value) async {
    return await _preference.setBool(key, value);
  }
 List<String>? getStringList(String key) {
    return _preference.getStringList(key);
  }

  Future<bool> setStringList( String key,  List<String> value) async {
    return await _preference.setStringList(key, value);
  }

  remove(key) {
    return _preference.remove(key);
  }

  clear() {
    return _preference.clear();
  }
}
