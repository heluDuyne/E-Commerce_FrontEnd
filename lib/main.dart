import 'package:e_commerce_frontend/scr/core/utils/app_route/app_router.dart';
import 'package:e_commerce_frontend/scr/core/utils/helpers/shared_pref_management_helper/shared_pref_management_helper.dart';
import 'package:e_commerce_frontend/scr/core/utils/theme/app_theme.dart';
import 'package:e_commerce_frontend/scr/core/utils/theme/theme_provider.dart';
import 'package:e_commerce_frontend/scr/presentation/bloc/authentication_watcher/authentication_watcher_bloc.dart';
import 'package:e_commerce_frontend/scr/presentation/bloc/generic_product/generic_product_bloc.dart';
import 'package:e_commerce_frontend/scr/presentation/bloc/user_profile_setting/user_profile_setting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './injector.dart' as di;
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  // Load saved theme preference
  final prefs = di.locator<SharedPrefManagementHelper>();
  final isDarkMode = prefs.getKeyBool('isDarkMode');

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
        final provider = ThemeProvider(sharedPreferences: di.locator<SharedPrefManagementHelper>());
        if (isDarkMode) {
          provider.setDarkMode();
        } else {
          provider.setLightMode();
        }
        return provider;
      },
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => di.locator<AuthenticationWatcherBloc>()..add(const AuthCheckRequest()),
              ),
              BlocProvider(
                create: (context) => di.locator<UserProfileSettingBloc>(),
              ),
              BlocProvider(
                create: (context) => di.locator<GenericProductBloc>()..add(const GenericProductEvent.fetchProducts()),
              )
            ],
            child: MaterialApp.router(
              routerConfig: router.config(),
              title: 'E-Commerce App',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeProvider.themeMode,
            ),
          );
        },
      ),
    );
  }
}
