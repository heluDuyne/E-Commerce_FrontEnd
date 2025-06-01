import 'package:flutter/material.dart';
import 'package:e_commerce_frontend/scr/core/utils/values/colors.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_frontend/scr/core/utils/theme/theme_provider.dart';

class SidebarWidget extends StatefulWidget {
  const SidebarWidget({Key? key}) : super(key: key);

  @override
  State<SidebarWidget> createState() => _SidebarWidgetState();
}

class _SidebarWidgetState extends State<SidebarWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      child: Drawer(
        backgroundColor:
            isDarkMode ? ColorDark.background : ColorLight.background,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Add extra padding at the top
              const SizedBox(height: 15),

              // User Profile Header
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage('assets/images/profile.jpg'),
                      // If no image asset available, use placeholder with fixed colors
                      onBackgroundImageError: (_, __) {},
                      backgroundColor:
                          Colors
                              .grey[300], // Fixed neutral color for avatar background
                      child: const Icon(
                        Icons.person,
                        color: Colors.white, // Fixed white color for the icon
                      ),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sunie Pham',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color:
                                isDarkMode
                                    ? ColorDark.titleText
                                    : ColorLight.titleText,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'sunieux@gmail.com',
                          style: TextStyle(
                            fontSize: 14,
                            color:
                                isDarkMode
                                    ? ColorDark.subtitleText
                                    : ColorLight.subtitleText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Menu Items
              _buildMenuItem(0, Icons.home_outlined, 'Homepage', isDarkMode),
              _buildMenuItem(1, Icons.search_outlined, 'Discover', isDarkMode),
              _buildMenuItem(
                2,
                Icons.shopping_bag_outlined,
                'My Order',
                isDarkMode,
              ),
              _buildMenuItem(3, Icons.person_outline, 'My profile', isDarkMode),

              // Other Section
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 25, bottom: 10),
                child: Text(
                  'OTHER',
                  style: TextStyle(
                    fontSize: 13,
                    color: isDarkMode ? ColorDark.subtitleText : Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              _buildMenuItem(4, Icons.settings_outlined, 'Setting', isDarkMode),
              _buildMenuItem(5, Icons.email_outlined, 'Support', isDarkMode),
              _buildMenuItem(6, Icons.info_outline, 'About us', isDarkMode),

              const Spacer(),

              // Theme Toggle
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                child: Row(
                  children: [
                    _buildThemeToggle(
                      false,
                      Icons.light_mode_outlined,
                      'Light',
                      isDarkMode,
                      themeProvider,
                    ),
                    const SizedBox(width: 10),
                    _buildThemeToggle(
                      true,
                      Icons.dark_mode_outlined,
                      'Dark',
                      isDarkMode,
                      themeProvider,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    int index,
    IconData icon,
    String title,
    bool isDarkMode,
  ) {
    final bool isSelected = _selectedIndex == index;
    final selectedBgColor =
        isDarkMode ? ColorDark.categorySelectedBg : const Color(0xFFF5F6FA);
    final selectedTextColor =
        isDarkMode ? ColorDark.categorySelectedIcon : ColorLight.titleText;
    final unselectedTextColor =
        isDarkMode ? ColorDark.categoryUnselectedIcon : ColorLight.subtitleText;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: () {
            setState(() {
              _selectedIndex = index;
            });
          },
          borderRadius: BorderRadius.circular(8),
          child: Ink(
            decoration: BoxDecoration(
              color: isSelected ? selectedBgColor : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 22,
                  color: isSelected ? selectedTextColor : unselectedTextColor,
                ),
                const SizedBox(width: 15),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected ? selectedTextColor : unselectedTextColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThemeToggle(
    bool isDarkTheme,
    IconData icon,
    String label,
    bool currentIsDarkMode,
    ThemeProvider themeProvider,
  ) {
    final bool isSelected = isDarkTheme == currentIsDarkMode;

    return Expanded(
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: () {
            if (isDarkTheme) {
              themeProvider.setDarkMode();
            } else {
              themeProvider.setLightMode();
            }
          },
          borderRadius: BorderRadius.circular(8),
          child: Ink(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color:
                  isSelected
                      ? (currentIsDarkMode
                          ? ColorDark.categorySelectedBg
                          : Colors.white)
                      : (currentIsDarkMode
                          ? ColorDark.background2
                          : const Color(0xFFF5F6FA)),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color:
                    isSelected
                        ? (currentIsDarkMode
                            ? ColorDark.categorySelectedIcon
                            : Colors.grey.shade300)
                        : Colors.transparent,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 18,
                  color:
                      currentIsDarkMode ? ColorDark.titleText : Colors.black87,
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color:
                        currentIsDarkMode
                            ? ColorDark.titleText
                            : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
