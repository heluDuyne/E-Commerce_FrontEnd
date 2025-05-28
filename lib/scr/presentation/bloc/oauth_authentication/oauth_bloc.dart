import 'dart:async';

import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/facebook_oauth2_client.dart';
import 'package:oauth2_client/google_oauth2_client.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';

part 'oauth_event.dart';
part 'oauth_state.dart';
part 'oauth_bloc.freezed.dart';

class OAuthAuthenticationBloc
    extends Bloc<OAuthAuthenticationEvent, OAuthAuthenticationState> {
  OAuthAuthenticationBloc() : super(OAuthAuthenticationState.initial()) {
    on<Initial>(_onInitial);
    on<AuthenticateWithGoogle>(_onAuthenticateWithGoogle);
    on<AuthenticateWithFacebook>(_onAuthenticateWithFacebook);
  }

  FutureOr<void> _onInitial(event, Emitter<OAuthAuthenticationState> emit) {
    emit(const OAuthAuthenticationState.initial());
  }

  FutureOr<void> _onAuthenticateWithGoogle(
    event,
    Emitter<OAuthAuthenticationState> emit,
  ) async {
    emit(const OAuthAuthenticationState.authenticating());
    OAuth2Client client = GoogleOAuth2Client(
      customUriScheme: 'ecommerce',
      redirectUri: 'ecommerce:/oauth2redirect',
    );

    OAuth2Helper helper = OAuth2Helper(
      client,
      grantType: OAuth2Helper.authorizationCode,
      clientId:
          '768211896051-bsbb7gvetornblap7qu9btc76gf017tg.apps.googleusercontent.com',
      scopes: [
        'https://www.googleapis.com/auth/userinfo.email',
        'https://www.googleapis.com/auth/userinfo.profile',
        'https://www.googleapis.com/auth/user.phonenumbers.read',
        'https://www.googleapis.com/auth/user.birthday.read',
        'https://www.googleapis.com/auth/user.addresses.read',
      ],
    );

    AccessTokenResponse? response = await helper.getToken();
    if (response != null &&
        response.accessToken != null &&
        response.accessToken!.isNotEmpty) {
      print('Access token: ${response.accessToken}');
      emit(const OAuthAuthenticationState.authenticated());
    } else {
      emit(
        const OAuthAuthenticationState.error(
          'Error getting access token from Authentication server',
        ),
      );
    }
  }

  FutureOr<void> _onAuthenticateWithFacebook(
    event,
    Emitter<OAuthAuthenticationState> emit,
  ) async {
    emit(const OAuthAuthenticationState.authenticating());
    try {
      OAuth2Client client = FacebookOAuth2Client(
        customUriScheme: 'ecoommerce',
        redirectUri: 'ecommerce://oauth2redirect',
      );

      OAuth2Helper helper = OAuth2Helper(
        client,
        grantType: OAuth2Helper.authorizationCode,
        clientId: '668864852610873',
        clientSecret: 'f728d0e250652fe06f4bdd6639819491',
        scopes: ['openid', 'email', 'public_profile'],
      );

      AccessTokenResponse? response = await helper.getToken();
      if (response != null &&
          response.accessToken != null &&
          response.accessToken!.isNotEmpty) {
        emit(const OAuthAuthenticationState.authenticated());
      } else {
        emit(
          const OAuthAuthenticationState.error(
            'Error getting access token from Authentication server',
          ),
        );
      }
    } catch (e) {
      print('Error initializing Facebook OAuth2 client: $e');
      emit(
        const OAuthAuthenticationState.error(
          'Error initializing Facebook OAuth2 client',
        ),
      );
      return;
    }
  }
}
