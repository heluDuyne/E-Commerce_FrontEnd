part of 'recommendation_bloc.dart';

@freezed
class RecommendationEvent with _$RecommendationEvent {
  const factory RecommendationEvent.initial() = InitialRecommendationEvent;
  const factory RecommendationEvent.fetchProducts() = FetchRecommendationEvent;
}