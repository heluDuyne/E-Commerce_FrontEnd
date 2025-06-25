import 'package:dio/dio.dart';
import 'package:e_commerce_frontend/scr/data/common/server_api.dart';
import 'package:e_commerce_frontend/scr/data/models/response/generic_product_response_model/generic_product_pagination_response_model.dart';
import 'package:e_commerce_frontend/scr/data/models/response/recommendation_response_model/recommendation_response_model.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/error_logger.dart';

part 'recommendation_datasource.g.dart';

@RestApi(baseUrl: API.BASE_URL)
abstract class RecommendationDatasource {
  factory RecommendationDatasource(Dio dio, {String baseUrl}) = _RecommendationDatasource;

  @GET(API.RECOMMENDATION)
  Future<RecommendationResponseModel> getListRecommendedProduct();
}