import 'dart:async';

import 'package:e_commerce_frontend/scr/core/common_domain/entities/based_api_result/api_result_model.dart';
import 'package:e_commerce_frontend/scr/core/common_domain/usecases/base_params_usecase.dart';
import 'package:e_commerce_frontend/scr/core/utils/constants/constants.dart';
import 'package:e_commerce_frontend/scr/core/utils/helpers/shared_pref_management_helper/shared_pref_management_helper.dart';
import 'package:e_commerce_frontend/scr/domain/entities/generic_product_entity/generic_product_entity.dart';
import 'package:e_commerce_frontend/scr/domain/entities/generic_product_entity/generic_product_pagination_entity.dart';
import 'package:e_commerce_frontend/scr/domain/usecases/product_usecase/get_list_product_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generic_product_bloc.freezed.dart';
part 'generic_product_event.dart';
part 'generic_product_state.dart';

class GenericProductBloc extends Bloc<GenericProductEvent, GenericProductState> {
  final List<GenericProductEntity> genericProducts = [];
  final GetListProductUsecase getListProductUsecase;
  final SharedPrefManagementHelper sharedPrefManagementHelper;
  GenericProductPaginationEntity? genericProductPaginationEntity;

  GenericProductBloc({
    required this.getListProductUsecase,
    required this.sharedPrefManagementHelper,
  }) : super(const GenericProductInitial()) {
    on<GenericProductInitialEvent>(_onInitial);
    on<FetchGenericProductsEvent>(_onFetchProducts);
  }

  FutureOr<void> _onInitial(GenericProductInitialEvent event, Emitter<GenericProductState> emit) {
    emit(const GenericProductInitial());
  }

  FutureOr<void> _onFetchProducts(
    FetchGenericProductsEvent event,
    Emitter<GenericProductState> emit,
  ) async {
    emit(const GenericProductLoading());
    var result = await getListProductUsecase.call(NoParams());
    switch (result) {
      case Success():
        genericProducts.clear();
        genericProductPaginationEntity = result.data;
        if (genericProductPaginationEntity != null){
          genericProducts.addAll(genericProductPaginationEntity!.results);
          await sharedPrefManagementHelper.saveKeyString(
            NEXT_PAGE_LINK,
            genericProductPaginationEntity!.next.isEmpty ? '' : genericProductPaginationEntity!.next,
          );
          emit(GenericProductSuccess(listGenericProduct: genericProducts));
        } else {
          emit(const GenericProductError('Fail to return data'));
        }
      case Failure():
        print('Failed to fetch porducts: ${result.errorResultModel.message}');
        emit(const GenericProductError("Failed to fetch products"));
    }
  }


}
