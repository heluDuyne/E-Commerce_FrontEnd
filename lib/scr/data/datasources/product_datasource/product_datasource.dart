import 'package:dio/dio.dart';
import 'package:e_commerce_frontend/scr/data/common/server_api.dart';
import 'package:e_commerce_frontend/scr/data/models/response/generic_product_response_model/generic_product_pagination_response_model.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'product_datasource.g.dart';

@RestApi(baseUrl: API.BASE_URL)
abstract class ProductDatasource {
  factory ProductDatasource(Dio dio, {String baseUrl}) = _ProductDatasource;

  @GET(API.PRODUCT)
  Future<GenericProductPaginationResponseModel> getListProduct();

  // @GET(API.PRODUCT)
  // Future<void> getProductByName();
}
