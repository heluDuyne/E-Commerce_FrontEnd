import 'package:e_commerce_frontend/scr/core/common_domain/entities/based_api_result/api_result_model.dart';
import 'package:e_commerce_frontend/scr/core/common_domain/usecases/base_params_usecase.dart';
import 'package:e_commerce_frontend/scr/data/models/request/cart_item_request_model/cart_item_request_model.dart';
import 'package:e_commerce_frontend/scr/domain/entities/cart_entity/cart_item_entity.dart';
import 'package:e_commerce_frontend/scr/domain/repositories/cart_repository.dart';

class AddProductToCartUsecase extends BaseParamsUsecase<CartItemEntity, CartItemRequestModel>{
  final CartRepository repository;
  AddProductToCartUsecase({required this.repository});
  @override
  Future<ApiResultModel<CartItemEntity>> call(CartItemRequestModel params) {
    return repository.addProductToCart(params);
  }
}