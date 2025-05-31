import 'package:e_commerce_frontend/scr/core/common_domain/entities/based_api_result/api_result_model.dart';
import 'package:e_commerce_frontend/scr/core/common_domain/usecases/base_params_usecase.dart';
import 'package:e_commerce_frontend/scr/data/models/request/user_request_model/user_request_model.dart';
import 'package:e_commerce_frontend/scr/domain/entities/user_info_entity/user_info_entity.dart';
import 'package:e_commerce_frontend/scr/domain/repositories/signup_repository.dart';

class SignupUsecase implements BaseParamsUsecase<UserInfoEntity?, UserRequestModel>{
  final SignupRepository _signupRepository;

  const SignupUsecase(this._signupRepository);

  @override
  Future<ApiResultModel<UserInfoEntity?>> call(UserRequestModel userRequestModel) {
    return _signupRepository.signUpUser(userRequestModel);
  }
}