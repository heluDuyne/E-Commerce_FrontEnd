part of 'product_bloc.dart';

@freezed
class ProductEvent with _$ProductEvent {
  const factory ProductEvent.initial() = InitialProductEvent;
  const factory ProductEvent.fetchProduct(int productId) = FetchProductDetailEvent;
  // const factory ProductEvent.addToCart(int productId, int quantity) = AddToCart;
  // const factory ProductEvent.addToWishlist(int productId) = AddToWishlist;

}