import 'package:e_commerce_frontend/scr/core/common_domain/entities/based_api_result/api_result_model.dart';
import 'package:e_commerce_frontend/scr/data/models/request/login_request_model/login_request_model.dart';

abstract class LoginRepository {
  Future<ApiResultModel<String?>> login(LoginRequestModel loginRequestModel);
}