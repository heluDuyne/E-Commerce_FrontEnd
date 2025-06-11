part of 'generic_product_bloc.dart';

@freezed
class GenericProductState with _$GenericProductState {
  const factory GenericProductState.initial() = GenericProductInitial;
  const factory GenericProductState.loading() = GenericProductLoading;

  const factory GenericProductState.success({
    required List<GenericProductEntity> listGenericProduct,
  }) = GenericProductSuccess;

  const factory GenericProductState.error(String message) = GenericProductError;
}
