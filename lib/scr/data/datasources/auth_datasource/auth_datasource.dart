import 'package:dio/dio.dart';
import 'package:e_commerce_frontend/scr/data/models/request/login_request_model.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import 'package:e_commerce_frontend/scr/data/common/server_api.dart';

part 'auth_datasource.g.dart';

@RestApi(baseUrl: API.BASE_URL)
abstract class AuthDatasource {
  factory AuthDatasource(Dio dio, {String baseUrl}) = _AuthDatasource;

  @POST(API.LOGIN)
  Future<String?> loginRequest(@Body() LoginRequestModel loginRequestModel);
}
