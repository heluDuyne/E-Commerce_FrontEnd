import 'package:e_commerce_frontend/scr/core/common_domain/entities/based_api_result/api_result_model.dart';
import 'package:e_commerce_frontend/scr/core/common_domain/usecases/base_params_usecase.dart';
import 'package:e_commerce_frontend/scr/data/models/request/email_verify_request_model/email_verify_request_model.dart';
import 'package:e_commerce_frontend/scr/domain/repositories/verify_email_repository.dart';

class VerifyEmailUsecase extends BaseParamsUsecase<void, EmailVerifyRequestModel>{
  final VerifyEmailRepository verifyEmailRepository;
  VerifyEmailUsecase({required this.verifyEmailRepository});
  @override
  Future<ApiResultModel<void>> call(EmailVerifyRequestModel emailVerifyRequest) {
    return verifyEmailRepository.verifyEmail(emailVerifyRequest);
  }
}