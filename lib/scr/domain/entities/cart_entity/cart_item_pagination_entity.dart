import 'package:e_commerce_frontend/scr/domain/entities/cart_entity/cart_item_entity.dart';
import 'package:equatable/equatable.dart';

class CartItemPaginationEntity extends Equatable {
  final int count;
  final String next;
  final String previous;
  final List<CartItemEntity> results;

  CartItemPaginationEntity({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  @override
  List<Object?> get props => [
    count,
    next,
    previous,
    results
  ];
}