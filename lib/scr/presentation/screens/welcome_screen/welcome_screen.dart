import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_frontend/scr/core/utils/app_route/app_router.gr.dart';
import 'package:e_commerce_frontend/scr/presentation/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_frontend/scr/core/utils/values/colors.dart';

@RoutePage()
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/welcome_0.png', fit: BoxFit.cover),
          Container(
            color: Colors.black.withOpacity(0.35), // Overlay
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Welcome to GemStore!",
                    style: TextStyle(
                      color: ColorLight.background,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "The home for a fashionista",
                    style: TextStyle(
                      color: ColorLight.background2,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context.router.replaceAll([const HomeRoute()]);
                      },
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(color: ColorLight.buttonText),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        foregroundColor: ColorLight.buttonText,
                        backgroundColor: ColorLight.chipText,
                      ),
                      child: const Text(
                        "Get Started",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
