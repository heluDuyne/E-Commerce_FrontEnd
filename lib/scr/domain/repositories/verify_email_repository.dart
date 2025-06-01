import 'package:e_commerce_frontend/scr/core/common_domain/entities/based_api_result/api_result_model.dart';
import 'package:e_commerce_frontend/scr/data/models/request/email_verify_request_model/email_verify_request_model.dart';

abstract class VerifyEmailRepository {
  Future<ApiResultModel<void>> verifyEmail(EmailVerifyRequestModel emailVerifyRequest);
}