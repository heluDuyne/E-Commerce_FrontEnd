import 'package:e_commerce_frontend/scr/core/utils/constants/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenManagerHelper {
  TokenManagerHelper(this._secureStorage);
  final FlutterSecureStorage _secureStorage;

  Future<bool> saveToken(String token) async {
    try {
      await _secureStorage.write(key: ACCESS_TOKEN_KEY, value: token);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> getToken() async {
    return await _secureStorage.read(key: ACCESS_TOKEN_KEY) ?? '';
  }

  Future<bool> deleteToken() async {
    try {
      await _secureStorage.delete(key: ACCESS_TOKEN_KEY);
      return true;
    } catch (e) {
      return false;
    }
  }
}
