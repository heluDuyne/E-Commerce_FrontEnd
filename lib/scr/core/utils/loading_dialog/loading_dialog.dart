import 'package:e_commerce_frontend/scr/core/utils/values/colors.dart';
import 'package:flutter/material.dart';

void showLoadingDialog({
  required BuildContext context,
  bool barrierDismissible = false,
  bool isDarkMode = false,
}) {
  showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) {
      return Center(
        child: Container(
          height: 90,
          width: 90,
          decoration: BoxDecoration(
            color: isDarkMode ? ColorDark.background2 : ColorLight.background2,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: CircularProgressIndicator(
              color: isDarkMode ? Colors.white54 : Colors.black45,
              strokeWidth: 2,
            ),
          ),
        ),
      );
    },
  );
}
