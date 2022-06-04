import 'package:shared_preferences/shared_preferences.dart';

enum PreferencesKeys {
  token,
  isLogin,
  favoriteMarkes,
}

class LocaleManager {
  static LocaleManager _instance;
  LocaleManager._();
  static LocaleManager get instance => _instance ??= LocaleManager._();

  SharedPreferences _preferences;
  initSharedPref() async =>
      _preferences = await SharedPreferences.getInstance();

  Future<void> sharedClear() async {
    return _preferences.clear();
  }

  Future<bool> remove(PreferencesKeys preferencesKeys) async {
    return _preferences.remove(preferencesKeys.toString());
  }

  Future<void> setStringValue(PreferencesKeys key, String value) async {
    await _preferences.setString(key.toString(), value);
  }

  Future<void> setStringListValue(
    PreferencesKeys key,
    List<String> values,
  ) async {
    await _preferences.setStringList(key.toString(), values);
  }

  String getStringValue(PreferencesKeys key) =>
      _preferences.getString(key.toString()) ?? "";

  List<String> getStringListValue(PreferencesKeys key) =>
      _preferences.getStringList(key.toString()) ?? [];

  Future<void> setBoolValue(PreferencesKeys key, bool value) async {
    await _preferences.setBool(key.toString(), value);
  }

  bool getBoolValue(PreferencesKeys key) =>
      _preferences.getBool(key.toString()) ?? false;

  Future<void> setIntValue(PreferencesKeys key, int value) async {
    await _preferences.setInt(key.toString(), value);
  }

  int getIntValue(PreferencesKeys key) =>
      _preferences.getInt(key.toString()) ?? 0;

  void logOut() {
    // clear catche
    remove(PreferencesKeys.token);
    remove(PreferencesKeys.isLogin);
  }
}
