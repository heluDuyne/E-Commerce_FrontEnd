part of 'email_verify_bloc.dart';

@freezed
class EmailVerifyState with _$EmailVerifyState {
  const factory EmailVerifyState.initial() = EmailInitial;
  const factory EmailVerifyState.verifying() = EmailVerifying;
  const factory EmailVerifyState.verified() = EmailVerified;
  const factory EmailVerifyState.error(String message) = EmailVerifyError;
  const factory EmailVerifyState.resendVerified() = EmailResended;
  const factory EmailVerifyState.resendError(String message) = ResendError;
}