import 'package:e_commerce_frontend/scr/core/common_domain/entities/based_api_result/api_result_model.dart';
import 'package:e_commerce_frontend/scr/core/common_domain/usecases/base_params_usecase.dart';
import 'package:e_commerce_frontend/scr/domain/entities/user_info_entity/user_info_entity.dart';
import 'package:e_commerce_frontend/scr/domain/repositories/user_repository.dart';

class GetUserInfoUsecase extends BaseParamsUsecase<UserInfoEntity, NoParams>{
  final UserRepository userRepository;
  GetUserInfoUsecase({required this.userRepository});
  @override
  Future<ApiResultModel<UserInfoEntity>> call(NoParams _) {
    return userRepository.getUserInfo();
  }
}