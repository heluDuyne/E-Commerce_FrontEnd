import 'package:e_commerce_frontend/scr/data/models/request/product_variant_request_model/product_variant_request_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_detail_resquest_model.g.dart';

@JsonSerializable()
class ProductDetailResquestModel {
  final int? product;
  final String? price;
  @JsonKey(name: 'detail_variant')
  final ProductVariantRequestModel? detailVariant;
  @JsonKey(name: 'sale_price')
  final String? salePrice;

  ProductDetailResquestModel({
    required this.product,
    required this.price,
    required this.detailVariant,
    required this.salePrice,
  });

  factory ProductDetailResquestModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailResquestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailResquestModelToJson(this);
}