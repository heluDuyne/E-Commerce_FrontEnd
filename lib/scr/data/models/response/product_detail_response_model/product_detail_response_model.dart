import 'package:e_commerce_frontend/scr/core/utils/mapper/data_mapper.dart';
import 'package:e_commerce_frontend/scr/data/models/response/product_variant_response_model/product_variant_response_model.dart';
import 'package:e_commerce_frontend/scr/domain/entities/product_detail_entity/product_detail_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_detail_response_model.g.dart';

@JsonSerializable()
class ProductDetailResponseModel extends DataMapper<ProductDetailEntity> {
  final int? id;
  final int? product;
  final String? price;
  @JsonKey(name: 'detail_variant')
  final ProductVariantResponseModel? detailVariant;
  @JsonKey(name: 'sale_price')
  final String? salePrice;

  ProductDetailResponseModel({
    required this.id,
    required this.product,
    required this.price,
    required this.detailVariant,
    required this.salePrice,
  });

  @override
  ProductDetailEntity mapToEntity() {
    return ProductDetailEntity(
      id: id ?? 0,
      product: product ?? 0,
      price: price ?? '',
      detailVariant: detailVariant?.mapToEntity() ?? ProductVariantResponseModel(
        id: 0,
        product: 0,
        color: '',
        size: '',
        stockQuantity: 0,
      ).mapToEntity(),
      salePrice: salePrice ?? '',
    );
  }
  factory ProductDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductDetailResponseModelToJson(this);
}
