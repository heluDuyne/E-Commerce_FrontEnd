import 'package:e_commerce_frontend/scr/core/utils/helpers/shared_pref_management_helper/shared_pref_management_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeProvider extends ChangeNotifier {
  final SharedPrefManagementHelper sharedPreferences;
  ThemeProvider({required this.sharedPreferences});
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleTheme() async {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    _updateSystemUIOverlayStyle();
    notifyListeners();

    // Save theme preference
    await sharedPreferences.saveKeyBool('isDarkMode', isDarkMode);
  }

  void setDarkMode() async {
    _themeMode = ThemeMode.dark;
    _updateSystemUIOverlayStyle();
    notifyListeners();

    // Save theme preference
    await sharedPreferences.saveKeyBool('isDarkMode', true);
  }

  void setLightMode() async {
    _themeMode = ThemeMode.light;
    _updateSystemUIOverlayStyle();
    notifyListeners();

    // Save theme preference
    await sharedPreferences.saveKeyBool('isDarkMode', false);
  }

  void _updateSystemUIOverlayStyle() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark,
        systemNavigationBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark,
        systemNavigationBarColor:
            isDarkMode ? const Color(0xFF121212) : Colors.white,
      ),
    );
  }
}
