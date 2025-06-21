import 'package:equatable/equatable.dart';

class ProductDetailInfoEntity extends Equatable {
  final int id;
  final int product;
  final String detailName;
  final String detailValue;

  const ProductDetailInfoEntity({
    required this.id,
    required this.product,
    required this.detailName,
    required this.detailValue,
  });
  @override
  List<Object?> get props => [id, product, detailName, detailValue];
}
