import 'package:flutter/material.dart';
import 'package:e_commerce_frontend/scr/core/utils/values/colors.dart';
import 'package:e_commerce_frontend/scr/core/utils/helpers/responsive_ui_helper/responsive_ui_config.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_frontend/scr/core/utils/theme/theme_provider.dart';

class CategoryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryButton({
    Key? key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final responsive = ResponsiveUiConfig(context);

    // Define colors based on selection state and theme
    final bgColor =
        isSelected
            ? (isDarkMode ? ColorDark.categorySelectedBg : Color(0xFF2A2A2A))
            : (isDarkMode ? ColorDark.background2 : Color(0xFFF5F5F5));

    final iconColor =
        isSelected
            ? (isDarkMode ? ColorDark.categorySelectedIcon : Colors.white)
            : (isDarkMode ? ColorDark.categoryUnselectedIcon : Colors.black54);

    final labelColor =
        isSelected
            ? (isDarkMode ? ColorDark.titleText : Colors.black)
            : (isDarkMode ? ColorDark.subtitleText : Colors.black54);

    // Calculate responsive dimensions
    final containerSize = responsive.setWidth(58);
    final iconSize = responsive.setWidth(22);
    final fontSize = responsive.setWidth(12);
    final spacing = responsive.setHeight(6);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon container
          Container(
            width: containerSize,
            height: containerSize,
            decoration: BoxDecoration(
              color: isSelected ? Colors.black : Colors.transparent,
              shape: BoxShape.circle,
              border:
                  isSelected
                      ? Border.all(color: Colors.black, width: 1.0)
                      : null,
            ),
            child: Padding(
              padding: EdgeInsets.all(isSelected ? 1.0 : 0.0),
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  shape: BoxShape.circle,
                  border:
                      isSelected
                          ? Border.all(color: Colors.white, width: 1.0)
                          : null,
                ),
                child: Padding(
                  padding: EdgeInsets.all(isSelected ? 1.0 : 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: bgColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(icon, color: iconColor, size: iconSize),
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: spacing),

          // Label text with responsive font size
          Text(
            label,
            style: TextStyle(
              color: labelColor,
              fontSize: fontSize,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
