import 'package:e_commerce_frontend/scr/core/utils/mapper/data_mapper.dart';
import 'package:e_commerce_frontend/scr/domain/entities/category_entity/category_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_response_model.g.dart';

@JsonSerializable()
class CategoryResponseModel extends DataMapper<CategoryEntity> {
  final int? id;
  final String? name;
  @JsonKey(name: 'parent_category')
  final CategoryResponseModel? parentCategory; // Attribute of the same type
  final String? description;

  CategoryResponseModel({
    required this.id,
    required this.name,
    required this.parentCategory,
    required this.description,
  });
  @override
  CategoryEntity mapToEntity() {
    return CategoryEntity(
      id: id ?? 0,
      name: name ?? '',
      parentCategory:
          parentCategory?.mapToEntity() ??
          CategoryResponseModel(
            id: 0,
            name: '',
            parentCategory: null,
            description: '',
          ).mapToEntity(),
      description: description ?? '',
    );
  }

  factory CategoryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryResponseModelToJson(this);
}
