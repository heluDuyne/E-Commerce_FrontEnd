import 'package:e_commerce_frontend/scr/core/common_domain/entities/based_api_result/api_result_model.dart';
import 'package:e_commerce_frontend/scr/data/models/request/cart_item_request_model/cart_item_request_model.dart';
import 'package:e_commerce_frontend/scr/domain/entities/cart_entity/cart_item_entity.dart';
import 'package:e_commerce_frontend/scr/domain/entities/cart_entity/cart_item_pagination_entity.dart';

abstract class CartRepository {
  Future<ApiResultModel<CartItemPaginationEntity>> getListCartItem();
  Future<ApiResultModel<CartItemPaginationEntity>> getListCartItemByUrl(String path);
  Future<ApiResultModel<CartItemEntity>> addProductToCart(CartItemRequestModel cartItemRequestModel);
  Future<ApiResultModel<CartItemEntity>> updateCartItem(int id, CartItemRequestModel cartItemRequestModel);
}