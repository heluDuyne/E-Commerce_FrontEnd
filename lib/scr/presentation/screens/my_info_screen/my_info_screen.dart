import 'package:flutter/material.dart';
import 'package:e_commerce_frontend/scr/core/utils/values/colors.dart';
import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_frontend/scr/presentation/widgets/bottom_nav_bar.dart';

@RoutePage()
class MyInfoScreen extends StatelessWidget {
  const MyInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor:
            isDarkMode ? ColorDark.background : ColorLight.background,
        elevation: 0,
        centerTitle: false,
        title: Row(
          children: [
            CircleAvatar(
              radius: 30.0, // Increased size of the profile picture
              backgroundImage: AssetImage(
                'assets/images/profile_placeholder.png',
              ),
            ),
            const SizedBox(width: 16.0), // Adjusted spacing
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sunie Pham',
                    style: TextStyle(
                      fontSize: 20.0, // Increased font size for the name
                      fontWeight: FontWeight.bold,
                      color:
                          isDarkMode
                              ? ColorDark.titleText
                              : ColorLight.titleText,
                    ),
                  ),
                  Text(
                    'sunieux@gmail.com',
                    style: TextStyle(
                      fontSize: 14.0, // Slightly larger font size for the email
                      color:
                          isDarkMode
                              ? ColorDark.subtitleText
                              : ColorLight.subtitleText,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.settings,
                color:
                    isDarkMode ? ColorDark.iconPrimary : ColorLight.iconPrimary,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30.0,
          ), // Added spacing between user section and profile options
          // Profile Options Section
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildProfileOption(
                  context,
                  icon: Icons.location_on_outlined,
                  label: 'Address',
                  isDarkMode: isDarkMode,
                ),
                const SizedBox(height: 12.0),
                _buildProfileOption(
                  context,
                  icon: Icons.payment_outlined,
                  label: 'Payment method',
                  isDarkMode: isDarkMode,
                ),
                const SizedBox(height: 12.0),
                _buildProfileOption(
                  context,
                  icon: Icons.card_giftcard_outlined,
                  label: 'Voucher',
                  isDarkMode: isDarkMode,
                ),
                const SizedBox(height: 12.0),
                _buildProfileOption(
                  context,
                  icon: Icons.favorite_border,
                  label: 'My Wishlist',
                  isDarkMode: isDarkMode,
                ),
                const SizedBox(height: 12.0),
                _buildProfileOption(
                  context,
                  icon: Icons.star_border,
                  label: 'Rate this app',
                  isDarkMode: isDarkMode,
                ),
                const SizedBox(height: 12.0),
                _buildProfileOption(
                  context,
                  icon: Icons.logout,
                  label: 'Log out',
                  isDarkMode: isDarkMode,
                ),
              ],
            ),
          ),

          // Bottom Navigation Bar
          BottomNavBar(
            currentIndex: 3,
            onTap: (index) {
              // Handle navigation
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool isDarkMode,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black26 : Colors.grey.shade300,
            blurRadius: 6.0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: isDarkMode ? Colors.grey : Colors.black54),
          const SizedBox(width: 16.0),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: isDarkMode ? Colors.grey : Colors.black54,
          ),
        ],
      ),
    );
  }
}
