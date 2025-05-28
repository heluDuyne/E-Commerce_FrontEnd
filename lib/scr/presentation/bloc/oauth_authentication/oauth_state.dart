part of 'oauth_bloc.dart';

@freezed
class OAuthAuthenticationState with _$OAuthAuthenticationState {
  const factory OAuthAuthenticationState.initial() = AuthenticationInitial;
  const factory OAuthAuthenticationState.authenticating() = Authenticating;
  const factory OAuthAuthenticationState.authenticated() = Authenticated;
  const factory OAuthAuthenticationState.error(String errorMessage) = Error;
}
