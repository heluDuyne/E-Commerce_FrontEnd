import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final int id;
  final String name;
  final CategoryEntity parentCategory; // Attribute of the same type
  final String description;

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.parentCategory,
    required this.description,
  });

  @override
  List<Object?> get props => [id, name, parentCategory, description];
}
