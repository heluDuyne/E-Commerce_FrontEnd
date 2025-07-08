import 'package:e_commerce_frontend/scr/core/common_domain/entities/based_api_result/api_result_model.dart';
import 'package:e_commerce_frontend/scr/core/common_domain/usecases/base_params_usecase.dart';
import 'package:e_commerce_frontend/scr/data/models/request/login_request_model/login_request_model.dart';
import 'package:e_commerce_frontend/scr/domain/repositories/login_repository.dart';

class LoginUsecase implements BaseParamsUsecase<String?, LoginRequestModel> {
  final LoginRepository _loginRepository;
  const LoginUsecase(this._loginRepository);

  @override
  Future<ApiResultModel<String?>> call(LoginRequestModel loginRequestModel) {
    return _loginRepository.login(loginRequestModel);
  }
}