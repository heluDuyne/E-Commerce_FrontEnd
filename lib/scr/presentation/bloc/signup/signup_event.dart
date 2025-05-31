part of 'signup_bloc.dart';

@freezed
class SignupEvent with _$SignupEvent {
  const factory SignupEvent.initial() = Initial;
  const factory SignupEvent.signup(UserRequestModel userRequestModel) =
      CreateUserEvent;
}
