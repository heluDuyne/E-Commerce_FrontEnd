import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_frontend/scr/core/utils/theme/theme_provider.dart';
import 'package:e_commerce_frontend/scr/core/utils/helpers/responsive_ui_helper/responsive_ui_config.dart';
import 'package:e_commerce_frontend/scr/core/utils/values/colors.dart';
import 'package:e_commerce_frontend/scr/presentation/widgets/product_item.dart';

@RoutePage()
class CollectionScreen extends StatelessWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUiConfig(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    final List<Map<String, dynamic>> products = [
      {
        'title': 'Knitted Vest Dress',
        'price': 85.00,
        'rating': 50,
        'image': 'assets/images/autumn1.png',
      },
      {
        'title': 'Knitted Dress',
        'price': 64.00,
        'rating': 39,
        'image': 'assets/images/autumn2.png',
      },
      {
        'title': 'Ribbed Top',
        'price': 25.00,
        'rating': 37,
        'image': 'assets/images/autumn3.png',
      },
      {
        'title': 'Crop top beige',
        'price': 24.00,
        'rating': 39,
        'image': 'assets/images/autumn4.png',
      },
    ];

    return Scaffold(
      backgroundColor: isDarkMode ? ColorDark.background : ColorLight.background,
      body: Column(
        children: [
          // Banner with title & back
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                child: Image.asset(
                  'assets/images/autumn_collection_banner.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: responsive.setHeight(240),
                ),
              ),
              Positioned(
                top: responsive.setHeight(48),
                left: responsive.setWidth(16),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => context.router.pop(),
                    color: Colors.black,
                  ),
                ),
              ),
              Positioned(
                top: responsive.setHeight(48),
                right: responsive.setWidth(16),
                child: Text(
                  'Autumn\nCollection\n2021',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: responsive.setWidth(20),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Product Grid
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: responsive.setWidth(16)),
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: responsive.setWidth(16),
                  mainAxisSpacing: responsive.setHeight(16),
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductItem(
                    imageUrl: product['image'] as String,
                    title: product['title'] as String,
                    price: product['price'] as double,
                    isFavorite: false,
                    onTap: () {},
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}