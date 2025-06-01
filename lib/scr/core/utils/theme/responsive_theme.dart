import 'package:flutter/material.dart';
import 'package:e_commerce_frontend/scr/core/utils/values/colors.dart';
import 'package:e_commerce_frontend/scr/core/utils/helpers/responsive_ui_helper/responsive_ui_config.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_frontend/scr/core/utils/theme/theme_provider.dart';

/// Extension methods to provide responsive typography through the Theme.
extension ResponsiveTypography on ThemeData {
  // Heading style (large titles)
  TextStyle headingStyle(BuildContext context) {
    final responsive = ResponsiveUiConfig(context);
    final isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    return TextStyle(
      fontSize: responsive.setWidth(20),
      fontWeight: FontWeight.bold,
      color: isDarkMode ? ColorDark.titleText : ColorLight.titleText,
    );
  }

  // Subheading style (section titles)
  TextStyle subheadingStyle(BuildContext context) {
    final responsive = ResponsiveUiConfig(context);
    final isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    return TextStyle(
      fontSize: responsive.setWidth(18),
      fontWeight: FontWeight.w600,
      color: isDarkMode ? ColorDark.titleText : ColorLight.titleText,
    );
  }

  // Body text style (regular text)
  TextStyle bodyStyle(BuildContext context) {
    final responsive = ResponsiveUiConfig(context);
    final isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    return TextStyle(
      fontSize: responsive.setWidth(14),
      fontWeight: FontWeight.normal,
      color: isDarkMode ? ColorDark.subtitleText : ColorLight.subtitleText,
    );
  }

  // Caption style (small text)
  TextStyle captionStyle(BuildContext context) {
    final responsive = ResponsiveUiConfig(context);
    final isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    return TextStyle(
      fontSize: responsive.setWidth(12),
      fontWeight: FontWeight.normal,
      color: isDarkMode ? ColorDark.subtitleText : ColorLight.subtitleText,
    );
  }

  // Button text style
  TextStyle buttonTextStyle(BuildContext context) {
    final responsive = ResponsiveUiConfig(context);
    final isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    return TextStyle(
      fontSize: responsive.setWidth(16),
      fontWeight: FontWeight.w600,
      color: isDarkMode ? ColorDark.buttonText : ColorLight.buttonText,
    );
  }

  // Product title style
  TextStyle productTitleStyle(BuildContext context) {
    final responsive = ResponsiveUiConfig(context);
    final isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    return TextStyle(
      fontSize: responsive.setWidth(16),
      fontWeight: FontWeight.w600,
      color:
          isDarkMode ? ColorDark.productTitleText : ColorLight.productTitleText,
    );
  }

  // Product price style
  TextStyle productPriceStyle(BuildContext context) {
    final responsive = ResponsiveUiConfig(context);
    final isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    return TextStyle(
      fontSize: responsive.setWidth(16),
      fontWeight: FontWeight.bold,
      color:
          isDarkMode ? ColorDark.productPriceText : ColorLight.productPriceText,
    );
  }
}
