import 'package:e_commerce_frontend/scr/core/utils/mapper/data_mapper.dart';
import 'package:e_commerce_frontend/scr/data/models/response/cart_response_model/cart_response_model.dart';
import 'package:e_commerce_frontend/scr/data/models/response/generic_product_response_model/generic_product_response_model.dart';
import 'package:e_commerce_frontend/scr/data/models/response/product_detail_response_model/product_detail_response_model.dart';
import 'package:e_commerce_frontend/scr/domain/entities/cart_entity/cart_entity.dart';
import 'package:e_commerce_frontend/scr/domain/entities/cart_entity/cart_item_entity.dart';
import 'package:e_commerce_frontend/scr/domain/entities/generic_product_entity/generic_product_entity.dart';
import 'package:e_commerce_frontend/scr/domain/entities/product_detail_entity/product_detail_entity.dart';
import 'package:e_commerce_frontend/scr/domain/entities/product_variant_entity/product_variant_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_item_response_model.g.dart';

@JsonSerializable()
class CartItemResponseModel extends DataMapper<CartItemEntity> {
  final int? id;
  final CartResponseModel? cart;
  @JsonKey(name: 'generic_product_info')
  final GenericProductResponseModel? genericProductInfo;
  @JsonKey(name: 'product_detail')
  final ProductDetailResponseModel? productDetail;
  @JsonKey(name: 'is_checked')
  final bool? isChecked;
  @JsonKey(name: 'update_date')
  final DateTime? updateDate;
  final int? quantity;

  CartItemResponseModel({
    required this.id,
    required this.cart,
    required this.genericProductInfo,
    required this.productDetail,
    required this.isChecked,
    required this.updateDate,
    required this.quantity,
  });

  factory CartItemResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemResponseModelToJson(this);

  @override
  CartItemEntity mapToEntity() {
    return CartItemEntity(
      id: id ?? 0,
      cart: cart?.mapToEntity() ?? CartEntity(id: 0, user: 0),
      genericProductInfo:
          genericProductInfo?.mapToEntity() ??
          GenericProductEntity(
            id: 0,
            name: '',
            images: [],
            averageRating: '',
            reviewCount: 0,
            price: '',
            salePrice: 0,
            originalPrice: 0,
          ),
      productDetail:
          productDetail?.mapToEntity() ??
          ProductDetailEntity(
            id: 0,
            product: 0,
            price: '',
            detailVariant: ProductVariantEntity(
              id: 0,
              product: 0,
              color: '',
              size: '',
              stockQuantity: 0,
            ),
            salePrice: '',
          ),
      isChecked: isChecked ?? false,
      updateDate: updateDate ?? DateTime.now(),
      quantity: quantity ?? 0,
    );
  }
}
