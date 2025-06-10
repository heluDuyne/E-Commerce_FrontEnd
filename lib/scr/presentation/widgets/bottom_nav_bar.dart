import 'package:flutter/material.dart';
import 'package:e_commerce_frontend/scr/core/utils/values/colors.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_frontend/scr/core/utils/theme/theme_provider.dart';
import 'package:e_commerce_frontend/scr/core/utils/helpers/responsive_ui_helper/responsive_ui_config.dart';
import 'package:e_commerce_frontend/scr/core/utils/app_route/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({Key? key, this.currentIndex = 0, required this.onTap})
    : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final responsive = ResponsiveUiConfig(context);

    // Get theme colors
    final backgroundColor =
        isDarkMode ? ColorDark.background : ColorLight.background;
    final selectedColor =
        isDarkMode
            ? ColorDark.bottomNavActiveIcon
            : ColorLight.bottomNavActiveIcon;
    final unselectedColor =
        isDarkMode
            ? ColorDark.bottomNavInactiveIcon
            : ColorLight.bottomNavInactiveIcon;
    final borderColor =
        isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300;

    // Calculate responsive dimensions
    final iconSize = responsive.setWidth(26);
    final cornerRadius = responsive.setWidth(20);
    final verticalPadding = responsive.setHeight(6);

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(cornerRadius),
          topRight: Radius.circular(cornerRadius),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, -5),
          ),
        ],
        border: Border(top: BorderSide(color: borderColor, width: 1.0)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(cornerRadius),
          topRight: Radius.circular(cornerRadius),
        ),
        child: BottomNavigationBar(
          currentIndex: widget.currentIndex,
          onTap: (index) {
            if (index == 0) {
              context.router.push(const HomeRoute());
            } else if (index == 1) {
              context.router.push(const DiscoverRoute());
            } else if (index == 2) {
              context.router.push(const MyOrderRoute());
            } else if (index == 3) {
              context.router.push(const MyInfoRoute());
            }
          },
          elevation: 0,
          backgroundColor: backgroundColor,
          selectedItemColor: selectedColor,
          unselectedItemColor: unselectedColor,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          iconSize: iconSize,
          items: [
            _buildNavItem(Icons.home_outlined, Icons.home, verticalPadding),
            _buildNavItem(Icons.search_outlined, Icons.search, verticalPadding),
            _buildNavItem(
              Icons.shopping_bag_outlined,
              Icons.shopping_bag,
              verticalPadding,
            ),
            _buildNavItem(Icons.person_outline, Icons.person, verticalPadding),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
    IconData iconOutlined,
    IconData iconFilled,
    double verticalPadding,
  ) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.symmetric(vertical: verticalPadding),
        child: Icon(iconOutlined),
      ),
      activeIcon: Padding(
        padding: EdgeInsets.symmetric(vertical: verticalPadding),
        child: Icon(iconFilled),
      ),
      label: '',
    );
  }
}
