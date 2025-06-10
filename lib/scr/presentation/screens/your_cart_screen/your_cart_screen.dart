import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_frontend/scr/core/utils/theme/theme_provider.dart';
import 'package:e_commerce_frontend/scr/core/utils/values/colors.dart';
import 'package:e_commerce_frontend/scr/core/utils/helpers/responsive_ui_helper/responsive_ui_config.dart';

@RoutePage()
class YourCartScreen extends StatelessWidget {
  const YourCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final responsive = ResponsiveUiConfig(context);

    final cartItems = [
      {
        'image': 'https://i.imgur.com/1Q9Z1Zm.png',
        'title': 'Sportwear Set',
        'price': 80.00,
        'size': 'L',
        'color': 'Cream',
        'quantity': 1,
        'checked': true,
      },
      {
        'image': 'https://i.imgur.com/8Km9tLL.png',
        'title': 'Turtleneck Sweater',
        'price': 39.99,
        'size': 'M',
        'color': 'White',
        'quantity': 1,
        'checked': true,
      },
      {
        'image': 'https://i.imgur.com/5tj6S7Ol.png',
        'title': 'Cotton T-shirt',
        'price': 30.00,
        'size': 'L',
        'color': 'Black',
        'quantity': 1,
        'checked': true,
      },
    ];

    double productPrice = cartItems.fold(
      0,
      (sum, item) =>
          sum + (item['price'] as double) * (item['quantity'] as int),
    );
    double shipping = 0.0;
    double subtotal = productPrice + shipping;

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
        centerTitle: true,
        title: Text(
          'Your Cart',
          style: TextStyle(
            color: isDarkMode ? ColorDark.titleText : ColorLight.titleText,
            fontWeight: FontWeight.bold,
            fontSize: responsive.setWidth(20),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: responsive.setWidth(370),
            child: Padding(
              padding: EdgeInsets.all(responsive.setWidth(0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: responsive.setHeight(8)),
                  ...cartItems.map(
                    (item) => _CartItemCard(
                      image: item['image'] as String,
                      title: item['title'] as String,
                      price: item['price'] as double,
                      size: item['size'] as String,
                      color: item['color'] as String,
                      quantity: item['quantity'] as int,
                      checked: item['checked'] as bool,
                      isDarkMode: isDarkMode,
                      responsive: responsive,
                    ),
                  ),
                  SizedBox(height: responsive.setHeight(24)),
                  _CartSummary(
                    productPrice: productPrice,
                    shipping: shipping,
                    subtotal: subtotal,
                    isDarkMode: isDarkMode,
                    responsive: responsive,
                  ),
                  SizedBox(height: responsive.setHeight(24)),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Implement checkout navigation
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isDarkMode
                                ? ColorDark.buttonBackground
                                : ColorLight.buttonBackground,
                        foregroundColor:
                            isDarkMode
                                ? ColorDark.buttonText
                                : ColorLight.buttonText,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: responsive.setHeight(16),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Proceed to checkout',
                        style: TextStyle(
                          fontSize: responsive.setWidth(16),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: responsive.setHeight(16)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CartItemCard extends StatelessWidget {
  final String image;
  final String title;
  final double price;
  final String size;
  final String color;
  final int quantity;
  final bool checked;
  final bool isDarkMode;
  final ResponsiveUiConfig responsive;

  const _CartItemCard({
    required this.image,
    required this.title,
    required this.price,
    required this.size,
    required this.color,
    required this.quantity,
    required this.checked,
    required this.isDarkMode,
    required this.responsive,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: responsive.setHeight(16)),
      padding: EdgeInsets.all(responsive.setWidth(12)),
      decoration: BoxDecoration(
        color: isDarkMode ? ColorDark.background2 : Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? ColorDark.cardShadow : ColorLight.cardShadow,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              image,
              width: responsive.setWidth(80),
              height: responsive.setWidth(80),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: responsive.setWidth(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: responsive.setWidth(16),
                          color:
                              isDarkMode
                                  ? ColorDark.titleText
                                  : ColorLight.titleText,
                        ),
                      ),
                    ),
                    if (checked)
                      Container(
                        decoration: BoxDecoration(
                          color:
                              isDarkMode
                                  ? ColorDark.success
                                  : ColorLight.success,
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(4),
                        child: Icon(Icons.check, size: 18, color: Colors.white),
                      ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: responsive.setWidth(16),
                    color:
                        isDarkMode ? ColorDark.titleText : ColorLight.titleText,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Size: $size  |  Color: $color',
                  style: TextStyle(
                    fontSize: responsive.setWidth(13),
                    color:
                        isDarkMode
                            ? ColorDark.subtitleText
                            : ColorLight.subtitleText,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              isDarkMode
                                  ? ColorDark.subtitleText
                                  : ColorLight.subtitleText,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        color:
                            isDarkMode
                                ? ColorDark.background
                                : ColorLight.background2,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.remove,
                              size: 18,
                              color:
                                  isDarkMode
                                      ? ColorDark.subtitleText
                                      : ColorLight.subtitleText,
                            ),
                            onPressed: () {},
                            splashRadius: 18,
                          ),
                          Text(
                            quantity.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color:
                                  isDarkMode
                                      ? ColorDark.titleText
                                      : ColorLight.titleText,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.add,
                              size: 18,
                              color:
                                  isDarkMode
                                      ? ColorDark.subtitleText
                                      : ColorLight.subtitleText,
                            ),
                            onPressed: () {},
                            splashRadius: 18,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CartSummary extends StatelessWidget {
  final double productPrice;
  final double shipping;
  final double subtotal;
  final bool isDarkMode;
  final ResponsiveUiConfig responsive;

  const _CartSummary({
    required this.productPrice,
    required this.shipping,
    required this.subtotal,
    required this.isDarkMode,
    required this.responsive,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 0),
      decoration: BoxDecoration(
        color: isDarkMode ? ColorDark.background : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _summaryRow(
            'Product price',
            '\${productPrice.toStringAsFixed(0)}',
            isDarkMode,
            responsive,
            false,
          ),
          _summaryRow('Shipping', 'Freeship', isDarkMode, responsive, false),
          Divider(
            color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
            height: 28,
          ),
          _summaryRow(
            'Subtotal',
            '\${subtotal.toStringAsFixed(0)}',
            isDarkMode,
            responsive,
            true,
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(
    String label,
    String value,
    bool isDarkMode,
    ResponsiveUiConfig responsive,
    bool isBold,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: responsive.setWidth(15),
              color:
                  isDarkMode ? ColorDark.subtitleText : ColorLight.subtitleText,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: responsive.setWidth(15),
              color:
                  isBold
                      ? (isDarkMode
                          ? ColorDark.titleText
                          : ColorLight.titleText)
                      : (isDarkMode
                          ? ColorDark.subtitleText
                          : ColorLight.subtitleText),
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
