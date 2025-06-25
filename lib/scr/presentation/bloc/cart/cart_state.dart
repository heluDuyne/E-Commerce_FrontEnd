part of 'cart_bloc.dart';

@freezed
class CartState with _$CartState {
  const factory CartState.initial() = IntialCart;
  const factory CartState.loading() = LoadingCart;
  const factory CartState.loaded({required List<CartItemEntity> cartItems}) = LoadedCart;
  const factory CartState.loadedMoreCartItem({required List<CartItemEntity> cartItems}) = LoadedMoreCart;
  const factory CartState.addedToCart() = AddedToCart;
  const factory CartState.error(String message, {@Default([]) List<CartItemEntity> cartItems}) = ErrorCart;
}