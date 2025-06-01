part of 'email_verify_bloc.dart';

@freezed
class EmailVerifyEvent with _$EmailVerifyEvent {
  const factory EmailVerifyEvent.initial() = Initial;
  const factory EmailVerifyEvent.verifyEmail(EmailVerifyRequestModel emailVerifyRequestModel) = VerifyEmailEvent;
  const factory EmailVerifyEvent.resendVerificationEmail() =
      ResendVerificationEmailEvent;
}