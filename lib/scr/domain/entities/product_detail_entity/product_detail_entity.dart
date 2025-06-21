import 'package:e_commerce_frontend/scr/domain/entities/product_variant_entity/product_variant_entity.dart';
import 'package:equatable/equatable.dart';

class ProductDetailEntity extends Equatable {
  final int id;
  final int product;
  final String price;
  final ProductVariantEntity detailVariant;
  final String salePrice;

  const ProductDetailEntity({
    required this.id,
    required this.product,
    required this.price,
    required this.detailVariant,
    required this.salePrice,
  });

  @override
  List<Object?> get props => [id, product, price, detailVariant, salePrice];
}
