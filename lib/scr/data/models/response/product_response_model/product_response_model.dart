import 'package:e_commerce_frontend/scr/core/common_domain/enum/currency_enum.dart';
import 'package:e_commerce_frontend/scr/core/common_domain/enum/weight_unit_enum.dart';
import 'package:e_commerce_frontend/scr/core/utils/mapper/data_mapper.dart';
import 'package:e_commerce_frontend/scr/data/models/response/category_response_model/category_response_model.dart';
import 'package:e_commerce_frontend/scr/data/models/response/product_detail_info_response_model/product_detail_info_response_model.dart';
import 'package:e_commerce_frontend/scr/data/models/response/product_detail_response_model/product_detail_response_model.dart';
import 'package:e_commerce_frontend/scr/data/models/response/product_image_response_model/product_image_response_model.dart';
import 'package:e_commerce_frontend/scr/domain/entities/product_entity/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_response_model.g.dart';

@JsonSerializable()
class ProductResponseModel extends DataMapper<ProductEntity> {
  final int? id;
  final String? name;
  final List<ProductImageResponseModel>? images;
  @JsonKey(name: 'average_rating')
  final String? averageRating;
  @JsonKey(name: 'review_count')
  final int? reviewCount;
  final String? price;
  @JsonKey(name: "sale_price")
  final double? salePrice;
  @JsonKey(name: 'product_details')
  final List<ProductDetailResponseModel>? productDetails;
  final String? description;
  final String? material;
  final String? weight;
  @JsonKey(
    name: 'weight_unit',
    fromJson: _weightUnitFromJson,
    toJson: _weightUnitToJson)
  final WeightUnitEnum? weightUnit;
  @JsonKey(name: 'stock_quantity')
  final int? stockQuantity;
  @JsonKey(name: 'node_name')
  final String? nodeName;
  final String? style;
  @JsonKey(
    fromJson: _currencyFromJson,
    toJson: _currencyToJson,
  )
  final CurrencyEnum? currency;
  final List<ProductDetailInfoResponseModel>? detailInformation;
  final List<CategoryResponseModel>? categories;
  final List<String>? colors;
  final List<String>? sizes;

  ProductResponseModel({
    required this.id,
    required this.name,
    required this.images,
    required this.averageRating,
    required this.reviewCount,
    required this.price,
    required this.salePrice,
    required this.productDetails,
    required this.description,
    required this.material,
    required this.weight,
    required this.weightUnit,
    required this.stockQuantity,
    required this.nodeName,
    required this.style,
    required this.currency,
    required this.detailInformation,
    required this.categories,
    required this.colors,
    required this.sizes,
  });

  @override
  ProductEntity mapToEntity() {
    return ProductEntity(
      id: id ?? 0,
      name: name ?? '',
      images: images?.map((image) => image.mapToEntity()).toList() ?? [],
      averageRating: averageRating ?? '',
      reviewCount: reviewCount ?? 0,
      price: price ?? '',
      salePrice: salePrice ?? 0,
      productDetails:
          productDetails?.map((detail) => detail.mapToEntity()).toList() ?? [],
      description: description ?? '',
      material: material ?? '',
      weight: weight ?? '',
      weightUnit: weightUnit ?? WeightUnitEnum.kg,
      stockQuantity: stockQuantity ?? 0,
      nodeName: nodeName ?? '',
      style: style ?? '',
      currency: currency ?? CurrencyEnum.usd,
      detailInformation:
          detailInformation?.map((info) => info.mapToEntity()).toList() ?? [],
      categories:
          categories?.map((category) => category.mapToEntity()).toList() ?? [],
      colors: colors ?? [],
      sizes: sizes ?? [],
    );
  }

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductResponseModelToJson(this);

  static _weightUnitFromJson(String? code) {
    if (code == null) return null;
    return WeightUnitEnum.values.firstWhere(
      (weightUnit) => weightUnit.code == code,
      orElse: () => WeightUnitEnum.kg,
    );
  }

  static String? _weightUnitToJson(WeightUnitEnum? weightUnit) => weightUnit?.code;

  static _currencyFromJson(String? code) {
    if (code == null) return null;
    return CurrencyEnum.values.firstWhere(
      (currency) => currency.code == code,
      orElse: () => CurrencyEnum.usd,
    );
  }

  static String? _currencyToJson(CurrencyEnum? currency) => currency?.code;
}
