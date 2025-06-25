import 'package:e_commerce_frontend/scr/core/common_domain/entities/based_api_result/api_result_model.dart';
import 'package:e_commerce_frontend/scr/data/datasources/cart_datasource/cart_datasource.dart';
import 'package:e_commerce_frontend/scr/data/models/request/cart_item_request_model/cart_item_request_model.dart';
import 'package:e_commerce_frontend/scr/data/repositories/base_repository.dart';
import 'package:e_commerce_frontend/scr/domain/entities/cart_entity/cart_item_entity.dart';
import 'package:e_commerce_frontend/scr/domain/entities/cart_entity/cart_item_pagination_entity.dart';
import 'package:e_commerce_frontend/scr/domain/repositories/cart_repository.dart';

class CartRepositoryImp extends BaseRepository implements CartRepository {
  final CartDatasource datasource;
  CartRepositoryImp({required this.datasource});
  @override
  Future<ApiResultModel<CartItemPaginationEntity>> getListCartItem() {
    return baseExecute(() async {
      var result = await datasource.getListCartItem();
      return result.mapToEntity();
    });
  }

  @override
  Future<ApiResultModel<CartItemPaginationEntity>> getListCartItemByUrl(String path) {
    return baseExecute(() async {
      var result = await datasource.getListCartItemByUrl(path);
      return result.mapToEntity();
    });
  }

  @override
  Future<ApiResultModel<CartItemEntity>> addProductToCart(CartItemRequestModel cartItemRequestModel) {
    return baseExecute(() async {
      var result = await datasource.addProductToCart(cartItemRequestModel);
      return result.mapToEntity();
    });
  }

  @override
  Future<ApiResultModel<CartItemEntity>> updateCartItem(int id, CartItemRequestModel cartItemRequestModel) {
    return baseExecute(() async {
      var result = await datasource.updateCartItem(id, cartItemRequestModel);
      return result.mapToEntity();
    });
  }
}