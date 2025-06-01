import 'package:flutter/material.dart';
import 'package:e_commerce_frontend/scr/core/utils/values/colors.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_frontend/scr/core/utils/theme/theme_provider.dart';
import 'package:e_commerce_frontend/scr/core/utils/helpers/responsive_ui_helper/responsive_ui_config.dart';

class ProductItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double price;
  final VoidCallback? onTap;
  final bool isFavorite;

  const ProductItem({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.onTap,
    this.isFavorite = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final isDarkMode = themeProvider.isDarkMode;

    // Initialize responsive config
    final responsive = ResponsiveUiConfig(context);

    // Colors based on theme
    final backgroundColor =
        isDarkMode ? ColorDark.background : ColorLight.background;
    final titleColor = isDarkMode ? ColorDark.titleText : ColorLight.titleText;

    final itemWidth = responsive.setWidth(140);
    final imageHeight = responsive.setHeight(160);
    final titleFontSize = responsive.setWidth(13);
    final priceFontSize = responsive.setWidth(15);
    final horizontalSpacing = responsive.setWidth(12);
    final verticalSpacing = responsive.setHeight(6);
    final textAreaHeight = responsive.setHeight(
      50,
    ); 
    final cardHeight = imageHeight + textAreaHeight; 

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: itemWidth,
        height: cardHeight, // Set explicit height to prevent overflow
        margin: EdgeInsets.only(right: horizontalSpacing),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image 
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: SizedBox(
                height: imageHeight,
                width: itemWidth,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: const Center(
                        child: Icon(Icons.broken_image, color: Colors.grey),
                      ),
                    );
                  },
                ),
              ),
            ),

            Container(
              height: textAreaHeight,
              padding: EdgeInsets.only(left: 8, right: 8, top: verticalSpacing),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Title
                  Text(
                    title,
                    style: TextStyle(
                      color: titleColor,
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: verticalSpacing / 2),

                  // Product Price
                  Text(
                    '\$ ${price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: titleColor,
                      fontSize: priceFontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
