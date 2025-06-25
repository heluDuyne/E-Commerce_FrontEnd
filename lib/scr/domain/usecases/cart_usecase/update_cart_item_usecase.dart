import 'package:e_commerce_frontend/scr/core/common_domain/entities/based_api_result/api_result_model.dart';
import 'package:e_commerce_frontend/scr/core/common_domain/usecases/base_params_usecase.dart';
import 'package:e_commerce_frontend/scr/data/models/request/update_cart_item_request_model/update_cart_item_request_model.dart';
import 'package:e_commerce_frontend/scr/domain/entities/cart_entity/cart_item_entity.dart';
import 'package:e_commerce_frontend/scr/domain/repositories/cart_repository.dart';

class UpdateCartItemUsecase
    extends BaseParamsUsecase<CartItemEntity, UpdateCartItemRequestModel> {
  final CartRepository repository;
  UpdateCartItemUsecase({required this.repository});
  @override
  Future<ApiResultModel<CartItemEntity>> call(
    UpdateCartItemRequestModel params,
  ) {
    return repository.updateCartItem(params.id, params.cartItem);
  }
}
