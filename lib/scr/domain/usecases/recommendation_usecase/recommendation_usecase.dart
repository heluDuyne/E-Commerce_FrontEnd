import 'package:e_commerce_frontend/scr/core/common_domain/entities/based_api_result/api_result_model.dart';
import 'package:e_commerce_frontend/scr/core/common_domain/usecases/base_params_usecase.dart';
import 'package:e_commerce_frontend/scr/domain/entities/recommendation_entity/recommendation_entity.dart';
import 'package:e_commerce_frontend/scr/domain/repositories/recommendation_repository.dart';

class RecommendationUsecase extends BaseParamsUsecase<RecommendationEntity, NoParams> {
  final RecommendationRepository repository;
  RecommendationUsecase({required this.repository});
  @override
  Future<ApiResultModel<RecommendationEntity>> call(NoParams _) {
    return repository.getListRecommendedProduct();
  }
}