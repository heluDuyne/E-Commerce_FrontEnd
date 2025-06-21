import 'dart:async';

import 'package:e_commerce_frontend/scr/core/common_domain/entities/based_api_result/api_result_model.dart';
import 'package:e_commerce_frontend/scr/domain/entities/product_entity/product_entity.dart';
import 'package:e_commerce_frontend/scr/domain/usecases/product_usecase/get_product_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_bloc.freezed.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductUsecase getProductUsecase;
  ProductBloc({required this.getProductUsecase})
    : super(const InitialProduct()) {
    on<FetchProductDetailEvent>(_fetchProductDetailEvent);
  }

  FutureOr<void> _fetchProductDetailEvent(
    FetchProductDetailEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(const LoadingProduct());
    final result = await getProductUsecase.call(event.productId);
    switch(result) {
      case Success():
        final productEntity = result.data;
        emit(LoadedProduct(productEntity: productEntity));
      case Failure():
        print("Error while fetching product detail: ${result.errorResultModel.message}");
        emit(const ErrorProduct("Error while fetching product."));
    }
  }
}
