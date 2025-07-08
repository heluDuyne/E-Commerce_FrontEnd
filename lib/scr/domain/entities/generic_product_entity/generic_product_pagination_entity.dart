import 'package:e_commerce_frontend/scr/domain/entities/generic_product_entity/generic_product_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generic_product_pagination_entity.g.dart';

@JsonSerializable()
class GenericProductPaginationEntity extends Equatable {
  final int count;
  final String next;
  final String previous;
  final List<GenericProductEntity> results;

  const GenericProductPaginationEntity({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory GenericProductPaginationEntity.fromJson(Map<String, dynamic> json) =>
      _$GenericProductPaginationEntityFromJson(json);
  Map<String, dynamic> toJson() => _$GenericProductPaginationEntityToJson(this);

  @override
  List<Object?> get props => <Object?>[
    count,
    next,
    previous,
    results,
  ];

  GenericProductPaginationEntity copyWith({
    int? count,
    String? next,
    String? previous,
    List<GenericProductEntity>? results,
  }) {
    return GenericProductPaginationEntity(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }
}
