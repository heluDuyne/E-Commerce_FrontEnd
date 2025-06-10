import 'package:e_commerce_frontend/scr/core/utils/mapper/data_mapper.dart';
import 'package:e_commerce_frontend/scr/domain/entities/product_image_entity/product_image_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_image_response_model.g.dart';

@JsonSerializable()
class ProductImageResponseModel extends DataMapper<ProductImageEntity> {
  final int? id;
  final String? url;
  @JsonKey(name: 'product')
  final int? productId;
  final bool? isPrimary;

  ProductImageResponseModel({
    required this.id,
    required this.url,
    required this.productId,
    required this.isPrimary,
  });

  factory ProductImageResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ProductImageResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductImageResponseModelToJson(this);

  @override
  ProductImageEntity mapToEntity() {
    return ProductImageEntity(
      id: id ?? 0,
      url: url ?? '',
      productId: productId ?? 0,
      isPrimary: isPrimary ?? false,
    );
  }
}
