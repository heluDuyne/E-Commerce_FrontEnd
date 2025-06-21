import 'package:e_commerce_frontend/scr/core/common_domain/entities/based_api_result/api_result_model.dart';
import 'package:e_commerce_frontend/scr/domain/entities/generic_product_entity/generic_product_pagination_entity.dart';
import 'package:e_commerce_frontend/scr/domain/entities/product_entity/product_entity.dart';

abstract class ProductRepository {
  Future<ApiResultModel<GenericProductPaginationEntity>> getListProduct();
  Future<ApiResultModel<GenericProductPaginationEntity>> getListProductByUrl(String url);
  Future<ApiResultModel<ProductEntity>> getProductById(int id);
  // Future<void> addProduct(Product product);
  // Future<void> updateProduct(Product product);
  // Future<void> deleteProduct(String id);
}