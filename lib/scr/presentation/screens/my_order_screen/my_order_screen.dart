import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_frontend/scr/core/utils/theme/theme_provider.dart';
import 'package:e_commerce_frontend/scr/core/utils/values/colors.dart';
import 'package:e_commerce_frontend/scr/core/utils/helpers/responsive_ui_helper/responsive_ui_config.dart';
import 'package:e_commerce_frontend/scr/presentation/widgets/order_card.dart';
import 'package:e_commerce_frontend/scr/presentation/widgets/sidebar.dart';
import 'package:e_commerce_frontend/scr/presentation/widgets/bottom_nav_bar.dart';
import 'package:e_commerce_frontend/scr/core/utils/app_route/app_router.gr.dart';

@RoutePage()
class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  int _selectedFilterIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Order> _orders = [];

  // Filter options
  final List<String> _filterOptions = ['Pending', 'Delivered', 'Cancelled'];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final responsive = ResponsiveUiConfig(context);

    // Initialize orders with context-dependent logic
    _orders.clear();
    _orders.addAll([
      Order(
        orderNumber: '1524',
        trackingNumber: 'IK287368838',
        quantity: 2,
        subtotal: 110,
        orderDate: DateTime(2021, 5, 13),
        status: OrderStatus.pending,
        onDetailsPressed: () {
          context.router.push(OrderInfoRoute(orderNumber: '1524'));
        },
      ),
      Order(
        orderNumber: '1524',
        trackingNumber: 'IK2873218897',
        quantity: 3,
        subtotal: 230,
        orderDate: DateTime(2021, 5, 12),
        status: OrderStatus.pending,
        onDetailsPressed: () {
          context.router.push(OrderInfoRoute(orderNumber: '1524'));
        },
      ),
      Order(
        orderNumber: '1524',
        trackingNumber: 'IK237368820',
        quantity: 5,
        subtotal: 490,
        orderDate: DateTime(2021, 5, 10),
        status: OrderStatus.pending,
        onDetailsPressed: () {
          context.router.push(OrderInfoRoute(orderNumber: '1524'));
        },
      ),
      Order(
        orderNumber: '1525',
        trackingNumber: 'IK287368839',
        quantity: 1,
        subtotal: 75,
        orderDate: DateTime(2021, 5, 9),
        status: OrderStatus.delivered,
        onDetailsPressed: () {
          context.router.push(OrderInfoRoute(orderNumber: '1525'));
        },
      ),
      Order(
        orderNumber: '1526',
        trackingNumber: 'IK287368840',
        quantity: 2,
        subtotal: 150,
        orderDate: DateTime(2021, 5, 8),
        status: OrderStatus.cancelled,
        onDetailsPressed: () {
          context.router.push(OrderInfoRoute(orderNumber: '1526'));
        },
      ),
    ]);

    // Filter orders based on selected filter
    List<Order> filteredOrders =
        _orders.where((order) {
          if (_selectedFilterIndex == 0) {
            return order.status == OrderStatus.pending;
          } else if (_selectedFilterIndex == 1) {
            return order.status == OrderStatus.delivered;
          } else {
            return order.status == OrderStatus.cancelled;
          }
        }).toList();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor:
          isDarkMode ? ColorDark.background : ColorLight.background,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor:
            isDarkMode ? ColorDark.background : ColorLight.background,
        elevation: 0,
        title: Text(
          'My Orders',
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
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              color:
                  isDarkMode ? ColorDark.iconPrimary : ColorLight.iconPrimary,
            ),
            onPressed: () {
              context.router.push(const NotificationRoute());
            },
          ),
        ],
      ),
      drawer: const SidebarWidget(),
      body: Column(
        children: [
          // Filter tabs
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: responsive.setWidth(16),
              vertical: responsive.setHeight(12),
            ),
            child: Row(
              children: List.generate(
                _filterOptions.length,
                (index) => Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedFilterIndex = index;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: responsive.setHeight(10),
                      ),
                      margin: EdgeInsets.only(
                        right:
                            index < _filterOptions.length - 1
                                ? responsive.setWidth(8)
                                : 0,
                      ),
                      decoration: BoxDecoration(
                        color:
                            _selectedFilterIndex == index
                                ? isDarkMode
                                    ? Colors.grey.shade800
                                    : Colors.grey.shade800
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _filterOptions[index],
                        style: TextStyle(
                          color:
                              _selectedFilterIndex == index
                                  ? Colors.white
                                  : isDarkMode
                                  ? ColorDark.subtitleText
                                  : ColorLight.subtitleText,
                          fontSize: responsive.setWidth(14),
                          fontWeight:
                              _selectedFilterIndex == index
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Orders list
          Expanded(
            child:
                filteredOrders.isEmpty
                    ? Center(
                      child: Text(
                        'No ${_filterOptions[_selectedFilterIndex].toLowerCase()} orders found',
                        style: TextStyle(
                          color:
                              isDarkMode
                                  ? ColorDark.subtitleText
                                  : ColorLight.subtitleText,
                          fontSize: responsive.setWidth(16),
                        ),
                      ),
                    )
                    : ListView.builder(
                      padding: EdgeInsets.all(responsive.setWidth(16)),
                      itemCount: filteredOrders.length,
                      itemBuilder: (context, index) {
                        final order = filteredOrders[index];
                        return OrderCard(
                          orderNumber: order.orderNumber,
                          trackingNumber: order.trackingNumber,
                          quantity: order.quantity,
                          subtotal: order.subtotal,
                          orderDate: order.orderDate,
                          status: order.status,
                          onDetailsPressed: order.onDetailsPressed,
                        );
                      },
                    ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          // Handle navigation
        },
      ),
    );
  }
}

class Order {
  final String orderNumber;
  final String trackingNumber;
  final int quantity;
  final double subtotal;
  final DateTime orderDate;
  final OrderStatus status;
  final VoidCallback onDetailsPressed;

  Order({
    required this.orderNumber,
    required this.trackingNumber,
    required this.quantity,
    required this.subtotal,
    required this.orderDate,
    required this.status,
    required this.onDetailsPressed,
  });
}
