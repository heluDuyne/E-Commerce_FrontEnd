<<<<<<< HEAD
import 'package:e_commerce_frontend/scr/core/utils/helpers/shared_pref_management_helper/shared_pref_management_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeProvider extends ChangeNotifier {
  final SharedPrefManagementHelper sharedPreferences;
  ThemeProvider({required this.sharedPreferences});
=======
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
>>>>>>> 995a847 ( imp. Widgets)
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleTheme() async {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    _updateSystemUIOverlayStyle();
    notifyListeners();

    // Save theme preference
<<<<<<< HEAD
    await sharedPreferences.saveKeyBool('isDarkMode', isDarkMode);
=======
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
>>>>>>> 995a847 ( imp. Widgets)
  }

  void setDarkMode() async {
    _themeMode = ThemeMode.dark;
    _updateSystemUIOverlayStyle();
    notifyListeners();

    // Save theme preference
<<<<<<< HEAD
    await sharedPreferences.saveKeyBool('isDarkMode', true);
=======
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', true);
>>>>>>> 995a847 ( imp. Widgets)
  }

  void setLightMode() async {
    _themeMode = ThemeMode.light;
    _updateSystemUIOverlayStyle();
    notifyListeners();

    // Save theme preference
<<<<<<< HEAD
    await sharedPreferences.saveKeyBool('isDarkMode', false);
=======
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', false);
>>>>>>> 995a847 ( imp. Widgets)
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
