import 'package:dio/dio.dart';
import 'package:e_commerce_frontend/scr/core/utils/helpers/token_management_helper/token_management_helper.dart';
import 'package:e_commerce_frontend/scr/data/datasources/auth_datasource/auth_datasource.dart';
import 'package:e_commerce_frontend/scr/data/repositories/login_repository_imp.dart';
import 'package:e_commerce_frontend/scr/domain/repositories/login_repository.dart';
import 'package:e_commerce_frontend/scr/domain/usecases/login_usecase.dart';
import 'package:e_commerce_frontend/scr/presentation/bloc/login/login_bloc.dart';
import 'package:e_commerce_frontend/scr/presentation/bloc/oauth_authentication/oauth_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> init() async {
  locator.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
  locator.registerLazySingleton<TokenManagerHelper>(
    () => TokenManagerHelper(locator()),
  );
  locator.registerLazySingleton<Dio>(() => Dio());

  locator.registerLazySingleton<AuthDatasource>(
    () => AuthDatasource(locator()),
  );
  locator.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImp(datasource: locator()),
  );
  locator.registerLazySingleton<LoginUsecase>(() => LoginUsecase(locator()));
  locator.registerFactory<OAuthAuthenticationBloc>(
    () => OAuthAuthenticationBloc(),
  );
  locator.registerFactory<LoginBloc>(() => LoginBloc(locator(), locator()));
}
