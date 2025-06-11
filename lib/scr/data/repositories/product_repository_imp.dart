import 'package:e_commerce_frontend/scr/core/common_domain/entities/based_api_result/api_result_model.dart';
import 'package:e_commerce_frontend/scr/data/datasources/product_datasource/product_datasource.dart';
import 'package:e_commerce_frontend/scr/data/repositories/base_repository.dart';
import 'package:e_commerce_frontend/scr/domain/entities/generic_product_entity/generic_product_pagination_entity.dart';
import 'package:e_commerce_frontend/scr/domain/repositories/product_repository.dart';

class ProductRepositoryImp extends BaseRepository implements ProductRepository{
  final ProductDatasource datasource;
  ProductRepositoryImp({required this.datasource});
  @override
  Future<ApiResultModel<GenericProductPaginationEntity>> getListProduct() {
    return baseExecute(() async {
      var results = await datasource.getListProduct();
      return results.mapToEntity();
    });
  }
}