import 'package:dio/dio.dart';
import 'package:e_commerce_frontend/scr/presentation/bloc/oauth_authentication/oauth_bloc.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> init() async {
  locator.registerFactory<OAuthAuthenticationBloc>(() => OAuthAuthenticationBloc());
}