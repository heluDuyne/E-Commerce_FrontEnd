part of 'login_bloc.dart';

@freezed
class  LoginState with _$LoginState {
  const factory LoginState.initial() = LoginInitial;
  const factory LoginState.logingin() = LogingIn;
  const factory LoginState.loggedIn() = LoggedIn;
  const factory LoginState.error(String errorMessage) = LoginError;
}