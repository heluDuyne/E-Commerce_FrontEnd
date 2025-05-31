import 'package:e_commerce_frontend/scr/core/common_domain/entities/based_api_result/api_result_model.dart';
import 'package:e_commerce_frontend/scr/data/datasources/auth_datasource/auth_datasource.dart';
import 'package:e_commerce_frontend/scr/data/models/request/user_request_model/user_request_model.dart';
import 'package:e_commerce_frontend/scr/data/repositories/base_repository.dart';
import 'package:e_commerce_frontend/scr/domain/entities/user_info_entity/user_info_entity.dart';
import 'package:e_commerce_frontend/scr/domain/repositories/signup_repository.dart';

class SignupRepositoryImp extends BaseRepository implements SignupRepository {
  final AuthDatasource datasource;

  SignupRepositoryImp({required this.datasource});

  @override
  Future<ApiResultModel<UserInfoEntity?>> signUpUser(UserRequestModel userRequestModel){
    return baseExecute(() async {
      var response = await datasource.signUpRequest(userRequestModel);
      return response?.mapToEntity();
    });
  }

}