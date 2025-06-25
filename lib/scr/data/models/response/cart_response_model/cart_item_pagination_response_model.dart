import 'package:e_commerce_frontend/scr/core/utils/mapper/data_mapper.dart';
import 'package:e_commerce_frontend/scr/data/models/response/cart_response_model/cart_item_response_model.dart';
import 'package:e_commerce_frontend/scr/domain/entities/cart_entity/cart_item_pagination_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_item_pagination_response_model.g.dart';

@JsonSerializable()
class CartItemPaginationResponseModel
    extends DataMapper<CartItemPaginationEntity> {
  final int? count;
  final String? next;
  final String? previous;
  final List<CartItemResponseModel>? results;

  CartItemPaginationResponseModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory CartItemPaginationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemPaginationResponseModelFromJson(json);
  Map<String, dynamic> toJson() =>
      _$CartItemPaginationResponseModelToJson(this);

  @override
  CartItemPaginationEntity mapToEntity() {
    return CartItemPaginationEntity(
      count: count ?? 0,
      next: next ?? '',
      previous: previous ?? '',
      results: results?.map((item) => item.mapToEntity()).toList() ?? [],
    );
  }
}
