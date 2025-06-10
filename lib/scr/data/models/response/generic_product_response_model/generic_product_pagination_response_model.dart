import 'package:e_commerce_frontend/scr/data/models/response/generic_product_response_model/generic_product_response_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generic_product_pagination_response_model.g.dart';

@JsonSerializable()
class GenericProductPaginationResponseModel {
  final int count;
  final String next;
  final String previous;
  final List<GenericProductResponseModel> results;

  GenericProductPaginationResponseModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory GenericProductPaginationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GenericProductPaginationResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$GenericProductPaginationResponseModelToJson(this);
}
