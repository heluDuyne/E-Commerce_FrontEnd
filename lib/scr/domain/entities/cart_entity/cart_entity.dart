import 'package:equatable/equatable.dart';

class CartEntity extends Equatable {
  final int id;
  final int user;

  const CartEntity({required this.id, required this.user});

  @override
  List<Object?> get props => [id, user];
}
