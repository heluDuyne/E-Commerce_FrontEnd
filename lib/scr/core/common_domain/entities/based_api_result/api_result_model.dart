import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_result_model.freezed.dart';
part 'error_result_model.dart';

@freezed
class ApiResultModel<T> with _$ApiResultModel<T>{
  const factory ApiResultModel.success({required T data}) = Success<T>;
  const factory ApiResultModel.failure({required ErrorResultModel errorResultModel}) = Failure<T>;
}