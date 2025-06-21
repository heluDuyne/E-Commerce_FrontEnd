import 'package:e_commerce_frontend/scr/core/utils/mapper/data_mapper.dart';
import 'package:e_commerce_frontend/scr/domain/entities/product_variant_entity/product_variant_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_variant_response_model.g.dart';

@JsonSerializable()
class ProductVariantResponseModel extends DataMapper<ProductVariantEntity> {
  final int? id;
  final int? product;
  final String? color;
  final String? size;
  @JsonKey(name: 'stock_quantity')
  final int? stockQuantity;

  ProductVariantResponseModel({
    required this.id,
    required this.product,
    required this.color,
    required this.size,
    required this.stockQuantity,
  });

  @override
  ProductVariantEntity mapToEntity() {
    return ProductVariantEntity(
      id: id ?? 0,
      product: product ?? 0,
      color: color ?? '',
      size: size ?? '',
      stockQuantity: stockQuantity ?? 0,
    );
  }

  factory ProductVariantResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductVariantResponseModelToJson(this);
}
