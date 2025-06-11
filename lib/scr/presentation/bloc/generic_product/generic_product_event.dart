part of 'generic_product_bloc.dart';

@freezed
class GenericProductEvent with _$GenericProductEvent {
  const factory GenericProductEvent.initial() = GenericProductInitialEvent;
  const factory GenericProductEvent.fetchProducts() = FetchGenericProductsEvent;
}
