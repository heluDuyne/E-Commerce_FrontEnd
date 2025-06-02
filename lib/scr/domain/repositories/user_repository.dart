import 'package:e_commerce_frontend/scr/core/common_domain/entities/based_api_result/api_result_model.dart';
import 'package:e_commerce_frontend/scr/data/models/request/user_request_model/user_request_model.dart';
import 'package:e_commerce_frontend/scr/domain/entities/user_info_entity/user_info_entity.dart';

abstract class UserRepository {
  Future<ApiResultModel<UserInfoEntity>> getUserInfo();
  Future<ApiResultModel<UserInfoEntity>> updateUserInfo(
    UserRequestModel userRequestModel,
  );
  Future<ApiResultModel<UserInfoEntity>> updateUserInfoPartially(
    UserRequestModel userRequestModel,
  );
}
