part of 'cart_bloc.dart';

@freezed
class CartEvent with _$CartEvent {
  const factory CartEvent.initial() = InitialCartEvent;
  const factory CartEvent.getListCartItem() = GetListCartItem;
  const factory CartEvent.loadMoreCartItems() = LoadMoreCartItems;
  const factory CartEvent.addProductToCart({required CartItemRequestModel cartItemRequestModel}) = AddProductToCart;
  const factory CartEvent.updateCartItem({required int id, required CartItemRequestModel cartItemRequestModel}) = UpdateCartItem;
  const factory CartEvent.removeCartItem({required String id}) = RemoveCartItem;
}