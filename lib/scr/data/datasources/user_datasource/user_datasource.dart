import 'package:dio/dio.dart';
import 'package:e_commerce_frontend/scr/data/common/server_api.dart';
import 'package:e_commerce_frontend/scr/data/models/request/user_request_model/user_request_model.dart';
import 'package:e_commerce_frontend/scr/data/models/response/user_response_model/user_response_model.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'user_datasource.g.dart';

@RestApi(baseUrl: API.BASE_URL)
abstract class UserDatasource {
  factory UserDatasource(Dio dio, {String baseUrl}) = _UserDatasource;

  @GET(API.USER)
  Future<UserResponseModel> getUserInfo();

  @PUT(API.USER)
  Future<UserResponseModel> updateUserInfo(
    @Body() UserRequestModel userRequestModel,
  );

  @PATCH(API.USER)
  Future<UserResponseModel> updateUserInfoPartially(
    @Body() UserRequestModel userRequestModel,
  );
}
