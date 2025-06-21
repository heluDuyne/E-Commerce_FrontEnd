import 'package:equatable/equatable.dart';

class ProductVariantEntity extends Equatable {
  final int id;
  final int product;
  final String color;
  final String size;
  final int stockQuantity;

  const ProductVariantEntity({
    required this.id,
    required this.product,
    required this.color,
    required this.size,
    required this.stockQuantity,
  });

  @override
  List<Object?> get props => [id, product, color, size, stockQuantity];
}
