import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_frontend/injector.dart';
import 'package:e_commerce_frontend/scr/core/utils/helpers/responsive_ui_helper/responsive_ui_config.dart';
import 'package:e_commerce_frontend/scr/core/utils/loading_dialog/loading_dialog.dart';
import 'package:e_commerce_frontend/scr/core/utils/toast/flutter_toast.dart';
import 'package:e_commerce_frontend/scr/data/models/request/cart_item_request_model/cart_item_request_model.dart';
import 'package:e_commerce_frontend/scr/data/models/request/product_detail_resquest_model/product_detail_resquest_model.dart';
import 'package:e_commerce_frontend/scr/data/models/request/product_variant_request_model/product_variant_request_model.dart';
import 'package:e_commerce_frontend/scr/presentation/bloc/cart/cart_bloc.dart';
import 'package:e_commerce_frontend/scr/presentation/bloc/product/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_frontend/scr/core/utils/app_route/app_router.gr.dart';
import '../../../core/utils/values/colors.dart';
import '../../../core/utils/theme/theme_provider.dart';

@RoutePage()
class ProductFullScreen extends StatefulWidget {
  const ProductFullScreen({required this.productId, super.key});
  final int productId;

  @override
  State<ProductFullScreen> createState() => _ProductFullScreenState();
}

class _ProductFullScreenState extends State<ProductFullScreen> {
  final PageController pageController = PageController();
  int _currentIndex = 0;
  int selectedColor = 0;
  int selectedSize = 0;
  bool descriptionExpanded = true;
  bool reviewsExpanded = false;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final responsive = ResponsiveUiConfig(context);
    String? selectedColorValue;
    String? selectedSizeValue;
    // final Map<String, dynamic> product = {
    //   'name': 'Sportwear Set',
    //   'image':
    //       'https://images.pexels.com/photos/532220/pexels-photo-532220.jpeg',
    //   'price': 80.00,
    //   'isFavorite': true,
    //   'colors': [
    //     const Color(0xFFF3D6C1), // beige
    //     Colors.pink,
    //     Colors.black,
    //   ],
    //   'sizes': ['S', 'M', 'L'],
    //   'description':
    //       'Sportswear is no longer under culture, it is no longer indie or cobbled together as it once was. Sport is fashion today. The top is oversized in fit and style, may need to size down.',
    //   'rating': 4.9,
    //   'ratingCount': 83,
    // };

    return BlocProvider(
      create:
          (context) =>
              locator<ProductBloc>()
                ..add(FetchProductDetailEvent(widget.productId)),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor:
                isDarkMode ? ColorDark.background : ColorLight.background,
            bottomNavigationBar: BlocProvider(
              create: (context) => locator<CartBloc>(),
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is LoadedProduct) {
                    return BlocListener<CartBloc, CartState>(
                      listener: (context, cartState) {
                        if (cartState is LoadingCart) {
                          showLoadingDialog(context: context);
                        } else if (cartState is AddedToCart) {
                          context.router.pop();
                          showToast(
                            msg: 'Product added to cart',
                            textColor:
                                isDarkMode
                                    ? ColorDark.success
                                    : ColorLight.success,
                            backgroundColor:
                                isDarkMode
                                    ? ColorDark.background2
                                    : ColorLight.background2,
                          );
                          context.router.push(const YourCartRoute());
                        } else if (cartState is ErrorCart) {
                          context.router.pop();
                          showToast(
                            msg: cartState.message,
                            textColor:
                                isDarkMode ? ColorDark.error : ColorLight.error,
                            backgroundColor:
                                isDarkMode
                                    ? ColorDark.background2
                                    : ColorLight.background2,
                          );
                        } else {
                          context.router.pop();
                          showToast(
                            msg: 'Some thing happened',
                            textColor:
                                isDarkMode ? ColorDark.error : ColorLight.error,
                            backgroundColor:
                                isDarkMode
                                    ? ColorDark.background2
                                    : ColorLight.background2,
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextButton(
                          onPressed: () {
                            if (state.productEntity.colors.isEmpty &&
                                state.productEntity.sizes.isEmpty) {
                              context.read<CartBloc>().add(
                                AddProductToCart(
                                  cartItemRequestModel: CartItemRequestModel(
                                    productDetail: ProductDetailResquestModel(
                                      product: state.productEntity.id,
                                      price:
                                          state
                                              .productEntity
                                              .productDetails
                                              .first
                                              .price,
                                      detailVariant: null,
                                      salePrice:
                                          state
                                              .productEntity
                                              .productDetails
                                              .first
                                              .salePrice,
                                    ),
                                    isChecked: false,
                                    quantity: 1,
                                  ),
                                ),
                              );
                            } else if (state.productEntity.colors.isEmpty) {
                              if (selectedSizeValue == null) {
                                showToast(
                                  msg: 'Please select a size',
                                  textColor:
                                      isDarkMode
                                          ? ColorDark.error
                                          : ColorLight.error,
                                  backgroundColor:
                                      isDarkMode
                                          ? ColorDark.background2
                                          : ColorLight.background2,
                                );
                                return;
                              } else {
                                selectedSizeValue =
                                    state.productEntity.sizes[selectedSize];
                                var filterSectectedProductDetail =
                                    state.productEntity.productDetails
                                        .where(
                                          (productDetail) =>
                                              productDetail
                                                  .detailVariant
                                                  .size ==
                                              selectedSizeValue,
                                        )
                                        .toList()
                                        .first;
                                context.read<CartBloc>().add(
                                  AddProductToCart(
                                    cartItemRequestModel: CartItemRequestModel(
                                      productDetail: ProductDetailResquestModel(
                                        product:
                                            filterSectectedProductDetail
                                                .product,
                                        price:
                                            filterSectectedProductDetail.price,
                                        detailVariant:
                                            ProductVariantRequestModel(
                                              id:
                                                  filterSectectedProductDetail
                                                      .detailVariant
                                                      .id,
                                              product:
                                                  filterSectectedProductDetail
                                                      .detailVariant
                                                      .product,
                                              color:
                                                  filterSectectedProductDetail
                                                      .detailVariant
                                                      .color,
                                              size:
                                                  filterSectectedProductDetail
                                                      .detailVariant
                                                      .size,
                                              stockQuantity:
                                                  filterSectectedProductDetail
                                                      .detailVariant
                                                      .stockQuantity,
                                            ),
                                        salePrice:
                                            filterSectectedProductDetail
                                                .salePrice,
                                      ),
                                      isChecked: false,
                                      quantity: 1,
                                    ),
                                  ),
                                );
                              }
                            } else if (state.productEntity.sizes.isEmpty) {
                              selectedColorValue =
                                  state.productEntity.colors[selectedColor];
                              if (selectedColorValue == null) {
                                showToast(
                                  msg: 'Please select a color',
                                  textColor:
                                      isDarkMode
                                          ? ColorDark.error
                                          : ColorLight.error,
                                  backgroundColor:
                                      isDarkMode
                                          ? ColorDark.background2
                                          : ColorLight.background2,
                                );
                                return;
                              } else {
                                var filterSectectedProductDetail =
                                    state.productEntity.productDetails
                                        .where(
                                          (productDetail) =>
                                              productDetail
                                                  .detailVariant
                                                  .color ==
                                              selectedColorValue,
                                        )
                                        .toList()
                                        .first;
                                context.read<CartBloc>().add(
                                  AddProductToCart(
                                    cartItemRequestModel: CartItemRequestModel(
                                      productDetail: ProductDetailResquestModel(
                                        product:
                                            filterSectectedProductDetail
                                                .product,
                                        price:
                                            filterSectectedProductDetail.price,
                                        detailVariant:
                                            ProductVariantRequestModel(
                                              id:
                                                  filterSectectedProductDetail
                                                      .detailVariant
                                                      .id,
                                              product:
                                                  filterSectectedProductDetail
                                                      .detailVariant
                                                      .product,
                                              color:
                                                  filterSectectedProductDetail
                                                      .detailVariant
                                                      .color,
                                              size:
                                                  filterSectectedProductDetail
                                                      .detailVariant
                                                      .size,
                                              stockQuantity:
                                                  filterSectectedProductDetail
                                                      .detailVariant
                                                      .stockQuantity,
                                            ),
                                        salePrice:
                                            filterSectectedProductDetail
                                                .salePrice,
                                      ),
                                      isChecked: false,
                                      quantity: 1,
                                    ),
                                  ),
                                );
                              }
                            } else {
                              selectedSizeValue =
                                  state.productEntity.sizes[selectedSize];
                              selectedColorValue =
                                  state.productEntity.colors[selectedColor];
                              var filterSectectedProductDetail =
                                  state.productEntity.productDetails
                                      .where(
                                        (productDetail) =>
                                            productDetail.detailVariant.size ==
                                                selectedSizeValue &&
                                            productDetail.detailVariant.color ==
                                                selectedColorValue,
                                      )
                                      .toList()
                                      .first;

                              context.read<CartBloc>().add(
                                AddProductToCart(
                                  cartItemRequestModel: CartItemRequestModel(
                                    productDetail: ProductDetailResquestModel(
                                      product:
                                          filterSectectedProductDetail.product,
                                      price: filterSectectedProductDetail.price,
                                      detailVariant: ProductVariantRequestModel(
                                        id:
                                            filterSectectedProductDetail
                                                .detailVariant
                                                .id,
                                        product:
                                            filterSectectedProductDetail
                                                .detailVariant
                                                .product,
                                        color:
                                            filterSectectedProductDetail
                                                .detailVariant
                                                .color,
                                        size:
                                            filterSectectedProductDetail
                                                .detailVariant
                                                .size,
                                        stockQuantity:
                                            filterSectectedProductDetail
                                                .detailVariant
                                                .stockQuantity,
                                      ),
                                      salePrice:
                                          filterSectectedProductDetail
                                              .salePrice,
                                    ),
                                    isChecked: false,
                                    quantity: 1,
                                  ),
                                ),
                              );
                            }
                          },
                          style: TextButton.styleFrom(
                            backgroundColor:
                                isDarkMode
                                    ? ColorDark.buttonBackground
                                    : ColorLight.buttonBackground,
                            foregroundColor:
                                isDarkMode
                                    ? ColorDark.buttonText
                                    : ColorLight.buttonText,
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: responsive.setWidth(16),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text('Add to cart'),
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor:
                              isDarkMode
                                  ? ColorDark.buttonBackground
                                  : ColorLight.buttonBackground,
                          foregroundColor:
                              isDarkMode
                                  ? ColorDark.buttonText
                                  : ColorLight.buttonText,
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: responsive.setWidth(16),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text('Add to cart'),
                      ),
                    );
                  }
                },
              ),
            ),
            body: BlocConsumer<ProductBloc, ProductState>(
              listener: (context, state) {
                if (state is LoadingProduct) {
                  showLoadingDialog(context: context);
                } else if (state is ErrorProduct) {
                  context.router.pop();
                  showToast(
                    msg: state.message,
                    textColor: isDarkMode ? ColorDark.error : ColorLight.error,
                    backgroundColor:
                        isDarkMode
                            ? ColorDark.background2
                            : ColorLight.background2,
                  );
                } else {
                  context.router.pop();
                }
              },
              builder: (context, state) {
                if (state is LoadedProduct) {
                  final product = state.productEntity;
                  return Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Image with overlay icons
                            Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height:
                                      screenHeight *
                                      0.38, // Responsive image height
                                  decoration: BoxDecoration(
                                    color:
                                        isDarkMode
                                            ? ColorDark.background2
                                            : ColorLight.background2,
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(32),
                                      bottomRight: Radius.circular(32),
                                    ),
                                  ),
                                  child: PageView.builder(
                                    controller: pageController,
                                    onPageChanged: _onPageChanged,
                                    itemCount: product.images.length,
                                    itemBuilder: (context, index) {
                                      return Image.network(
                                        product.images[index].url,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: screenHeight * 0.38,
                                      );
                                    },
                                  ),
                                ),
                                Positioned(
                                  top: 40,
                                  left: 16,
                                  child: CircleAvatar(
                                    backgroundColor:
                                        isDarkMode
                                            ? ColorDark.background
                                            : ColorLight.background,
                                    child: IconButton(
                                      icon: const Icon(Icons.arrow_back),
                                      color:
                                          isDarkMode
                                              ? ColorDark.iconPrimary
                                              : ColorLight.iconPrimary,
                                      onPressed: () => context.router.pop(),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 40,
                                  right: 16,
                                  child: CircleAvatar(
                                    backgroundColor:
                                        isDarkMode
                                            ? ColorDark.background
                                            : ColorLight.background,
                                    child: IconButton(
                                      icon: Icon(
                                        // product['isFavorite']
                                        //     ? Icons.favorite :
                                        Icons.favorite_border,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Product Info Card
                            Transform.translate(
                              offset: const Offset(0, -32),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      screenWidth *
                                      0.06, // Responsive horizontal padding
                                  vertical:
                                      screenHeight *
                                      0.03, // Responsive vertical padding
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      isDarkMode
                                          ? ColorDark.background
                                          : ColorLight.background,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(32),
                                    topRight: Radius.circular(32),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      blurRadius: 12,
                                      offset: const Offset(0, -2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            screenWidth *
                                            0.05, // Responsive font size
                                        color:
                                            isDarkMode
                                                ? ColorDark.titleText
                                                : ColorLight.titleText,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    SizedBox(height: screenHeight * 0.01),
                                    double.parse(product.price) >
                                            product.salePrice
                                        ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              '\$ ${double.parse(product.price).toStringAsFixed(2)}',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: screenWidth * 0.025,
                                                fontWeight: FontWeight.w600,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                            SizedBox(
                                              width: responsive.setWidth(5),
                                            ),
                                            Text(
                                              '\$ ${product.salePrice.toStringAsFixed(2)}',
                                              style: TextStyle(
                                                color:
                                                    isDarkMode
                                                        ? ColorDark.sectionTitle
                                                        : ColorLight
                                                            .sectionTitle,
                                                fontSize: screenWidth * 0.05,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        )
                                        : Text(
                                          '\$ ${double.parse(product.price).toStringAsFixed(2)}',
                                          style: TextStyle(
                                            color:
                                                isDarkMode
                                                    ? ColorDark.sectionTitle
                                                    : ColorLight.sectionTitle,
                                            fontSize: screenWidth * 0.05,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                    SizedBox(height: screenHeight * 0.01),
                                    Row(
                                      children: [
                                        ...List.generate(
                                          5,
                                          (i) => Icon(
                                            Icons.star,
                                            color: ColorLight.success,
                                            size:
                                                screenWidth *
                                                0.045, // Responsive icon size
                                          ),
                                        ),
                                        SizedBox(width: screenWidth * 0.01),
                                        Text(
                                          '(${product.reviewCount})',
                                          style: TextStyle(
                                            fontSize: screenWidth * 0.035,
                                            color:
                                                isDarkMode
                                                    ? ColorDark.subtitleText
                                                    : ColorLight.subtitleText,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: screenHeight * 0.025),
                                    product.colors.isNotEmpty
                                        ? SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              Text(
                                                'Color',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: screenWidth * 0.04,
                                                ),
                                              ),
                                              SizedBox(
                                                width: screenWidth * 0.02,
                                              ),
                                              ...List.generate(
                                                product.colors.length,
                                                (i) => Padding(
                                                  padding: EdgeInsets.only(
                                                    right: screenWidth * 0.02,
                                                  ),
                                                  child: ChoiceChip(
                                                    label: Text(
                                                      product.colors[i],
                                                    ),
                                                    selected:
                                                        i == selectedColor,
                                                    onSelected: (_) {
                                                      if (product.productDetails
                                                          .where(
                                                            (productDetail) =>
                                                                (productDetail
                                                                        .detailVariant
                                                                        .color ==
                                                                    product
                                                                        .colors[i]
                                                                // && productDetail
                                                                //         .detailVariant
                                                                //         .stockQuantity >
                                                                //     0
                                                                ),
                                                          )
                                                          .isEmpty) {
                                                        return;
                                                      }
                                                      setState(() {
                                                        selectedColor = i;
                                                        selectedColorValue =
                                                            product.colors[i];
                                                      });
                                                    },
                                                    selectedColor:
                                                        isDarkMode
                                                            ? ColorDark
                                                                .buttonBackground
                                                            : ColorLight
                                                                .buttonBackground,
                                                    labelStyle: TextStyle(
                                                      fontSize:
                                                          screenWidth * 0.035,
                                                      color:
                                                          i == selectedColor
                                                              ? (isDarkMode
                                                                  ? ColorDark
                                                                      .buttonText
                                                                  : ColorLight
                                                                      .buttonText)
                                                              : (isDarkMode
                                                                  ? ColorDark
                                                                      .buttonBackground
                                                                  : ColorLight
                                                                      .buttonBackground),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                        : Container(),
                                    product.sizes.isNotEmpty
                                        ? SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              Text(
                                                'Size',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: screenWidth * 0.04,
                                                ),
                                              ),
                                              SizedBox(
                                                width: screenWidth * 0.02,
                                              ),
                                              ...List.generate(
                                                product.sizes.length,
                                                (i) => Padding(
                                                  padding: EdgeInsets.only(
                                                    right: screenWidth * 0.02,
                                                  ),
                                                  child: ChoiceChip(
                                                    label: Text(
                                                      product.sizes[i],
                                                    ),
                                                    selected: i == selectedSize,
                                                    onSelected: (_) {
                                                      if (product.productDetails
                                                          .where(
                                                            (productDetail) =>
                                                                (productDetail
                                                                        .detailVariant
                                                                        .size ==
                                                                    product
                                                                        .sizes[i]
                                                                // && productDetail
                                                                //         .detailVariant
                                                                //         .stockQuantity >
                                                                //     0
                                                                ),
                                                          )
                                                          .isEmpty) {
                                                        return;
                                                      }
                                                      setState(() {
                                                        selectedSize = i;
                                                        selectedSizeValue =
                                                            product.sizes[i];
                                                      });
                                                    },
                                                    selectedColor:
                                                        isDarkMode
                                                            ? ColorDark
                                                                .buttonBackground
                                                            : ColorLight
                                                                .buttonBackground,
                                                    labelStyle: TextStyle(
                                                      fontSize:
                                                          screenWidth * 0.035,
                                                      color:
                                                          i == selectedSize
                                                              ? (isDarkMode
                                                                  ? ColorDark
                                                                      .buttonText
                                                                  : ColorLight
                                                                      .buttonText)
                                                              : (isDarkMode
                                                                  ? ColorDark
                                                                      .buttonBackground
                                                                  : ColorLight
                                                                      .buttonBackground),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                        : Container(),
                                    SizedBox(height: screenHeight * 0.03),
                                    const Divider(),
                                    // Description
                                    ExpansionTile(
                                      initiallyExpanded: descriptionExpanded,
                                      title: const Text(
                                        'Description',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      children: [
                                        Text(
                                          product.description,
                                          style: TextStyle(
                                            color:
                                                isDarkMode
                                                    ? ColorDark.subtitleText
                                                    : ColorLight.subtitleText,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: TextButton(
                                            onPressed: () {},
                                            style: TextButton.styleFrom(
                                              padding: EdgeInsets.zero,
                                            ),
                                            child: const Text('Read more'),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                    // Reviews
                                    ExpansionTile(
                                      initiallyExpanded: reviewsExpanded,
                                      title: const Text(
                                        'Reviews',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 8.0,
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                '4.9',
                                                style: TextStyle(
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      ...List.generate(
                                                        5,
                                                        (i) => Icon(
                                                          Icons.star,
                                                          color:
                                                              ColorLight
                                                                  .success,
                                                          size: 18,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    product.reviewCount
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          isDarkMode
                                                              ? ColorDark
                                                                  .subtitleText
                                                              : ColorLight
                                                                  .subtitleText,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Ratings breakdown
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 8.0,
                                          ),
                                          child: Column(
                                            children: [
                                              _buildRatingBar(
                                                '5',
                                                0.8,
                                                isDarkMode,
                                              ),
                                              _buildRatingBar(
                                                '4',
                                                0.12,
                                                isDarkMode,
                                              ),
                                              _buildRatingBar(
                                                '3',
                                                0.05,
                                                isDarkMode,
                                              ),
                                              _buildRatingBar(
                                                '2',
                                                0.03,
                                                isDarkMode,
                                              ),
                                              _buildRatingBar(
                                                '1',
                                                0.0,
                                                isDarkMode,
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Reviews
                                        ListTile(
                                          leading: const CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              'https://randomuser.me/api/portraits/women/1.jpg',
                                            ),
                                          ),
                                          title: const Text('Jennifer Rose'),
                                          subtitle: const Text(
                                            'I love it. Awesome customer service! Helped me out with adding an additional item to my order. Thanks again!',
                                          ),
                                          trailing: Text(
                                            '5m ago',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color:
                                                  isDarkMode
                                                      ? ColorDark.subtitleText
                                                      : ColorLight.subtitleText,
                                            ),
                                          ),
                                        ),
                                        ListTile(
                                          leading: const CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              'https://randomuser.me/api/portraits/women/2.jpg',
                                            ),
                                          ),
                                          title: const Text('Kelly Rihana'),
                                          subtitle: const Text(
                                            'I’m very happy with order, it was delivered on and good quality. Recommended!',
                                          ),
                                          trailing: Text(
                                            '9m ago',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color:
                                                  isDarkMode
                                                      ? ColorDark.subtitleText
                                                      : ColorLight.subtitleText,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return Container();
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildRatingBar(String label, double percent, bool isDarkMode) {
    return Row(
      children: [
        SizedBox(width: 18, child: Text(label)),
        const SizedBox(width: 4),
        Expanded(
          child: LinearProgressIndicator(
            value: percent,
            backgroundColor:
                isDarkMode
                    ? ColorDark.chipBackground
                    : ColorLight.chipBackground,
            valueColor: AlwaysStoppedAnimation<Color>(ColorLight.success),
            minHeight: 8,
          ),
        ),
        const SizedBox(width: 8),
        Text('${(percent * 100).toInt()}%', style: TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildSimilarProductCard({
    required String image,
    required String name,
    required double price,
    required bool isDarkMode,
    double cardWidth = 110,
    double imageHeight = 60,
  }) {
    return Container(
      width: cardWidth,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: isDarkMode ? ColorDark.background2 : ColorLight.background2,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.network(
              image,
              height: imageHeight,
              width: cardWidth,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: cardWidth * 0.07),
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: cardWidth * 0.12,
              color: isDarkMode ? ColorDark.titleText : ColorLight.titleText,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: cardWidth * 0.04),
          Text(
            ' 24${price.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: cardWidth * 0.12,
              color: isDarkMode ? ColorDark.titleText : ColorLight.titleText,
            ),
          ),
        ],
      ),
    );
  }
}
