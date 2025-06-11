import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_frontend/scr/core/utils/values/colors.dart';
import 'package:e_commerce_frontend/scr/core/utils/helpers/responsive_ui_helper/responsive_ui_config.dart';
import 'package:e_commerce_frontend/scr/presentation/widgets/product_item.dart';
import 'package:e_commerce_frontend/scr/core/utils/theme/theme_provider.dart';

@RoutePage()
class ProductFoundScreen extends StatefulWidget {
  const ProductFoundScreen({Key? key}) : super(key: key);

  @override
  State<ProductFoundScreen> createState() => _ProductFoundScreenState();
}

class _ProductFoundScreenState extends State<ProductFoundScreen> {
  bool _reviewsExpanded = false;
  bool _similarExpanded = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final responsive = ResponsiveUiConfig(context);
    final products = [
      {
        'name': 'Linen Dress',
        'image':
            'https://images.pexels.com/photos/532220/pexels-photo-532220.jpeg',
        'price': 52.00,
        'oldPrice': 90.00,
        'rating': 4.6,
        'reviews': 64,
        'isFavorite': true,
      },
      {
        'name': 'Fitted Waist Dress',
        'image':
            'https://images.pexels.com/photos/1488463/pexels-photo-1488463.jpeg',
        'price': 47.99,
        'oldPrice': 82.00,
        'rating': 4.5,
        'reviews': 53,
        'isFavorite': true,
      },
      {
        'name': 'Maxi Dress',
        'image':
            'https://images.pexels.com/photos/1488461/pexels-photo-1488461.jpeg',
        'price': 68.00,
        'oldPrice': null,
        'rating': 4.8,
        'reviews': 46,
        'isFavorite': false,
      },
      {
        'name': 'Front Tie Mini Dress',
        'image':
            'https://images.pexels.com/photos/1488462/pexels-photo-1488462.jpeg',
        'price': 59.00,
        'oldPrice': null,
        'rating': 4.7,
        'reviews': 38,
        'isFavorite': true,
      },
      {
        'name': 'Summer Floral Dress',
        'image':
            'https://images.pexels.com/photos/1488470/pexels-photo-1488470.jpeg',
        'price': 54.00,
        'oldPrice': 75.00,
        'rating': 4.4,
        'reviews': 29,
        'isFavorite': false,
      },
      {
        'name': 'Casual Shirt Dress',
        'image':
            'https://images.pexels.com/photos/1488471/pexels-photo-1488471.jpeg',
        'price': 49.00,
        'oldPrice': 65.00,
        'rating': 4.3,
        'reviews': 22,
        'isFavorite': true,
      },
      {
        'name': 'Classic Black Dress',
        'image':
            'https://images.pexels.com/photos/1488472/pexels-photo-1488472.jpeg',
        'price': 72.00,
        'oldPrice': 99.00,
        'rating': 4.9,
        'reviews': 51,
        'isFavorite': false,
      },
      {
        'name': 'Boho Midi Dress',
        'image':
            'https://images.pexels.com/photos/1488473/pexels-photo-1488473.jpeg',
        'price': 61.00,
        'oldPrice': 80.00,
        'rating': 4.2,
        'reviews': 18,
        'isFavorite': true,
      },
    ];

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
        title: Text(
          'Dresses',
          style: TextStyle(
            color: isDarkMode ? ColorDark.titleText : ColorLight.titleText,
            fontWeight: FontWeight.bold,
            fontSize: responsive.setWidth(18),
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: responsive.setWidth(16)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: responsive.setHeight(8)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Found',
                        style: TextStyle(
                          color:
                              isDarkMode
                                  ? ColorDark.titleText
                                  : ColorLight.titleText,
                          fontWeight: FontWeight.bold,
                          fontSize: responsive.setWidth(20),
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        '152 Results',
                        style: TextStyle(
                          color:
                              isDarkMode
                                  ? ColorDark.subtitleText
                                  : ColorLight.subtitleText,
                          fontSize: responsive.setWidth(15),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 4,
                    ), // Align filter button with first text line
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isDarkMode
                                ? ColorDark.background2
                                : ColorLight.background2,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                          side: BorderSide(
                            color:
                                isDarkMode
                                    ? ColorDark.iconSecondary
                                    : ColorLight.iconSecondary,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 0,
                        ),
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            'Filter',
                            style: TextStyle(
                              color:
                                  isDarkMode
                                      ? ColorDark.titleText
                                      : ColorLight.titleText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color:
                                isDarkMode
                                    ? ColorDark.iconPrimary
                                    : ColorLight.iconPrimary,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(bottom: 24),
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Align(
                    alignment: Alignment.topCenter,
                    child: ProductItem(
                      imageUrl: product['image'] as String,
                      title: product['name'] as String,
                      price: product['price'] as double,
                      salePrice: product['salePrice'] as double,
                      isFavorite: product['isFavorite'] as bool,
                      onTap: () {},
                    ),
                  );
                },
              ),
              // Collapsible Reviews Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Reviews',
                    style: TextStyle(
                      color:
                          isDarkMode
                              ? ColorDark.titleText
                              : ColorLight.titleText,
                      fontWeight: FontWeight.bold,
                      fontSize: responsive.setWidth(18),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _reviewsExpanded ? Icons.expand_less : Icons.expand_more,
                      color:
                          isDarkMode
                              ? ColorDark.iconPrimary
                              : ColorLight.iconPrimary,
                    ),
                    onPressed:
                        () => setState(
                          () => _reviewsExpanded = !_reviewsExpanded,
                        ),
                  ),
                ],
              ),
              AnimatedSize(
                duration: Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                child: Visibility(
                  visible: _reviewsExpanded,
                  maintainState: true,
                  maintainAnimation: true,
                  maintainSize: true,
                  child: Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Example review content
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundImage: NetworkImage(
                                'https://randomuser.me/api/portraits/women/44.jpg',
                              ),
                            ),
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Jane Doe',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color:
                                        isDarkMode
                                            ? ColorDark.titleText
                                            : ColorLight.titleText,
                                  ),
                                ),
                                Text(
                                  'Great quality and fit!',
                                  style: TextStyle(
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
                        SizedBox(height: 8),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundImage: NetworkImage(
                                'https://randomuser.me/api/portraits/men/32.jpg',
                              ),
                            ),
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'John Smith',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color:
                                        isDarkMode
                                            ? ColorDark.titleText
                                            : ColorLight.titleText,
                                  ),
                                ),
                                Text(
                                  'Loved the color and material.',
                                  style: TextStyle(
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
                      ],
                    ),
                  ),
                ),
              ),
              // Collapsible Similar Products Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Similar Products',
                    style: TextStyle(
                      color:
                          isDarkMode
                              ? ColorDark.titleText
                              : ColorLight.titleText,
                      fontWeight: FontWeight.bold,
                      fontSize: responsive.setWidth(18),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _similarExpanded ? Icons.expand_less : Icons.expand_more,
                      color:
                          isDarkMode
                              ? ColorDark.iconPrimary
                              : ColorLight.iconPrimary,
                    ),
                    onPressed:
                        () => setState(
                          () => _similarExpanded = !_similarExpanded,
                        ),
                  ),
                ],
              ),
              AnimatedSize(
                duration: Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                child: Visibility(
                  visible: _similarExpanded,
                  maintainState: true,
                  maintainAnimation: true,
                  maintainSize: true,
                  child: Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 12),
                    child: SizedBox(
                      height: 140,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        separatorBuilder: (context, i) => SizedBox(width: 12),
                        itemBuilder: (context, i) {
                          final similar = products[i];
                          return Container(
                            width: 110,
                            child: ProductItem(
                              imageUrl: similar['image'] as String,
                              title: similar['name'] as String,
                              price: similar['price'] as double,
                              salePrice: similar['salePrice'] as double,
                              isFavorite: similar['isFavorite'] as bool,
                              onTap: () {},
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
