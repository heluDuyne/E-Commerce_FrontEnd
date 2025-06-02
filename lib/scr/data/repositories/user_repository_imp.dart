import 'package:e_commerce_frontend/scr/core/common_domain/entities/based_api_result/api_result_model.dart';
import 'package:e_commerce_frontend/scr/data/datasources/user_datasource/user_datasource.dart';
import 'package:e_commerce_frontend/scr/data/models/request/user_request_model/user_request_model.dart';
import 'package:e_commerce_frontend/scr/data/repositories/base_repository.dart';
import 'package:e_commerce_frontend/scr/domain/entities/user_info_entity/user_info_entity.dart';
import 'package:e_commerce_frontend/scr/domain/repositories/user_repository.dart';

class UserRepositoryImp extends BaseRepository implements UserRepository{
  final UserDatasource datasource;
  UserRepositoryImp({required this.datasource});
  @override
  Future<ApiResultModel<UserInfoEntity>> getUserInfo() {
    return baseExecute(() async {
      var response = await datasource.getUserInfo();
      return response.mapToEntity();
    });
  }

  @override
  Future<ApiResultModel<UserInfoEntity>> updateUserInfo(UserRequestModel userRequestModel) {
    return baseExecute(() async {
      var response = await datasource.updateUserInfo(userRequestModel);
      return response.mapToEntity();
    });
  }

  @override
  Future<ApiResultModel<UserInfoEntity>> updateUserInfoPartially(UserRequestModel userRequestModel) {
    return baseExecute(() async {
      var response = await datasource.updateUserInfoPartially(userRequestModel);
      return response.mapToEntity();
    });
  }
}