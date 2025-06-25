import 'package:json_annotation/json_annotation.dart';

part 'product_variant_request_model.g.dart';

@JsonSerializable()
class ProductVariantRequestModel {
  final int? id;
  final int? product;
  final String? color;
  final String? size;
  @JsonKey(name: 'stock_quantity')
  final int? stockQuantity;

  ProductVariantRequestModel({
    required this.id,
    required this.product,
    required this.color,
    required this.size,
    required this.stockQuantity,
  });

  factory ProductVariantRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductVariantRequestModelToJson(this);
}