import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_frontend/scr/core/utils/values/colors.dart';
import 'package:e_commerce_frontend/scr/core/utils/helpers/responsive_ui_helper/responsive_ui_config.dart';
import 'package:e_commerce_frontend/scr/presentation/widgets/product_item.dart';
import 'package:e_commerce_frontend/scr/core/utils/theme/theme_provider.dart';

@RoutePage()
class ProductFullScreen extends StatefulWidget {
  const ProductFullScreen({Key? key}) : super(key: key);

  @override
  State<ProductFullScreen> createState() => _ProductFullScreenState();
}

class _ProductFullScreenState extends State<ProductFullScreen> {
  bool _reviewsExpanded = false;
  bool _similarExpanded = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final responsive = ResponsiveUiConfig(context);
    final products = [
      {
        'name': 'Sample Product',
        'image':
            'https://images.pexels.com/photos/532220/pexels-photo-532220.jpeg',
        'price': 52.00,
        'isFavorite': true,
      },
    ];
    return Scaffold(
      backgroundColor:
          isDarkMode ? ColorDark.background : ColorLight.background,
      appBar: AppBar(
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
          'Product Full Screen',
          style: TextStyle(
            color: isDarkMode ? ColorDark.titleText : ColorLight.titleText,
            fontWeight: FontWeight.bold,
            fontSize: responsive.setWidth(18),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(responsive.setWidth(16)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ...existing product details...
              // Collapsible Reviews Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Reviews',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: responsive.setWidth(18),
                      color:
                          isDarkMode
                              ? ColorDark.titleText
                              : ColorLight.titleText,
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
                      fontWeight: FontWeight.bold,
                      fontSize: responsive.setWidth(18),
                      color:
                          isDarkMode
                              ? ColorDark.titleText
                              : ColorLight.titleText,
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
                        itemCount: products.length,
                        separatorBuilder: (context, i) => SizedBox(width: 12),
                        itemBuilder: (context, i) {
                          final similar = products[i];
                          return Container(
                            width: 110,
                            child: Column(
                              children: [
                                Image.network(
                                  similar['image'] as String,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  similar['name'] as String,
                                  style: TextStyle(
                                    color:
                                        isDarkMode
                                            ? ColorDark.titleText
                                            : ColorLight.titleText,
                                  ),
                                ),
                                Text(
                                  '₫${similar['price']}',
                                  style: TextStyle(
                                    color:
                                        isDarkMode
                                            ? ColorDark.subtitleText
                                            : ColorLight.subtitleText,
                                  ),
                                ),
                              ],
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
