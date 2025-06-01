import 'dart:async';

import 'package:e_commerce_frontend/scr/core/common_domain/entities/based_api_result/api_result_model.dart';
import 'package:e_commerce_frontend/scr/core/common_domain/usecases/base_params_usecase.dart';
import 'package:e_commerce_frontend/scr/data/models/request/email_verify_request_model/email_verify_request_model.dart';
import 'package:e_commerce_frontend/scr/domain/usecases/resend_verification_code_usecase.dart';
import 'package:e_commerce_frontend/scr/domain/usecases/verify_email_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_verify_event.dart';
part 'email_verify_state.dart';
part 'email_verify_bloc.freezed.dart';

class EmailVerifyBloc extends Bloc<EmailVerifyEvent, EmailVerifyState> {
  final VerifyEmailUsecase verifyEmailUsecase;
  final ResendVerificationCodeUsecase resendVerificationCodeUsecase;
  EmailVerifyBloc({
    required this.verifyEmailUsecase,
    required this.resendVerificationCodeUsecase,
  }) : super(const EmailVerifyState.initial()) {
    on<Initial>(_onInitial);
    on<VerifyEmailEvent>(_onVerifyEmail);
    on<ResendVerificationEmailEvent>(_onResendVerificationEmail);
  }

  FutureOr<void> _onInitial(Initial event, Emitter<EmailVerifyState> emit) {
    emit(const EmailVerifyState.initial());
  }

  Future<void> _onVerifyEmail(
    VerifyEmailEvent event,
    Emitter<EmailVerifyState> emit,
  ) async {
    emit(const EmailVerifyState.verifying());
    var result = await verifyEmailUsecase.call(event.emailVerifyRequestModel);
    switch (result) {
      case Success():
        emit(const EmailVerifyState.verified());
      case Failure():
        emit(
          const EmailVerifyState.error(
            "Verification failed. Please try again.",
          ),
        );
    }
  }

  Future<void> _onResendVerificationEmail(
    ResendVerificationEmailEvent event,
    Emitter<EmailVerifyState> emit,
  ) async {
    emit(const EmailVerifying());
    var result = await resendVerificationCodeUsecase.call(NoParams());
    switch (result) {
      case Success():
        emit(const EmailResended());
      case Failure():
        emit(
          const EmailVerifyState.resendError(
            "Resend verification code failed. Please try again.",
          ),
        );
    }
  }
}
