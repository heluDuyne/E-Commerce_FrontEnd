import 'package:e_commerce_frontend/scr/data/models/request/cart_item_request_model/cart_item_request_model.dart';

class UpdateCartItemRequestModel {
  final int id;
  final CartItemRequestModel cartItem;

  UpdateCartItemRequestModel({
    required this.id,
    required this.cartItem,
  });
}