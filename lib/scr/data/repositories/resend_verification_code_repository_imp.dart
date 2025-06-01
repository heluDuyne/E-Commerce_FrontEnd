import 'package:e_commerce_frontend/scr/core/common_domain/entities/based_api_result/api_result_model.dart';
import 'package:e_commerce_frontend/scr/data/datasources/auth_datasource/auth_datasource.dart';
import 'package:e_commerce_frontend/scr/data/repositories/base_repository.dart';
import 'package:e_commerce_frontend/scr/domain/repositories/resend_verification_code_repository.dart';

class ResendVerificationCodeRepositoryImp extends BaseRepository implements ResendVerificationCodeRepository{
  final AuthDatasource datasource;
  ResendVerificationCodeRepositoryImp({required this.datasource});

  @override
  Future<ApiResultModel<void>> resendVerificationCode() {
    return baseExecute(() => datasource.getVerificationCode());
  }
}