part of 'oauth_bloc.dart';

@freezed
class OAuthAuthenticationEvent with _$OAuthAuthenticationEvent {
  const factory OAuthAuthenticationEvent.initial() = Initial;
  const factory OAuthAuthenticationEvent.authenticateWithGoogle() =
      AuthenticateWithGoogle;
  const factory OAuthAuthenticationEvent.authenticateWithFacebook() =
      AuthenticateWithFacebook;
}
