import 'package:flutter/material.dart';

class ResponsiveUiConfig {
  late MediaQueryData _mediaQueryData;
  late double _screenWidth;
  late double _screenHeight;

  ResponsiveUiConfig(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    _screenWidth = _mediaQueryData.size.width;
    _screenHeight = _mediaQueryData.size.height;
  }

  double setWidth(double value) => _screenWidth * (value / 375);
  double setHeight(double value) => _screenHeight * (value / 812);
}