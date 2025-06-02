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
      // Log the complete error details
      print("DioException: ${e.message}");
      print("Status code: ${e.response?.statusCode}");
      print("Response data type: ${e.response?.data.runtimeType}");
      print("Response data: ${e.response?.data}");

      if (e.response != null) {
        // Handle various response formats
        if (e.response?.data is String) {
          final errorMessage = e.response?.data;
          return ApiResultModel.failure(
            errorResultModel: ErrorResultModel(
              statusCode: e.response?.statusCode ?? 403,
              message: errorMessage,
            ),
          );
        } else if (e.response?.data is Map) {
          // Try different possible fields where error message might be stored
          final errorData = e.response?.data as Map;
          final errorMessage =
              errorData['message'] ??
              errorData['error'] ??
              errorData['detail'] ??
              errorData.toString();

          return ApiResultModel.failure(
            errorResultModel: ErrorResultModel(
              statusCode: e.response?.statusCode ?? 403,
              message: errorMessage.toString(),
            ),
          );
        }
      }

      // Default fallback
      return ApiResultModel.failure(
        errorResultModel: ErrorResultModel(
          statusCode: e.response?.statusCode ?? 403,
          message: e.message ?? 'Error occurred. Please try again',
        ),
      );
    }
  }
}
