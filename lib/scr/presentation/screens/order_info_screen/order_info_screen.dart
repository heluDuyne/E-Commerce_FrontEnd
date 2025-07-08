import 'package:flutter/material.dart';
import 'package:e_commerce_frontend/scr/core/utils/helpers/responsive_ui_helper/responsive_ui_config.dart';
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_frontend/scr/core/utils/theme/theme_provider.dart';
import 'package:e_commerce_frontend/scr/core/utils/values/colors.dart';

@RoutePage()
class OrderInfoScreen extends StatelessWidget {
  final String orderNumber;

  const OrderInfoScreen({super.key, required this.orderNumber});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final responsive = ResponsiveUiConfig(context);

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor:
            isDarkMode ? ColorDark.background : ColorLight.background,
        title: Text(
          'Order #$orderNumber',
          style: TextStyle(
            color: isDarkMode ? ColorDark.titleText : ColorLight.titleText,
            fontWeight: FontWeight.bold,
            fontSize: responsive.setWidth(18),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDarkMode ? ColorDark.iconPrimary : ColorLight.iconPrimary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor:
          isDarkMode ? ColorDark.background : ColorLight.background,
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: responsive.setWidth(
              350,
            ), // Ensures consistent width for all sections
            child: Padding(
              padding: EdgeInsets.all(responsive.setWidth(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatusSection(responsive, isDarkMode),
                  const SizedBox(height: 16),
                  _buildCard(
                    child: _buildOrderDetails(responsive, isDarkMode),
                    isDarkMode: isDarkMode,
                    responsive: responsive,
                  ),
                  const SizedBox(height: 16),
                  Divider(
                    color:
                        isDarkMode
                            ? Colors.grey.shade700
                            : Colors.grey.shade300,
                  ),
                  const SizedBox(height: 16),
                  _buildCard(
                    child: _buildSummarySection(responsive, isDarkMode),
                    isDarkMode: isDarkMode,
                    responsive: responsive,
                  ),
                  const SizedBox(height: 24),
                  _buildActionButtons(responsive, isDarkMode, context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusSection(ResponsiveUiConfig responsive, bool isDarkMode) {
    return Container(
      padding: EdgeInsets.all(responsive.setWidth(16)),
      decoration: BoxDecoration(
        color:
            isDarkMode
                ? ColorDark.orderStatusBackground
                : ColorLight.orderStatusBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: SingleChildScrollView(
        child: Row(
          children: [
            Icon(
              Icons.local_shipping,
              color: isDarkMode ? Colors.greenAccent : Colors.green,
              size: responsive.setWidth(24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your order is delivered',
                    style: TextStyle(
                      fontSize: responsive.setWidth(16),
                      fontWeight: FontWeight.bold,
                      color:
                          isDarkMode
                              ? ColorDark.orderSectionTextColor
                              : ColorLight.orderSectionTextColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rate product to get 5 points for collect.',
                    style: TextStyle(
                      fontSize: responsive.setWidth(14),
                      color:
                          isDarkMode
                              ? ColorDark.orderSectionTextColor
                              : ColorLight.orderSectionTextColor,
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

  Widget _buildCard({
    required Widget child,
    required bool isDarkMode,
    required ResponsiveUiConfig responsive,
  }) {
    return Container(
      padding: EdgeInsets.all(responsive.setWidth(16)),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black26 : Colors.grey.shade300,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildOrderDetails(ResponsiveUiConfig responsive, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order number: #$orderNumber',
          style: TextStyle(
            fontSize: responsive.setWidth(14),
            color:
                isDarkMode ? ColorDark.subtitleText : ColorLight.subtitleText,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Tracking Number: IK987362341',
          style: TextStyle(
            fontSize: responsive.setWidth(14),
            color:
                isDarkMode ? ColorDark.subtitleText : ColorLight.subtitleText,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Delivery address: SBI Building, Software Park',
          style: TextStyle(
            fontSize: responsive.setWidth(14),
            color:
                isDarkMode ? ColorDark.subtitleText : ColorLight.subtitleText,
          ),
        ),
      ],
    );
  }

  Widget _buildSummarySection(ResponsiveUiConfig responsive, bool isDarkMode) {
    final products = [
      {'name': 'Maxi Dress', 'quantity': 'x1', 'price': '\$68.00'},
      {'name': 'Linen Dress', 'quantity': 'x1', 'price': '\$52.00'},
    ];

    return Column(
      children: [
        ...products.map((product) {
          return Column(
            children: [
              _buildSummaryRow(
                product['name']!,
                product['price']!,
                responsive,
                isDarkMode,
              ),
              const SizedBox(height: 8),
            ],
          );
        }),
        _buildSummaryRow('Sub Total', '\$120.00', responsive, isDarkMode),
        const SizedBox(height: 8),
        _buildSummaryRow('Shipping', '\$0.00', responsive, isDarkMode),
        const SizedBox(height: 8),
        Divider(
          color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
        ),
        const SizedBox(height: 8),
        _buildSummaryRow(
          'Total',
          '\$120.00',
          responsive,
          isDarkMode,
          isBold: true,
        ),
      ],
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value,
    ResponsiveUiConfig responsive,
    bool isDarkMode, {
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: responsive.setWidth(14),
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color:
                isDarkMode ? ColorDark.subtitleText : ColorLight.subtitleText,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: responsive.setWidth(14),
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color:
                isDarkMode ? ColorDark.subtitleText : ColorLight.subtitleText,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(
    ResponsiveUiConfig responsive,
    bool isDarkMode,
    BuildContext context,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          style: ElevatedButton.styleFrom(
            backgroundColor: isDarkMode ? Colors.black : Colors.white,
            side: BorderSide(
              color: isDarkMode ? Colors.grey.shade600 : Colors.grey.shade400,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: responsive.setWidth(24),
              vertical: responsive.setHeight(12),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(
            'Return Home',
            style: TextStyle(
              fontSize: responsive.setWidth(14),
              color: isDarkMode ? Colors.white : Colors.grey.shade600,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: isDarkMode ? Colors.white : Colors.grey.shade800,
            padding: EdgeInsets.symmetric(
              horizontal: responsive.setWidth(24),
              vertical: responsive.setHeight(12),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(
            'Rate',
            style: TextStyle(
              fontSize: responsive.setWidth(14),
              color: isDarkMode ? Colors.black : Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
