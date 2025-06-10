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

    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth =
            constraints.maxWidth == double.infinity
                ? responsive.setWidth(140)
                : constraints.maxWidth;
        final imageHeight = responsive.setHeight(160).clamp(80.0, 220.0);
        final titleFontSize = responsive.setWidth(13).clamp(10.0, 18.0);
        final priceFontSize = responsive.setWidth(15).clamp(12.0, 20.0);
        final horizontalSpacing = responsive.setWidth(12).clamp(6.0, 20.0);
        final verticalSpacing = responsive.setHeight(6).clamp(2.0, 12.0);
        final textAreaHeight = responsive.setHeight(50).clamp(30.0, 70.0);
        final cardHeight = imageHeight + textAreaHeight;

        return Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              debugPrint('ProductItem tapped: $title');
              if (onTap != null) onTap!();
            },
            child: Container(
              width: itemWidth,
              constraints: BoxConstraints(
                minWidth: 100,
                maxWidth: 220,
                minHeight: cardHeight,
                maxHeight: imageHeight + textAreaHeight + 16,
              ),
              margin: EdgeInsets.only(right: horizontalSpacing),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(16),
                // border: Border.all(color: Colors.red, width: 2), // Removed debug border
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
                        width: itemWidth,
                        height: imageHeight,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: const Center(
                              child: Icon(
                                Icons.broken_image,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  // Replace Expanded with SizedBox for text area
                  SizedBox(
                    height: textAreaHeight,
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 8,
                        right: 8,
                        top: verticalSpacing,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              title,
                              style: TextStyle(
                                color: titleColor,
                                fontSize: titleFontSize,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                          ),
                          SizedBox(height: verticalSpacing / 2),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              '\$ ${price.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: titleColor,
                                fontSize: priceFontSize,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
