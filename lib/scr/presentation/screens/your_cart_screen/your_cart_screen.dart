import 'package:e_commerce_frontend/injector.dart';
import 'package:e_commerce_frontend/scr/data/models/request/cart_item_request_model/cart_item_request_model.dart';
import 'package:e_commerce_frontend/scr/data/models/request/product_detail_resquest_model/product_detail_resquest_model.dart';
import 'package:e_commerce_frontend/scr/data/models/request/product_variant_request_model/product_variant_request_model.dart';
import 'package:e_commerce_frontend/scr/domain/entities/product_detail_entity/product_detail_entity.dart';
import 'package:e_commerce_frontend/scr/presentation/bloc/cart/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_frontend/scr/core/utils/theme/theme_provider.dart';
import 'package:e_commerce_frontend/scr/core/utils/values/colors.dart';
import 'package:e_commerce_frontend/scr/core/utils/helpers/responsive_ui_helper/responsive_ui_config.dart';
import 'package:e_commerce_frontend/scr/core/utils/app_route/app_router.gr.dart';

@RoutePage()
class YourCartScreen extends StatelessWidget {
  const YourCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final responsive = ResponsiveUiConfig(context);

    return BlocProvider(
      create: (context) => locator<CartBloc>()..add(const GetListCartItem()),
      child: Scaffold(
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
              color:
                  isDarkMode ? ColorDark.iconPrimary : ColorLight.iconPrimary,
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
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(
            vertical: responsive.setHeight(16),
            horizontal: responsive.setWidth(24),
          ),
          decoration: BoxDecoration(
            color: isDarkMode ? ColorDark.background : Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color:
                    isDarkMode ? ColorDark.cardShadow : ColorLight.cardShadow,
                blurRadius: 12,
                offset: Offset(0, -4),
              ),
            ],
          ),
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is LoadedCart) {
                print("LoadedCart state: ${state.cartItems.length}");
                final productPrice = state.cartItems
                    .where((item) => item.isChecked)
                    .fold(
                      0.0,
                      (sum, item) =>
                          sum +
                          (item.genericProductInfo.salePrice <
                                  item.genericProductInfo.originalPrice
                              ? (item.genericProductInfo.salePrice *
                                  item.quantity)
                              : (item.genericProductInfo.originalPrice *
                                  item.quantity)),
                    );
                print("Product price: $productPrice");
                final shipping = 0.0;
                final subtotal = productPrice + shipping;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                          context.router.push(const CheckoutRoute());
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
                  ],
                );
              } else if (state is LoadedMoreCart) {
                print("LoadedCart state: ${state.cartItems.length}");
                final productPrice = state.cartItems
                    .where((item) => item.isChecked)
                    .fold(
                      0.0,
                      (sum, item) =>
                          sum +
                          (item.genericProductInfo.salePrice <
                                  item.genericProductInfo.originalPrice
                              ? (item.genericProductInfo.salePrice *
                                  item.quantity)
                              : (item.genericProductInfo.originalPrice *
                                  item.quantity)),
                    );
                final shipping = 0.0;
                final subtotal = productPrice + shipping;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                          context.router.push(const CheckoutRoute());
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
                  ],
                );
              } else {
                double productPrice = 0.0;
                double shipping = 0.0;
                double subtotal = productPrice + shipping;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                          // context.router.push(const CheckoutRoute());
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
                  ],
                );
              }
            },
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Center(
              child: SizedBox(
                width: responsive.setWidth(370),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive.setWidth(24),
                  ), // Increased horizontal padding
                  child: BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      if (state is LoadedCart) {
                        return state.cartItems.isNotEmpty
                            ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: responsive.setHeight(8)),
                                ...state.cartItems.map(
                                  (item) => _CartItemCard(
                                    cartId: item.id,
                                    productDetail: item.productDetail,
                                    image:
                                        item
                                            .genericProductInfo
                                            .images
                                            .first
                                            .url,
                                    title: item.genericProductInfo.name,
                                    price:
                                        item.genericProductInfo.originalPrice,
                                    size: item.productDetail.detailVariant.size,
                                    color:
                                        item.productDetail.detailVariant.color,
                                    quantity: item.quantity,
                                    checked: item.isChecked,
                                    isDarkMode: isDarkMode,
                                    responsive: responsive,
                                  ),
                                ),
                                SizedBox(height: responsive.setHeight(24)),
                              ],
                            )
                            : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Your cart is empty',
                                    style: TextStyle(
                                      fontSize: responsive.setWidth(26),
                                      fontWeight: FontWeight.bold,
                                      color:
                                          isDarkMode
                                              ? ColorDark.titleText
                                              : ColorLight.titleText,
                                    ),
                                  ),
                                  SizedBox(height: responsive.setHeight(16)),
                                  TextButton(
                                    onPressed: () {
                                      context.router.replaceAll([
                                        const HomeRoute(),
                                      ]);
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor:
                                          isDarkMode
                                              ? ColorDark.buttonBackground
                                              : ColorLight.buttonBackground,
                                      padding: EdgeInsets.symmetric(
                                        vertical: responsive.setHeight(12),
                                        horizontal: responsive.setWidth(24),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    child: Text(
                                      'Go to Home',
                                      style: TextStyle(
                                        fontSize: responsive.setWidth(16),
                                        color:
                                            isDarkMode
                                                ? ColorDark.buttonText
                                                : ColorLight.buttonText,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                      } else if (state is LoadedMoreCart) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: responsive.setHeight(8)),
                            ...state.cartItems.map(
                              (item) => _CartItemCard(
                                cartId: item.id,
                                productDetail: item.productDetail,
                                image: item.genericProductInfo.images.first.url,
                                title: item.genericProductInfo.name,
                                price: item.genericProductInfo.originalPrice,
                                size: item.productDetail.detailVariant.size,
                                color: item.productDetail.detailVariant.color,
                                quantity: item.quantity,
                                checked: item.isChecked,
                                isDarkMode: isDarkMode,
                                responsive: responsive,
                              ),
                            ),
                            SizedBox(height: responsive.setHeight(24)),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CartItemCard extends StatelessWidget {
  final int cartId;
  final ProductDetailEntity productDetail;
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
    required this.cartId,
    required this.productDetail,
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
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Checkbox(
                      value: checked,
                      onChanged: (bool? value) {
                        if (value != null) {
                          context.read<CartBloc>().add(
                            UpdateCartItem(
                              id: cartId,
                              cartItemRequestModel: CartItemRequestModel(
                                productDetail: ProductDetailResquestModel(
                                  detailVariant: ProductVariantRequestModel(
                                    size: productDetail.detailVariant.size,
                                    color: productDetail.detailVariant.color,
                                    id: productDetail.detailVariant.id,
                                    product:
                                        productDetail.detailVariant.product,
                                    stockQuantity:
                                        productDetail
                                            .detailVariant
                                            .stockQuantity,
                                  ),
                                  product: productDetail.product,
                                  price: productDetail.price,
                                  salePrice: productDetail.salePrice,
                                ),
                                isChecked: !checked,
                                quantity: quantity,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: responsive.setWidth(16),
                      color:
                          isDarkMode
                              ? ColorDark.titleText
                              : ColorLight.titleText,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
                            onPressed: () {
                              if (quantity > 1) {
                                context.read<CartBloc>().add(
                                  UpdateCartItem(
                                    id: cartId,
                                    cartItemRequestModel: CartItemRequestModel(
                                      productDetail: ProductDetailResquestModel(
                                        detailVariant:
                                            ProductVariantRequestModel(
                                              size:
                                                  productDetail
                                                      .detailVariant
                                                      .size,
                                              color:
                                                  productDetail
                                                      .detailVariant
                                                      .color,
                                              id:
                                                  productDetail
                                                      .detailVariant
                                                      .id,
                                              product:
                                                  productDetail
                                                      .detailVariant
                                                      .product,
                                              stockQuantity:
                                                  productDetail
                                                      .detailVariant
                                                      .stockQuantity,
                                            ),
                                        product: productDetail.product,
                                        price: productDetail.price,
                                        salePrice: productDetail.salePrice,
                                      ),
                                      isChecked: checked,
                                      quantity: quantity - 1,
                                    ),
                                  ),
                                );
                              }
                            },
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
                            onPressed: () {
                              context.read<CartBloc>().add(
                                UpdateCartItem(
                                  id: cartId,
                                  cartItemRequestModel: CartItemRequestModel(
                                    productDetail: ProductDetailResquestModel(
                                      detailVariant: ProductVariantRequestModel(
                                        size: productDetail.detailVariant.size,
                                        color:
                                            productDetail.detailVariant.color,
                                        id: productDetail.detailVariant.id,
                                        product:
                                            productDetail.detailVariant.product,
                                        stockQuantity:
                                            productDetail
                                                .detailVariant
                                                .stockQuantity,
                                      ),
                                      product: productDetail.product,
                                      price: productDetail.price,
                                      salePrice: productDetail.salePrice,
                                    ),
                                    isChecked: checked,
                                    quantity: quantity + 1,
                                  ),
                                ),
                              );
                            },
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
            '\$$productPrice',
            isDarkMode,
            responsive,
            false,
          ),
          _summaryRow(
            'Shipping',
            shipping == 0 ? 'Freeship' : shipping.toString(),
            isDarkMode,
            responsive,
            false,
          ),
          Divider(
            color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
            height: 28,
          ),
          _summaryRow(
            'Subtotal',
            '\$${subtotal.toStringAsFixed(2)}',
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
