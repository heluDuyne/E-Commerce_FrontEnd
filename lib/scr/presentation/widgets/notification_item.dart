import 'package:flutter/material.dart';
import 'package:e_commerce_frontend/scr/core/utils/values/colors.dart';

class NotificationItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData? icon;

  const NotificationItem({
    Key? key,
    required this.title,
    required this.subtitle,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color:
            isDarkMode
                ? ColorDark.bannerBackground
                : Colors.white, // Set white background for light mode
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          if (!isDarkMode)
            BoxShadow(
              color: ColorLight.cardShadow,
              blurRadius: 4.0,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Row(
        children: [
          if (icon != null)
            Icon(
              icon,
              color:
                  isDarkMode ? ColorDark.iconPrimary : ColorLight.iconPrimary,
              size: 24.0,
            ),
          if (icon != null) const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color:
                        isDarkMode ? ColorDark.titleText : ColorLight.titleText,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14.0,
                    color:
                        isDarkMode
                            ? ColorDark.subtitleText
                            : ColorLight.subtitleText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
