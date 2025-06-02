import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManagementHelper {
  SharedPrefManagementHelper(this.sharedPreferences);
  final SharedPreferences sharedPreferences;

  Future<bool> saveKeyString(String key, String value) async {
    return await sharedPreferences.setString(key, value);
  }

  String getKeyString(String key) {
    return sharedPreferences.getString(key) ?? '';
  }

  String deleteKeyString(String key) {
    sharedPreferences.remove(key);
    return key;
  } 

  Future<bool> saveKeyBool(String key, bool value) async {
    return await sharedPreferences.setBool(key, value);
  }

  bool getKeyBool(String key) {
    return sharedPreferences.getBool(key) ?? false;
  }
}
