import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_frontend/scr/core/utils/app_route/app_router.gr.dart';
import 'package:e_commerce_frontend/scr/presentation/bloc/recommendation/recommendation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_frontend/scr/core/utils/values/colors.dart';
import 'package:e_commerce_frontend/scr/core/utils/helpers/responsive_ui_helper/responsive_ui_config.dart';
import 'package:e_commerce_frontend/scr/presentation/widgets/product_item.dart';
import 'package:e_commerce_frontend/scr/core/utils/theme/theme_provider.dart';

@RoutePage()
class ProductFoundRecommendationScreen extends StatefulWidget {
  const ProductFoundRecommendationScreen({
    required this.screenTitle,
    this.showNumProduct = false,
    super.key,
  });
  final String screenTitle;
  final bool showNumProduct;

  @override
  State<ProductFoundRecommendationScreen> createState() =>
      _ProductFoundRecommendationScreenState();
}

class _ProductFoundRecommendationScreenState
    extends State<ProductFoundRecommendationScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch initial recommendations when the screen is loaded
    context.read<RecommendationBloc>().add(const FetchRecommendationEvent());
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final responsive = ResponsiveUiConfig(context);

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
          widget.screenTitle,
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
              widget.showNumProduct
                  ? Row(
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
                  )
                  : Container(),
              widget.showNumProduct ? SizedBox(height: 12) : Container(),
              BlocConsumer<RecommendationBloc, RecommendationState>(
                listener: (context, state) {
                  if (state is ErrorRecommendation) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Error loading recommedation prodducts"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is LoadedRecommendation) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(bottom: 24),
                      itemCount: state.listGenericProduct.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index) {
                        final product = state.listGenericProduct[index];
                        return Align(
                          alignment: Alignment.topCenter,
                          child: ProductItem(
                            imageUrl: product.images.first.url,
                            title: product.name,
                            price: product.originalPrice,
                            salePrice: product.salePrice,
                            isFavorite: false,
                            onTap: () {
                              context.router.push(
                                ProductFullRoute(productId: product.id),
                              );
                            },
                          ),
                        );
                      },
                    );
                  } else if (state is LoadingMoreRecommendation) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(bottom: 24),
                      itemCount: state.listGenericProduct.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index) {
                        final product = state.listGenericProduct[index];
                        return Align(
                          alignment: Alignment.topCenter,
                          child: ProductItem(
                            imageUrl: product.images.first.url,
                            title: product.name,
                            price: product.originalPrice,
                            salePrice: product.salePrice,
                            isFavorite: false,
                            onTap: () {
                              context.router.push(
                                ProductFullRoute(productId: product.id),
                              );
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
