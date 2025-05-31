part of 'signup_bloc.dart';

@freezed
class SignupState with _$SignupState {
  const factory SignupState.initial() = SignUpInitial;

  const factory SignupState.loading() = SigningUp;

  const factory SignupState.success({required UserInfoEntity userInfo}) =
      SignupSuccess;

  const factory SignupState.error(String message) = SignUpError;
}
