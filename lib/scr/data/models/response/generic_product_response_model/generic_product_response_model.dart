import 'package:e_commerce_frontend/scr/core/utils/mapper/data_mapper.dart';
import 'package:e_commerce_frontend/scr/data/models/response/product_image_response_model/product_image_response_model.dart';
import 'package:e_commerce_frontend/scr/domain/entities/generic_product_entity/generic_product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generic_product_response_model.g.dart';

@JsonSerializable()
class GenericProductResponseModel extends DataMapper<GenericProductEntity>{
  final int? id;
  final String? name;
  final List<ProductImageResponseModel> images;
  @JsonKey(name: 'average_rating')
  final String? averageRating;
  @JsonKey(name: 'review_count')
  final int? reviewCount;
  final String? price;
  @JsonKey(name: 'sale_price')
  final String? salePrice;
  @JsonKey(name: 'original_price')
  final String? originalPrice;

  GenericProductResponseModel({
        required this.id,
        required this.name,
        required this.images,
        required this.averageRating,
        required this.reviewCount,
        required this.price,
        required this.salePrice,
        required this.originalPrice,
    });

  factory GenericProductResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GenericProductResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$GenericProductResponseModelToJson(this);

  @override
  GenericProductEntity mapToEntity() {
    return GenericProductEntity(
      id: id ?? 0,
      name: name ?? '',
      images: images.map((image) => image.mapToEntity()).toList(),
      averageRating: averageRating ?? '0',
      reviewCount: reviewCount ?? 0,
      price: price ?? '0',
      salePrice: salePrice ?? '0',
      originalPrice: originalPrice ?? '0',
    );
  }
}
