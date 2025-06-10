import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_image_entity.g.dart';

@JsonSerializable()
class ProductImageEntity extends Equatable{
    final int id;
    final String url;
    final int productId;
    final bool isPrimary;

    const ProductImageEntity({
        required this.id,
        required this.url,
        required this.productId,
        required this.isPrimary,
    });

    @override
    List<Object?> get props => <Object?>[id, url, productId, isPrimary];
    
    ProductImageEntity copyWith({
        int? id,
        String? url,
        int? productId,
        bool? isPrimary,
    }) {
        return ProductImageEntity(
            id: id ?? this.id,
            url: url ?? this.url,
            productId: productId ?? this.productId,
            isPrimary: isPrimary ?? this.isPrimary,
        );
    }

    factory ProductImageEntity.fromJson(Map<String, dynamic> json) =>
        _$ProductImageEntityFromJson(json);
    Map<String, dynamic> toJson() => _$ProductImageEntityToJson(this);
}
