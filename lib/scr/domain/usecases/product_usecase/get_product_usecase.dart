import 'package:e_commerce_frontend/scr/core/common_domain/entities/based_api_result/api_result_model.dart';
import 'package:e_commerce_frontend/scr/core/common_domain/usecases/base_params_usecase.dart';
import 'package:e_commerce_frontend/scr/domain/entities/product_entity/product_entity.dart';
import 'package:e_commerce_frontend/scr/domain/repositories/product_repository.dart';

class GetProductUsecase extends BaseParamsUsecase<ProductEntity, int> {
  final ProductRepository productRepository;
  GetProductUsecase({required this.productRepository});
  @override
  Future<ApiResultModel<ProductEntity>> call(int id) {
    return productRepository.getProductById(id);
  }
}
