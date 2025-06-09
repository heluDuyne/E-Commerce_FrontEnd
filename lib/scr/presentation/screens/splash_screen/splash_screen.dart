import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_frontend/scr/core/utils/app_route/app_router.gr.dart';
import 'package:e_commerce_frontend/scr/core/utils/constants/images.dart';
import 'package:e_commerce_frontend/scr/core/utils/helpers/responsive_ui_helper/responsive_ui_config.dart';
import 'package:e_commerce_frontend/scr/core/utils/theme/theme_provider.dart';
import 'package:e_commerce_frontend/scr/core/utils/toast/flutter_toast.dart';
import 'package:e_commerce_frontend/scr/presentation/bloc/authentication_watcher/authentication_watcher_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<AuthenticationWatcherBloc>().add(const AuthCheckRequest());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final responsive = ResponsiveUiConfig(context);
    return BlocListener<AuthenticationWatcherBloc, AuthenticationWatcherState>(
      listener: (context, state) {
        switch (state) {
          case Authenticated():
            showToast(msg: state.message, textColor: Colors.green);
            context.router.replace(const HomeRoute());
          case Unauthenticated():
            showToast(msg: state.message, textColor: Colors.red);
            context.router.replace(LoginRoute());
          case AuthenticationWatcherError():
            showToast(msg: state.message, textColor: Colors.red);
            context.router.replace(LoginRoute());
          case IsNotVerified():
            showToast(msg: state.message, textColor: Colors.red);
            context.router.replace(VerificationCodeRoute(email: state.email));
          default:
            // Do nothing for initial and authenticating states
            break;
        }
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.black : Colors.white,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  isDarkMode ? Images.elanzaIconDark : Images.elanzaIconLight,
                  width: responsive.setWidth(150),
                  height: responsive.setHeight(150),
                ),
                const SizedBox(height: 40),
                CircularProgressIndicator(
                  strokeWidth: 2,
                  color: isDarkMode ? Colors.white : Colors.black45,
                  backgroundColor: isDarkMode ? Colors.white70 : Colors.black12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
