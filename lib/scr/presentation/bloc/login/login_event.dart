part of 'login_bloc.dart';

@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.initial() = Initial;
  const factory LoginEvent.login(LoginRequestModel loginRequestModel) = SignInEvent;
}
