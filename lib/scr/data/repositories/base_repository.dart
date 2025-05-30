import 'dart:io';
import 'package:dio/dio.dart';
import 'package:e_commerce_frontend/scr/core/common_domain/entities/based_api_result/api_result_model.dart';
import 'package:e_commerce_frontend/scr/core/common_domain/entities/based_api_result/error_result_model.dart';
import 'package:e_commerce_frontend/scr/core/common_domain/exception_handler/exception.dart';

class BaseRepository {
  Future<ApiResultModel<T>> baseExecute<T>(Future<T> Function() func) async {
    try {
      var result = await func();
      return ApiResultModel.success(data: result);
    } on ServerException catch (e) {
      return ApiResultModel.failure(
        errorResultModel: ErrorResultModel(statusCode: 502, message: e.message),
      );
    } on SocketException catch (e) {
      return ApiResultModel.failure(
        errorResultModel: ErrorResultModel(statusCode: 0, message: e.message),
      );
    } on DioException catch (e) {
      if (e.response != null && e.response?.data is String) {
        final errorMessage = e.response?.data;
        return ApiResultModel.failure(
          errorResultModel: ErrorResultModel(
            statusCode: 403,
            message: errorMessage,
          ),
        );
      }
      return ApiResultModel.failure(
        errorResultModel: ErrorResultModel(
          statusCode: 403,
          message:
              e.response?.data['message'].toString() ??
              'Error occured Please try again',
        ),
      );
    }
  }
}
