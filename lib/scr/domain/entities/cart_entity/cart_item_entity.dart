import 'package:e_commerce_frontend/scr/domain/entities/cart_entity/cart_entity.dart';
import 'package:e_commerce_frontend/scr/domain/entities/generic_product_entity/generic_product_entity.dart';
import 'package:e_commerce_frontend/scr/domain/entities/product_detail_entity/product_detail_entity.dart';
import 'package:equatable/equatable.dart';

class CartItemEntity extends Equatable {
  final int id;
  final CartEntity cart;
  final GenericProductEntity genericProductInfo;
  final ProductDetailEntity productDetail;
  final DateTime updateDate;
  final bool isChecked;
  final int quantity;

  const CartItemEntity({
    required this.id,
    required this.cart,
    required this.genericProductInfo,
    required this.productDetail,
    required this.isChecked,
    required this.updateDate,
    required this.quantity,
  });

  @override
  List<Object?> get props => [
    id,
    cart,
    genericProductInfo,
    productDetail,
    isChecked,
    updateDate,
    quantity,
  ];

  CartItemEntity copyWith({
    int? id,
    CartEntity? cart,
    GenericProductEntity? genericProductInfo,
    ProductDetailEntity? productDetail,
    DateTime? updateDate,
    bool? isChecked,
    int? quantity,
  }) {
    return CartItemEntity(
      id: id ?? this.id,
      cart: cart ?? this.cart,
      genericProductInfo: genericProductInfo ?? this.genericProductInfo,
      productDetail: productDetail ?? this.productDetail,
      updateDate: updateDate ?? this.updateDate,
      isChecked: isChecked ?? this.isChecked,
      quantity: quantity ?? this.quantity,
    );
  }
}
