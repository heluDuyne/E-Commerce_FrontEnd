part of 'authentication_watcher_bloc.dart';

@freezed
class AuthenticationWatcherState with _$AuthenticationWatcherState {
  const factory AuthenticationWatcherState.initial() =
      AuthenticationWatcherInitial;

  const factory AuthenticationWatcherState.authenticating() = Authenticating;

  const factory AuthenticationWatcherState.authenticated(
    UserInfoEntity? userInforEntity,
    String message,
  ) = Authenticated;

  const factory AuthenticationWatcherState.unauthenticated(String message) =
      Unauthenticated;

  const factory AuthenticationWatcherState.isNotVerified({
    required String message,
    required String email,
  }) = IsNotVerified;

  const factory AuthenticationWatcherState.error(String message) =
      AuthenticationWatcherError;
}
