import 'package:e_commerce_frontend/scr/domain/entities/product_image_entity/product_image_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generic_product_entity.g.dart';

@JsonSerializable()
class GenericProductEntity extends Equatable {
  final int id;
  final String name;
  final List<ProductImageEntity> images;
  final String averageRating;
  final int reviewCount;
  final String price;
  final double salePrice;
  final double originalPrice;

  const GenericProductEntity({
    required this.id,
    required this.name,
    required this.images,
    required this.averageRating,
    required this.reviewCount,
    required this.price,
    required this.salePrice,
    required this.originalPrice,
  });

  @override
  List<Object?> get props => <Object?>[
    id,
    name,
    images,
    averageRating,
    reviewCount,
    price,
    salePrice,
    originalPrice,
  ];

  GenericProductEntity copyWith({
    int? id,
    String? name,
    List<ProductImageEntity>? images,
    String? averageRating,
    int? reviewCount,
    String? price,
    double? salePrice,
    double? originalPrice,
  }) {
    return GenericProductEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      images: images ?? this.images,
      averageRating: averageRating ?? this.averageRating,
      reviewCount: reviewCount ?? this.reviewCount,
      price: price ?? this.price,
      salePrice: salePrice ?? this.salePrice,
      originalPrice: originalPrice ?? this.originalPrice,
    );
  }

  factory GenericProductEntity.fromJson(Map<String, dynamic> json) =>
      _$GenericProductEntityFromJson(json);
  Map<String, dynamic> toJson() => _$GenericProductEntityToJson(this);
}
