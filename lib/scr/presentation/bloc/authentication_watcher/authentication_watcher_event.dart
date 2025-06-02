part of 'authentication_watcher_bloc.dart';

@freezed
class AuthenticationWatcherEvent with _$AuthenticationWatcherEvent {
  const factory AuthenticationWatcherEvent.authCheckRequest() = AuthCheckRequest;
  const factory AuthenticationWatcherEvent.signOut() = SignOut;
}