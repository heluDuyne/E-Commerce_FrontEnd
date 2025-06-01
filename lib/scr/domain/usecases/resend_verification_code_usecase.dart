import 'package:e_commerce_frontend/scr/core/common_domain/entities/based_api_result/api_result_model.dart';
import 'package:e_commerce_frontend/scr/core/common_domain/usecases/base_params_usecase.dart';
import 'package:e_commerce_frontend/scr/domain/repositories/resend_verification_code_repository.dart';

class ResendVerificationCodeUsecase extends BaseParamsUsecase<void, NoParams>{
  final ResendVerificationCodeRepository resendVerificationCodeRepository;
  ResendVerificationCodeUsecase({required this.resendVerificationCodeRepository});

  @override
  Future<ApiResultModel<void>> call(NoParams _) {
    return resendVerificationCodeRepository.resendVerificationCode();
  }

}