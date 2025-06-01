import 'package:e_commerce_frontend/scr/core/common_domain/entities/based_api_result/api_result_model.dart';
import 'package:e_commerce_frontend/scr/data/datasources/auth_datasource/auth_datasource.dart';
import 'package:e_commerce_frontend/scr/data/models/request/email_verify_request_model/email_verify_request_model.dart';
import 'package:e_commerce_frontend/scr/data/repositories/base_repository.dart';
import 'package:e_commerce_frontend/scr/domain/repositories/verify_email_repository.dart';

class VerifyEmailRepositoryImp extends BaseRepository implements VerifyEmailRepository{
  final AuthDatasource datasource;
  VerifyEmailRepositoryImp({required this.datasource});

  @override
  Future<ApiResultModel<void>> verifyEmail(EmailVerifyRequestModel emailVerifyRequest) {
    return baseExecute(() => datasource.verifyEmailRequest(emailVerifyRequest));
  }
}