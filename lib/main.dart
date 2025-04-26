import 'package:e_commerce_frontend/scr/core/utils/app_route/app_router.dart';
import 'package:e_commerce_frontend/scr/core/utils/theme/app_theme.dart';
import 'package:e_commerce_frontend/scr/core/utils/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import './injector.dart' as di;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  // Load saved theme preference
  final prefs = await SharedPreferences.getInstance();
  final isDarkMode = prefs.getBool('isDarkMode') ?? false;

  runApp(MyApp(isDarkMode: isDarkMode));
}

class MyApp extends StatelessWidget {
  final bool isDarkMode;

  const MyApp({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final router = AppRouter();

    return ChangeNotifierProvider(
      create: (_) {
        final provider = ThemeProvider();
        if (isDarkMode) {
          provider.setDarkMode();
        } else {
          provider.setLightMode();
        }
        return provider;
      },
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp.router(
            routerConfig: router.config(),
            title: 'E-Commerce App',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
          );
        },
      ),
    );
  }
}
