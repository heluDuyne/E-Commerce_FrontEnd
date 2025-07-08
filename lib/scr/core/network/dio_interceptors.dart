import 'package:dio/dio.dart';
import 'package:e_commerce_frontend/scr/core/utils/helpers/token_management_helper/token_management_helper.dart';
import 'package:flutter/rendering.dart';

class AuthInterceptor extends Interceptor {
  final TokenManagerHelper tokenManagerHelper;
  AuthInterceptor({required this.tokenManagerHelper});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip auth token for public endpoints
    List<String> publicEndpoints = [
      '/user/sign-up/',
      '/user/login/',
      '/verify/verify-email/',
    ];
    if (!publicEndpoints.contains(options.path)) {
      // Get the token from the token manager
      String? token = await tokenManagerHelper.getToken();
      if (token.isNotEmpty) {
        options.headers['Authorization'] = 'Token $token';
      } else {
        throw DioException(
          requestOptions: options,
          message: 'Authentication token is missing',
        );
      }
    }
    handler.next(options);
  }
}

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    return super.onError(err, handler);
  }
}
