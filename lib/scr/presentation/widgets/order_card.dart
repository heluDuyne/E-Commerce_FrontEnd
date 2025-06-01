import 'package:flutter/material.dart';
import 'package:e_commerce_frontend/scr/core/utils/values/colors.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_frontend/scr/core/utils/theme/theme_provider.dart';
import 'package:e_commerce_frontend/scr/core/utils/helpers/responsive_ui_helper/responsive_ui_config.dart';
import 'package:intl/intl.dart';

enum OrderStatus { pending, delivered, cancelled }

class OrderCard extends StatelessWidget {
  final String orderNumber;
  final String trackingNumber;
  final int quantity;
  final double subtotal;
  final DateTime orderDate;
  final OrderStatus status;
  final VoidCallback onDetailsPressed;

  const OrderCard({
    Key? key,
    required this.orderNumber,
    required this.trackingNumber,
    required this.quantity,
    required this.subtotal,
    required this.orderDate,
    required this.status,
    required this.onDetailsPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final responsive = ResponsiveUiConfig(context);

    // Theme colors
    final backgroundColor =
        isDarkMode ? ColorDark.orderCardBackground : ColorLight.background;
    final shadowColor =
        isDarkMode ? ColorDark.cardShadow : ColorLight.cardShadow;
    final titleColor = isDarkMode ? ColorDark.titleText : ColorLight.titleText;
    final infoTextColor = isDarkMode ? ColorDark.infoText : ColorLight.infoText;
    final labelTextColor =
        isDarkMode ? ColorDark.labelText : ColorLight.labelText;
    final detailsButtonBorderColor =
        isDarkMode
            ? ColorDark.detailsButtonBorder
            : ColorLight.detailsButtonBorder;

    // Status colors
    Color statusColor;
    switch (status) {
      case OrderStatus.pending:
        statusColor =
            isDarkMode ? ColorDark.statusPending : ColorLight.statusPending;
        break;
      case OrderStatus.delivered:
        statusColor =
            isDarkMode ? ColorDark.statusDelivered : ColorLight.statusDelivered;
        break;
      case OrderStatus.cancelled:
        statusColor =
            isDarkMode ? ColorDark.statusCancelled : ColorLight.statusCancelled;
        break;
    }

    String statusText = status.name.toUpperCase();
    String formattedDate = DateFormat('dd/MM/yyyy').format(orderDate);

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: responsive.setWidth(16),
        vertical: responsive.setHeight(8),
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(responsive.setWidth(12)),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            offset: const Offset(0, 2),
            blurRadius: 6,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(responsive.setWidth(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order number and date row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #$orderNumber',
                  style: TextStyle(
                    color: titleColor,
                    fontSize: responsive.setWidth(16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  formattedDate,
                  style: TextStyle(
                    color: labelTextColor,
                    fontSize: responsive.setWidth(12),
                  ),
                ),
              ],
            ),

            SizedBox(height: responsive.setHeight(12)),

            // Tracking number
            _buildInfoRow(
              context: context,
              label: 'Tracking number:',
              value: trackingNumber,
              labelColor: labelTextColor,
              valueColor: infoTextColor,
            ),

            SizedBox(height: responsive.setHeight(6)),

            // Quantity
            _buildInfoRow(
              context: context,
              label: 'Quantity:',
              value: quantity.toString(),
              labelColor: labelTextColor,
              valueColor: infoTextColor,
            ),

            SizedBox(height: responsive.setHeight(12)),

            // Bottom row with status, subtotal and details button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Status indicator
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive.setWidth(10),
                    vertical: responsive.setHeight(6),
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(responsive.setWidth(4)),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: responsive.setWidth(11),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                // Subtotal and details button
                Row(
                  children: [
                    // Subtotal
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Subtotal:',
                          style: TextStyle(
                            color: labelTextColor,
                            fontSize: responsive.setWidth(12),
                          ),
                        ),
                        SizedBox(height: responsive.setHeight(2)),
                        Text(
                          '\$${subtotal.toStringAsFixed(0)}',
                          style: TextStyle(
                            color: titleColor,
                            fontSize: responsive.setWidth(16),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(width: responsive.setWidth(10)),

                    // Details button - pill shape
                    OutlinedButton(
                      onPressed: onDetailsPressed,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: detailsButtonBorderColor,
                          width: 1.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: responsive.setWidth(14),
                          vertical: responsive.setHeight(8),
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Details',
                        style: TextStyle(
                          color: titleColor,
                          fontSize: responsive.setWidth(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required BuildContext context,
    required String label,
    required String value,
    required Color labelColor,
    required Color valueColor,
  }) {
    final responsive = ResponsiveUiConfig(context);

    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            color: labelColor,
            fontSize: responsive.setWidth(12),
          ),
        ),
        SizedBox(width: responsive.setWidth(8)),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: responsive.setWidth(13),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
