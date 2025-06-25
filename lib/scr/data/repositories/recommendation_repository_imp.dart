import 'package:e_commerce_frontend/scr/core/common_domain/entities/based_api_result/api_result_model.dart';
import 'package:e_commerce_frontend/scr/data/datasources/recommendation_datasource/recommendation_datasource.dart';
import 'package:e_commerce_frontend/scr/data/repositories/base_repository.dart';
import 'package:e_commerce_frontend/scr/domain/entities/recommendation_entity/recommendation_entity.dart';
import 'package:e_commerce_frontend/scr/domain/repositories/recommendation_repository.dart';

class RecommendationRepositoryImp extends BaseRepository implements RecommendationRepository {
  final RecommendationDatasource datasource;
  RecommendationRepositoryImp({required this.datasource});
  @override
  Future<ApiResultModel<RecommendationEntity>> getListRecommendedProduct() {
    return baseExecute(() async {
      final response = await datasource.getListRecommendedProduct();
      return response.mapToEntity();
    });
  }
}