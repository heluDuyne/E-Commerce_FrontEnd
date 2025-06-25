import 'dart:async';

import 'package:e_commerce_frontend/scr/core/common_domain/entities/based_api_result/api_result_model.dart';
import 'package:e_commerce_frontend/scr/core/common_domain/usecases/base_params_usecase.dart';
import 'package:e_commerce_frontend/scr/core/utils/constants/constants.dart';
import 'package:e_commerce_frontend/scr/core/utils/helpers/shared_pref_management_helper/shared_pref_management_helper.dart';
import 'package:e_commerce_frontend/scr/domain/entities/generic_product_entity/generic_product_entity.dart';
import 'package:e_commerce_frontend/scr/domain/usecases/product_usecase/get_list_product_by_url_usecase.dart';
import 'package:e_commerce_frontend/scr/domain/usecases/recommendation_usecase/recommendation_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recommendation_event.dart';
part 'recommendation_state.dart';
part 'recommendation_bloc.freezed.dart';

class RecommendationBloc
    extends Bloc<RecommendationEvent, RecommendationState> {
  final RecommendationUsecase recommendationUsecase;
  final List<GenericProductEntity> genericProducts = [];
  RecommendationBloc({
    required this.recommendationUsecase,
  }) : super(const InitialRecommendation()) {
    on<InitialRecommendationEvent>(_onInitial);
    on<FetchRecommendationEvent>(_onFetchRecommendedProducts);
  }

  FutureOr<void> _onInitial(
    InitialRecommendationEvent event,
    Emitter<RecommendationState> emit,
  ) {
    emit(const InitialRecommendation());
  }

  FutureOr<void> _onFetchRecommendedProducts(
    FetchRecommendationEvent event,
    Emitter<RecommendationState> emit,
  ) async {
    emit(const LoadingRecommendation());
    var result = await recommendationUsecase.call(NoParams());
    switch (result) {
      case Success():
        genericProducts.clear();
        var genericProductPaginationEntity = result.data;
        genericProducts.addAll(genericProductPaginationEntity.recommendations);
        emit(LoadedRecommendation(listGenericProduct: genericProducts));
      case Failure():
        print('Failed to fetch porducts: ${result.errorResultModel.message}');
        emit(const ErrorRecommendation("Failed to fetch products"));
    }
  }
}
