import 'dart:async';

import 'package:e_commerce_frontend/scr/core/common_domain/entities/based_api_result/api_result_model.dart';
import 'package:e_commerce_frontend/scr/core/common_domain/usecases/base_params_usecase.dart';
import 'package:e_commerce_frontend/scr/core/utils/constants/constants.dart';
import 'package:e_commerce_frontend/scr/core/utils/helpers/shared_pref_management_helper/shared_pref_management_helper.dart';
import 'package:e_commerce_frontend/scr/data/models/request/cart_item_request_model/cart_item_request_model.dart';
import 'package:e_commerce_frontend/scr/data/models/request/update_cart_item_request_model/update_cart_item_request_model.dart';
import 'package:e_commerce_frontend/scr/domain/entities/cart_entity/cart_item_entity.dart';
import 'package:e_commerce_frontend/scr/domain/entities/product_detail_entity/product_detail_entity.dart';
import 'package:e_commerce_frontend/scr/domain/usecases/cart_usecase/add_product_to_cart_usecase.dart';
import 'package:e_commerce_frontend/scr/domain/usecases/cart_usecase/get_list_cart_item_by_url_usecase.dart';
import 'package:e_commerce_frontend/scr/domain/usecases/cart_usecase/get_list_cart_item_usecase.dart';
import 'package:e_commerce_frontend/scr/domain/usecases/cart_usecase/update_cart_item_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_bloc.freezed.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetListCartItemUsecase getListCartItemUsecase;
  final GetListCartItemByUrlUsecase getListCartItemByUrlUsecase;
  final AddProductToCartUsecase addProductToCartUsecase;
  final UpdateCartItemUsecase updateCartItemUsecase;
  final SharedPrefManagementHelper sharePrefManagementHepler;
  final List<CartItemEntity> cartItems = [];

  CartBloc({
    required this.getListCartItemUsecase,
    required this.getListCartItemByUrlUsecase,
    required this.addProductToCartUsecase,
    required this.updateCartItemUsecase,
    required this.sharePrefManagementHepler,
  }) : super(const IntialCart()) {
    on<GetListCartItem>(_onGetListCartItem);
    on<LoadMoreCartItems>(_onGetListCartItemByUrl);
    on<AddProductToCart>(_onAddProductToCart);
    on<UpdateCartItem>(_onUpdateCartItem);
  }

  FutureOr<void> _onGetListCartItem(
    GetListCartItem event,
    Emitter<CartState> emit,
  ) async {
    emit(const LoadingCart());
    var result = await getListCartItemUsecase.call(NoParams());
    switch (result) {
      case Success():
        var cartItemPagination = result.data;
        cartItems.addAll(cartItemPagination.results);
        await sharePrefManagementHepler.saveKeyString(
          CART_NEXT_PAGE_LINK,
          cartItemPagination.next.isEmpty ? '' : cartItemPagination.next,
        );
        emit(LoadedCart(cartItems: List.from(cartItems)));
      case Failure():
        print("Error fetching cart items: ${result.errorResultModel.message}");
        emit(const ErrorCart("Error fetching cart items"));
    }
  }

  FutureOr<void> _onGetListCartItemByUrl(
    LoadMoreCartItems event,
    Emitter<CartState> emit,
  ) async {
    if (emit is! LoadedCart) {
      add(const GetListCartItem());
      return;
    }

    final nextPagelink = sharePrefManagementHepler.getKeyString(
      CART_NEXT_PAGE_LINK,
    );
    if (nextPagelink.isEmpty) {
      return;
    }

    emit(LoadedMoreCart(cartItems: cartItems));

    try {
      var result = await getListCartItemByUrlUsecase.call(nextPagelink);
      switch (result) {
        case Success():
          var cartItemPagination = result.data;
          cartItems.addAll(cartItemPagination.results);
          await sharePrefManagementHepler.saveKeyString(
            CART_NEXT_PAGE_LINK,
            cartItemPagination.next.isEmpty ? '' : cartItemPagination.next,
          );
          emit(LoadedCart(cartItems: List.from(cartItems)));
        case Failure():
          print(
            "Error loading more cart items: ${result.errorResultModel.message}",
          );
          emit(
            ErrorCart("Error loading more cart items", cartItems: cartItems),
          );
      }
    } catch (e) {
      print("Exception while loading more cart items: $e");
      emit(
        ErrorCart(
          "Exception while loading more cart items",
          cartItems: cartItems,
        ),
      );
    }
  }

  FutureOr<void> _onAddProductToCart(
    AddProductToCart event,
    Emitter<CartState> emit,
  ) async {
    emit(const LoadingCart());
    var result = await addProductToCartUsecase.call(event.cartItemRequestModel);
    switch (result) {
      case Success():
        print("Successfully added product to cart");
        emit(const AddedToCart());
      case Failure():
        print(
          "Error adding product to cart: ${result.errorResultModel.message}",
        );
        emit(ErrorCart("Error adding product to cart", cartItems: cartItems));
    }
  }

  FutureOr<void> _onUpdateCartItem(
    UpdateCartItem event,
    Emitter<CartState> emit,
  ) async {
    emit(const LoadingCart());
    var result = await updateCartItemUsecase.call(
      UpdateCartItemRequestModel(
        id: event.id,
        cartItem: event.cartItemRequestModel,
      ),
    );
    print(event.cartItemRequestModel.toJson());
    print("Check: ${event.id}");
    print("Check: ${event.cartItemRequestModel.productDetail.toJson()}");
    print(
      "Check: ${event.cartItemRequestModel.productDetail.detailVariant?.toJson()}",
    );
    print("Check: ${event.cartItemRequestModel.isChecked}");
    print("Check: ${event.cartItemRequestModel.quantity}");
    switch (result) {
      case Success():
        // Create a new list to ensure immutability
        print("Before update: ${cartItems.map((item) => 'id: ${item.id}, isChecked: ${item.isChecked}').toList()}");
        final updatedCartItems =
            cartItems.map((item) {
              if (item.id == event.id &&
                  item.productDetail.detailVariant.id ==
                      event
                          .cartItemRequestModel
                          .productDetail
                          .detailVariant
                          ?.id) {
                return item.copyWith(
                  quantity: event.cartItemRequestModel.quantity,
                  isChecked: event.cartItemRequestModel.isChecked,
                );
              }
              return item;
            }).toList();
        print("After update: ${updatedCartItems.map((item) => 'id: ${item.id}, isChecked: ${item.isChecked}').toList()}");
        // Update the cartItems list with the new list
        cartItems.clear();
        cartItems.addAll(updatedCartItems);

        emit(LoadedCart(cartItems: List.from(cartItems)));
      case Failure():
        print("Error updating cart item: ${result.errorResultModel.message}");
        emit(ErrorCart("Error updating cart item", cartItems: cartItems));
    }
  }
}
