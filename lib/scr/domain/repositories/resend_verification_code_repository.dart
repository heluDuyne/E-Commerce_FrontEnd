import 'package:e_commerce_frontend/scr/core/common_domain/entities/based_api_result/api_result_model.dart';

abstract class ResendVerificationCodeRepository {
  Future<ApiResultModel<void>> resendVerificationCode();
}