import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_frontend/scr/core/utils/app_route/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_frontend/scr/core/utils/theme/theme_provider.dart';
import 'package:e_commerce_frontend/scr/core/utils/values/colors.dart';
import 'package:e_commerce_frontend/scr/core/utils/helpers/responsive_ui_helper/responsive_ui_config.dart';
import 'package:e_commerce_frontend/scr/presentation/widgets/category_button.dart';
import 'package:e_commerce_frontend/scr/presentation/widgets/product_item.dart';
import 'package:e_commerce_frontend/scr/presentation/widgets/sidebar.dart';
import 'package:e_commerce_frontend/scr/presentation/widgets/bottom_nav_bar.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final responsive = ResponsiveUiConfig(context);
    final scaffoldKey = GlobalKey<ScaffoldState>();

    final List<Map<String, dynamic>> categories = [
      {'label': 'Women', 'icon': Icons.female},
      {'label': 'Men', 'icon': Icons.male},
      {'label': 'Accessories', 'icon': Icons.watch},
      {'label': 'Beauty', 'icon': Icons.face},
    ];

    // Products
    final List<Map<String, dynamic>> products = [
      {
        'title': 'Turtleneck Sweater',
        'price': 39.99,
        'image': 'assets/images/product1.png',
      },
      {
        'title': 'Long Sleeve Dress',
        'price': 45.00,
        'image': 'assets/images/product2.png',
      },
      {
        'title': 'Sportwear Set',
        'price': 80.00,
        'image': 'assets/images/product3.png',
      },
    ];
    final List<Map<String, dynamic>> recommendedProducts = [
      {
        'title': 'White fashion hoodie',
        'price': 29.00,
        'image': 'assets/images/recommended1.png',
      },
      {
        'title': 'Cotton t-shirt',
        'price': 30.00,
        'image': 'assets/images/recommended2.png',
      },
    ];

    final List<Map<String, dynamic>> topCollections = [
      {
        'title': 'FOR SLIM & BEAUTY',
        'label': 'Sale up to 40%',
        'image': 'assets/images/top1.png',
      },
      {
        'title': 'Most sexy & fabulous design',
        'label': 'Summer Collection 2021',
        'image': 'assets/images/top2.png',
      },
      {
        'title': 'The Office Life',
        'label': 'T-Shirts',
        'image': 'assets/images/top3.png',
      },
      {
        'title': 'Elegant Design',
        'label': 'Dresses',
        'image': 'assets/images/top4.png',
      },
    ];
    return Scaffold(
      key: scaffoldKey,
      backgroundColor:
          isDarkMode ? ColorDark.background : ColorLight.background,
      drawer: const SidebarWidget(),
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor:
            isDarkMode ? ColorDark.background : ColorLight.background,
        elevation: 0,
        title: Text(
          'Gemstore',
          style: TextStyle(
            color: isDarkMode ? ColorDark.titleText : ColorLight.titleText,
            fontSize: responsive.setWidth(18),
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: isDarkMode ? ColorDark.iconPrimary : ColorLight.iconPrimary,
          ),
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_none,
              color:
                  isDarkMode ? ColorDark.iconPrimary : ColorLight.iconPrimary,
            ),
            onPressed: () {
              print("Notification clicked");
              context.router.push(const NotificationRoute());
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          // handle bottom nav tap
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(responsive.setWidth(16)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Categories
              SizedBox(
                width: double.infinity,
                height: responsive.setHeight(90),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder:
                      (_, __) => SizedBox(width: responsive.setWidth(20)),
                  itemBuilder: (context, index) {
                    final cat = categories[index];
                    return CategoryButton(
                      icon: cat['icon'] as IconData,
                      label: cat['label']!,
                      isSelected: index == 0,
                      onTap: () {},
                    );
                  },
                ),
              ),

              SizedBox(height: responsive.setHeight(16)),

              // Banner
              /*
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/autumn_collection_banner.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: responsive.setHeight(200),
                    ),
                    Positioned(
                      right: 16,
                      top: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Autumn\nCollection\n2021',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: responsive.setWidth(20),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              */
              SizedBox(height: responsive.setHeight(24)),

              _buildSectionHeader(
                'Feature Products',
                responsive,
                isDarkMode,
                onTap: () {},
              ),
              SizedBox(height: responsive.setHeight(12)),

              SizedBox(
                height: responsive.setHeight(240),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  separatorBuilder:
                      (_, __) => SizedBox(width: responsive.setWidth(16)),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductItem(
                      imageUrl: product['image']!,
                      title: product['title']!,
                      price: product['price'] as double,
                      isFavorite: false,
                      onTap: () {
                        context.router.push(const ProductFullRoute());
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: responsive.setHeight(24)),

              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/hangout_party_banner.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: responsive.setHeight(180),
                    ),
                    Positioned(
                      left: 16,
                      top: 24,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '| NEW COLLECTION',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: responsive.setWidth(12),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'HANG OUT\n& PARTY',
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: responsive.setWidth(18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Recommended Section
              _buildSectionHeader(
                'Recommended',
                responsive,
                isDarkMode,
                onTap: () {},
              ),
              SizedBox(height: responsive.setHeight(12)),

              SizedBox(
                height: responsive.setHeight(240),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: recommendedProducts.length,
                  separatorBuilder:
                      (_, __) => SizedBox(width: responsive.setWidth(16)),
                  itemBuilder: (context, index) {
                    final product = recommendedProducts[index];
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
              SizedBox(height: responsive.setHeight(24)),

              // Top Collection
              _buildSectionHeader(
                'Top Collection',
                responsive,
                isDarkMode,
                onTap: () {},
              ),
              SizedBox(height: responsive.setHeight(12)),

              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: responsive.setWidth(12),
                mainAxisSpacing: responsive.setHeight(12),
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 0.75,
                children:
                    topCollections.map((collection) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          color: Colors.grey.shade200,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Image.asset(
                                  collection['image'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                bottom: 12,
                                left: 12,
                                right: 12,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (collection['label'] != null)
                                      Text(
                                        collection['label'],
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: responsive.setWidth(12),
                                        ),
                                      ),
                                    Text(
                                      collection['title'],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: responsive.setWidth(14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    String title,
    ResponsiveUiConfig responsive,
    bool isDarkMode, {
    required VoidCallback onTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: responsive.setWidth(18),
            color: isDarkMode ? ColorDark.titleText : ColorLight.titleText,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            "Show all",
            style: TextStyle(
              color:
                  isDarkMode
                      ? ColorDark.sectionActionText
                      : ColorLight.sectionActionText,
              fontSize: responsive.setWidth(14),
            ),
          ),
        ),
      ],
    );
  }
}
