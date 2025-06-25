import 'package:e_commerce_frontend/scr/core/utils/mapper/data_mapper.dart';
import 'package:e_commerce_frontend/scr/domain/entities/cart_entity/cart_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_response_model.g.dart';

@JsonSerializable()
class CartResponseModel extends DataMapper<CartEntity> {
  final int? id;
  final int? user;

  CartResponseModel({required this.id, required this.user});

  factory CartResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CartResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$CartResponseModelToJson(this);

  @override
  CartEntity mapToEntity() {
    return CartEntity(id: id ?? 0, user: user ?? 0);
  }
}
