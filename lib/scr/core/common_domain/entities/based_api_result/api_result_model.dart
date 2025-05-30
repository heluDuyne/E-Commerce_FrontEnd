import 'package:e_commerce_frontend/scr/core/common_domain/entities/based_api_result/error_result_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_result_model.freezed.dart';

@freezed
class ApiResultModel<T> with _$ApiResultModel<T> {
  const factory ApiResultModel.success({required T data}) = Success<T>;
  const factory ApiResultModel.failure({
    required ErrorResultModel errorResultModel,
  }) = Failure<T>;
}