import 'package:e_commerce_frontend/scr/core/common_domain/entities/based_api_result/api_result_model.dart';
import 'package:e_commerce_frontend/scr/core/common_domain/usecases/base_params_usecase.dart';
import 'package:e_commerce_frontend/scr/domain/entities/generic_product_entity/generic_product_pagination_entity.dart';
import 'package:e_commerce_frontend/scr/domain/repositories/product_repository.dart';

class GetListProductUsecase extends BaseParamsUsecase<GenericProductPaginationEntity, NoParams>{
  final ProductRepository productRepository;
  GetListProductUsecase({required this.productRepository});
  @override
  Future<ApiResultModel<GenericProductPaginationEntity>> call(NoParams _) {
    return productRepository.getListProduct();
  }
}