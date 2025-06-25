import 'package:e_commerce_frontend/scr/core/utils/mapper/data_mapper.dart';
import 'package:e_commerce_frontend/scr/data/models/response/generic_product_response_model/generic_product_response_model.dart';
import 'package:e_commerce_frontend/scr/domain/entities/recommendation_entity/recommendation_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recommendation_response_model.g.dart';

@JsonSerializable()
class RecommendationResponseModel extends DataMapper<RecommendationEntity> {
  final List<GenericProductResponseModel>? recommendations;

  RecommendationResponseModel({
    required this.recommendations,
  });

  factory RecommendationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RecommendationResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$RecommendationResponseModelToJson(this);

  @override
  RecommendationEntity mapToEntity() {
    return RecommendationEntity(
      recommendations: recommendations
              ?.map((e) => e.mapToEntity())
              .toList() ??
          [],
    );
  }
}