import 'package:e_commerce_frontend/scr/domain/entities/generic_product_entity/generic_product_entity.dart';
import 'package:equatable/equatable.dart';

class RecommendationEntity extends Equatable {
  final List<GenericProductEntity> recommendations;
  const RecommendationEntity({
    required this.recommendations,
  });

  @override
  List<Object?> get props => [recommendations];

}