import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_frontend/scr/core/utils/theme/theme_provider.dart';
import 'package:e_commerce_frontend/scr/core/utils/values/colors.dart';
import 'package:e_commerce_frontend/scr/core/utils/helpers/responsive_ui_helper/responsive_ui_config.dart';
import 'package:e_commerce_frontend/scr/presentation/widgets/product_item.dart';
import 'package:e_commerce_frontend/scr/presentation/widgets/search_bar_with_filter.dart';
import 'package:e_commerce_frontend/scr/presentation/widgets/bottom_nav_bar.dart';
import 'package:e_commerce_frontend/scr/core/utils/app_route/app_router.gr.dart';
import 'package:e_commerce_frontend/scr/presentation/screens/product_full_screen/product_full_screen.dart';

@RoutePage()
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<String> recentSearches = ['Sunglasses', 'Sweater', 'Hoodie'];

  final List<Map<String, dynamic>> popularProducts = [
    {
      'title': 'Lihua Tunic White',
      'price': 53.00,
      'image': 'assets/images/popular1.png',
    },
    {
      'title': 'Skirt Dress',
      'price': 34.00,
      'image': 'assets/images/popular2.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final responsive = ResponsiveUiConfig(context);

    return Scaffold(
      backgroundColor:
          isDarkMode ? ColorDark.background : ColorLight.background,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor:
            isDarkMode ? ColorDark.background : ColorLight.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDarkMode ? ColorDark.iconPrimary : ColorLight.iconPrimary,
          ),
          onPressed: () => context.router.pop(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(responsive.setWidth(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            const SearchBarWithFilter(),

            SizedBox(height: responsive.setHeight(24)),

            // Recent Searches
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent Searches",
                  style: TextStyle(
                    color:
                        isDarkMode ? ColorDark.titleText : ColorLight.titleText,
                    fontWeight: FontWeight.w500,
                    fontSize: responsive.setWidth(14),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () {
                    setState(() => recentSearches.clear());
                  },
                ),
              ],
            ),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  recentSearches
                      .map(
                        (item) => Chip(
                          label: Text(item),
                          deleteIcon: const Icon(Icons.close, size: 16),
                          onDeleted: () {
                            setState(() {
                              recentSearches.remove(item);
                            });
                          },
                          backgroundColor:
                              isDarkMode
                                  ? ColorDark.chipBackground
                                  : ColorLight.chipBackground,
                          labelStyle: TextStyle(
                            color:
                                isDarkMode
                                    ? ColorDark.chipText
                                    : ColorLight.chipText,
                          ),
                        ),
                      )
                      .toList(),
            ),

            SizedBox(height: responsive.setHeight(32)),

            // Popular this week
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Popular this week",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: responsive.setWidth(18),
                    color:
                        isDarkMode ? ColorDark.titleText : ColorLight.titleText,
                  ),
                ),
                Text(
                  "Show all",
                  style: TextStyle(
                    color:
                        isDarkMode
                            ? ColorDark.sectionActionText
                            : ColorLight.sectionActionText,
                    fontSize: responsive.setWidth(14),
                  ),
                ),
              ],
            ),

            SizedBox(height: responsive.setHeight(16)),

            // Use SizedBox instead of Expanded for horizontal ListView
            SizedBox(
              height: responsive.setHeight(
                220,
              ), // Adjust as needed for your design
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: popularProducts.length,
                separatorBuilder:
                    (_, __) => SizedBox(width: responsive.setWidth(16)),
                itemBuilder: (context, index) {
                  final product = popularProducts[index];
                  return ProductItem(
                    imageUrl: product['image'] as String,
                    title: product['title'] as String,
                    price: product['price'] as double,
                    salePrice: product['salePrice'] as double,
                    isFavorite: false,
                    onTap: () {
                      context.router.push(const ProductFullRoute());
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          // Navigation handled in BottomNavBar
        },
      ),
    );
  }
}
