import 'package:e_commerce_frontend/scr/core/common_domain/entities/based_api_result/api_result_model.dart';
import 'package:e_commerce_frontend/scr/data/datasources/auth_datasource/auth_datasource.dart';
import 'package:e_commerce_frontend/scr/data/models/request/login_request_model/login_request_model.dart';
import 'package:e_commerce_frontend/scr/domain/repositories/login_repository.dart';
import 'base_repository.dart';

class LoginRepositoryImp extends BaseRepository implements LoginRepository{
  final AuthDatasource datasource;
  LoginRepositoryImp({required this.datasource});

  @override
  Future<ApiResultModel<String?>> login(LoginRequestModel loginRequestModel) async  {
    return await baseExecute(() => datasource.loginRequest(loginRequestModel));
  }
}