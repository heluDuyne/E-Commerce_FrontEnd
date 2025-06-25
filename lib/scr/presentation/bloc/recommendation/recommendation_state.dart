part of 'recommendation_bloc.dart';

@freezed
class RecommendationState with _$RecommendationState {
  const factory RecommendationState.initial() = InitialRecommendation;
  const factory RecommendationState.loading() = LoadingRecommendation;

  const factory RecommendationState.success({
    required List<GenericProductEntity> listGenericProduct,
  }) = LoadedRecommendation;

  const factory RecommendationState.loadingMore({
    required List<GenericProductEntity> listGenericProduct,
  }) = LoadingMoreRecommendation;

  const factory RecommendationState.error(
    String message, {
    @Default([]) List<GenericProductEntity> listProducts,
  }) = ErrorRecommendation;
}