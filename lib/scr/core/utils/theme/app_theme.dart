import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_commerce_frontend/scr/core/utils/values/colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: ColorLight.primary,
    scaffoldBackgroundColor: ColorLight.background,

    // AppBar theme
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorLight.background,
      elevation: 0,
      iconTheme: IconThemeData(color: ColorLight.primary),
      titleTextStyle: TextStyle(
        color: ColorLight.titleText,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),

    // Card theme
    cardTheme: CardThemeData(
      color: ColorLight.background,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: ColorLight.cardShadow,
    ),

    // Button themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorLight.buttonBackground,
        foregroundColor: ColorLight.buttonText,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: ColorLight.primary),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: ColorLight.primary,
        side: const BorderSide(color: ColorLight.primary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
    ),

    // Input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      fillColor: ColorLight.inputBackground,
      filled: true,
      hintStyle: const TextStyle(color: ColorLight.inputHint),
      labelStyle: const TextStyle(color: ColorLight.inputLabel),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: ColorLight.primary),
      ),
    ),

    // Chip theme
    chipTheme: const ChipThemeData(
      backgroundColor: ColorLight.chipBackground,
      labelStyle: TextStyle(color: ColorLight.chipText),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),

    // Text theme
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      displayLarge: const TextStyle(color: ColorLight.titleText),
      displayMedium: const TextStyle(color: ColorLight.titleText),
      displaySmall: const TextStyle(color: ColorLight.titleText),
      headlineMedium: const TextStyle(color: ColorLight.titleText),
      headlineSmall: const TextStyle(color: ColorLight.titleText),
      titleLarge: const TextStyle(color: ColorLight.titleText),
      titleMedium: const TextStyle(color: ColorLight.titleText),
      titleSmall: const TextStyle(color: ColorLight.titleText),
      bodyLarge: const TextStyle(color: ColorLight.titleText),
      bodyMedium: const TextStyle(color: ColorLight.subtitleText),
      bodySmall: const TextStyle(color: ColorLight.subtitleText),
      labelLarge: const TextStyle(color: ColorLight.titleText),
    ),

    // Icon theme
    iconTheme: const IconThemeData(color: ColorLight.iconSecondary),

    // Bottom navigation bar theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: ColorLight.background,
      selectedItemColor: ColorLight.bottomNavActiveIcon,
      unselectedItemColor: ColorLight.bottomNavInactiveIcon,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: ColorDark.primary,
    scaffoldBackgroundColor: ColorDark.background,

    // AppBar theme
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorDark.background,
      elevation: 0,
      iconTheme: IconThemeData(color: ColorDark.titleText),
      titleTextStyle: TextStyle(
        color: ColorDark.titleText,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),

    // Card theme
    cardTheme: CardThemeData(
      color: ColorDark.background2,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: ColorDark.cardShadow,
    ),

    // Button themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorDark.buttonBackground,
        foregroundColor: ColorDark.buttonText,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: ColorDark.titleText),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: ColorDark.titleText,
        side: const BorderSide(color: ColorDark.titleText),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
    ),

    // Input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      fillColor: ColorDark.inputBackground,
      filled: true,
      hintStyle: const TextStyle(color: ColorDark.inputHint),
      labelStyle: const TextStyle(color: ColorDark.inputLabel),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: ColorDark.titleText),
      ),
    ),

    // Chip theme
    chipTheme: const ChipThemeData(
      backgroundColor: ColorDark.chipBackground,
      labelStyle: TextStyle(color: ColorDark.chipText),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),

    // Text theme
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      displayLarge: const TextStyle(color: ColorDark.titleText),
      displayMedium: const TextStyle(color: ColorDark.titleText),
      displaySmall: const TextStyle(color: ColorDark.titleText),
      headlineMedium: const TextStyle(color: ColorDark.titleText),
      headlineSmall: const TextStyle(color: ColorDark.titleText),
      titleLarge: const TextStyle(color: ColorDark.titleText),
      titleMedium: const TextStyle(color: ColorDark.titleText),
      titleSmall: const TextStyle(color: ColorDark.titleText),
      bodyLarge: const TextStyle(color: ColorDark.titleText),
      bodyMedium: const TextStyle(color: ColorDark.subtitleText),
      bodySmall: const TextStyle(color: ColorDark.subtitleText),
      labelLarge: const TextStyle(color: ColorDark.titleText),
    ),

    // Icon theme
    iconTheme: const IconThemeData(color: ColorDark.iconSecondary),

    // Bottom navigation bar theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: ColorDark.background,
      selectedItemColor: ColorDark.bottomNavActiveIcon,
      unselectedItemColor: ColorDark.bottomNavInactiveIcon,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    ),
  );
}
