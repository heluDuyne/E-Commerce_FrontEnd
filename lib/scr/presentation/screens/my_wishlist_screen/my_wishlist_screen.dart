import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_frontend/scr/presentation/widgets/sidebar.dart';
import 'package:e_commerce_frontend/scr/presentation/widgets/bottom_nav_bar.dart';
import 'package:e_commerce_frontend/scr/presentation/widgets/product_item.dart';
import 'package:e_commerce_frontend/scr/core/utils/values/colors.dart';

@RoutePage()
class MyWishlistScreen extends StatelessWidget {
  const MyWishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor:
            isDarkMode ? ColorDark.background : ColorLight.background,
        elevation: 0,
        title: Text(
          'My Wishlist',
          style: TextStyle(
            color: isDarkMode ? ColorDark.titleText : ColorLight.titleText,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      drawer: const SidebarWidget(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 600,
            ), // Constrain grid width
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.75,
              ),
              itemCount: 10, // Example item count
              itemBuilder: (context, index) {
                return ProductItem(
                  imageUrl:
                      'https://via.placeholder.com/150', // Example image URL
                  title: 'Product $index',
                  price: 29.99 + index, // Example price
                  salePrice: 19.99 + index, // Example sale price
                  onTap: () {
                    // Handle product tap
                  },
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3,
        onTap: (index) {
          // Handle navigation
        },
      ),
    );
  }
}
