import 'package:e_commerce_frontend/scr/core/common_domain/entities/based_api_result/api_result_model.dart';
import 'package:e_commerce_frontend/scr/core/common_domain/usecases/base_params_usecase.dart';
import 'package:e_commerce_frontend/scr/domain/entities/cart_entity/cart_item_pagination_entity.dart';
import 'package:e_commerce_frontend/scr/domain/repositories/cart_repository.dart';

class GetListCartItemByUrlUsecase extends BaseParamsUsecase<CartItemPaginationEntity, String>{
  final CartRepository repository;
  GetListCartItemByUrlUsecase({required this.repository});
  @override
  Future<ApiResultModel<CartItemPaginationEntity>> call(String params) {
    return repository.getListCartItemByUrl(params);
  }
}