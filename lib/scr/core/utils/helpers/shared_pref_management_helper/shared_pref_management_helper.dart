import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManagementHelper {
  SharedPrefManagementHelper(this.sharedPreferences);
  final SharedPreferences sharedPreferences;

  Future<bool> saveKey(String key, String value) async {
    return await sharedPreferences.setString(key, value);
  }

  String getKey(String key) {
    return sharedPreferences.getString(key) ?? '';
  }
}
