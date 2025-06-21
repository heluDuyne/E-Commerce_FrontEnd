import 'package:e_commerce_frontend/scr/core/common_domain/enum/currency_enum.dart';
import 'package:e_commerce_frontend/scr/core/common_domain/enum/weight_unit_enum.dart';
import 'package:e_commerce_frontend/scr/domain/entities/category_entity/category_entity.dart';
import 'package:e_commerce_frontend/scr/domain/entities/product_detail_entity/product_detail_entity.dart';
import 'package:e_commerce_frontend/scr/domain/entities/product_detail_info_entity/product_detail_info_entity.dart';
import 'package:e_commerce_frontend/scr/domain/entities/product_image_entity/product_image_entity.dart';
import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final String name;
  final List<ProductImageEntity> images;
  final String averageRating;
  final int reviewCount;
  final String price;
  final double salePrice;
  final List<ProductDetailEntity> productDetails;
  final String description;
  final String material;
  final String weight;
  final WeightUnitEnum weightUnit;
  final int stockQuantity;
  final String nodeName;
  final String style;
  final CurrencyEnum currency;
  final List<ProductDetailInfoEntity> detailInformation;
  final List<CategoryEntity> categories;
  final List<String> colors;
  final List<String> sizes;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.images,
    required this.averageRating,
    required this.reviewCount,
    required this.price,
    required this.salePrice,
    required this.productDetails,
    required this.description,
    required this.material,
    required this.weight,
    required this.weightUnit,
    required this.stockQuantity,
    required this.nodeName,
    required this.style,
    required this.currency,
    required this.detailInformation,
    required this.categories,
    required this.colors,
    required this.sizes,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    images,
    averageRating,
    reviewCount,
    price,
    salePrice,
    productDetails,
    description,
    material,
    weight,
    weightUnit,
    stockQuantity,
    nodeName,
    style,
    currency,
    detailInformation,
    categories,
    colors,
    sizes,
  ];
}
