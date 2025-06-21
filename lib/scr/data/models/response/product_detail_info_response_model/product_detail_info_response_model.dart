import 'package:e_commerce_frontend/scr/core/utils/mapper/data_mapper.dart';
import 'package:e_commerce_frontend/scr/domain/entities/product_detail_info_entity/product_detail_info_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_detail_info_response_model.g.dart';

@JsonSerializable()
class ProductDetailInfoResponseModel
    extends DataMapper<ProductDetailInfoEntity> {
  final int? id;
  final int? product;
  @JsonKey(name: "detail_name")
  final String? detailName;
  @JsonKey(name: "detail_value")
  final String? detailValue;

  ProductDetailInfoResponseModel({
    required this.id,
    required this.product,
    required this.detailName,
    required this.detailValue,
  });

  @override
  ProductDetailInfoEntity mapToEntity() {
    return ProductDetailInfoEntity(
      id: id ?? 0,
      product: product ?? 0,
      detailName: detailName ?? '',
      detailValue: detailValue ?? '',
    );
  }

  factory ProductDetailInfoResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailInfoResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailInfoResponseModelToJson(this);
}
