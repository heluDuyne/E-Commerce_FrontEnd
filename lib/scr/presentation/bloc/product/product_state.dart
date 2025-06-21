part of 'product_bloc.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState.initial() = InitialProduct;
  const factory ProductState.loading() = LoadingProduct;
  const factory ProductState.loaded({required ProductEntity productEntity}) = LoadedProduct;
  const factory ProductState.error(String message) = ErrorProduct;
}