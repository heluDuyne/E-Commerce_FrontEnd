import 'package:e_commerce_frontend/scr/core/common_domain/entities/based_api_result/api_result_model.dart';
import 'package:e_commerce_frontend/scr/domain/entities/recommendation_entity/recommendation_entity.dart';

abstract class RecommendationRepository {
  Future<ApiResultModel<RecommendationEntity>> getListRecommendedProduct();
}