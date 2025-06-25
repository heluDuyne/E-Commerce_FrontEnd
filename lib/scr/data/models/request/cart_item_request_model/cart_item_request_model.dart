import 'package:e_commerce_frontend/scr/data/models/request/product_detail_resquest_model/product_detail_resquest_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_item_request_model.g.dart';

@JsonSerializable()
class CartItemRequestModel {
  @JsonKey(name: 'product_detail')
  final ProductDetailResquestModel productDetail;
  @JsonKey(name: 'is_checked')
  final bool? isChecked;
  final int? quantity;

  CartItemRequestModel({
    required this.productDetail,
    required this.isChecked,
    required this.quantity,
  });
  factory CartItemRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemRequestModelToJson(this);
}