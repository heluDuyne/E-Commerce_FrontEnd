import 'package:dio/dio.dart';
import 'package:e_commerce_frontend/scr/core/network/dio_interceptors.dart';
import 'package:e_commerce_frontend/scr/core/utils/helpers/shared_pref_management_helper/shared_pref_management_helper.dart';
import 'package:e_commerce_frontend/scr/core/utils/helpers/token_management_helper/token_management_helper.dart';
import 'package:e_commerce_frontend/scr/data/datasources/auth_datasource/auth_datasource.dart';
import 'package:e_commerce_frontend/scr/data/datasources/product_datasource/product_datasource.dart';
import 'package:e_commerce_frontend/scr/data/datasources/user_datasource/user_datasource.dart';
import 'package:e_commerce_frontend/scr/data/repositories/login_repository_imp.dart';
import 'package:e_commerce_frontend/scr/data/repositories/product_repository_imp.dart';
import 'package:e_commerce_frontend/scr/data/repositories/resend_verification_code_repository_imp.dart';
import 'package:e_commerce_frontend/scr/data/repositories/signup_repository_imp.dart';
import 'package:e_commerce_frontend/scr/data/repositories/user_repository_imp.dart';
import 'package:e_commerce_frontend/scr/data/repositories/verify_email_repository_imp.dart';
import 'package:e_commerce_frontend/scr/domain/repositories/login_repository.dart';
import 'package:e_commerce_frontend/scr/domain/repositories/product_repository.dart';
import 'package:e_commerce_frontend/scr/domain/repositories/resend_verification_code_repository.dart';
import 'package:e_commerce_frontend/scr/domain/repositories/signup_repository.dart';
import 'package:e_commerce_frontend/scr/domain/repositories/user_repository.dart';
import 'package:e_commerce_frontend/scr/domain/repositories/verify_email_repository.dart';
import 'package:e_commerce_frontend/scr/domain/usecases/login_usecase.dart';
import 'package:e_commerce_frontend/scr/domain/usecases/product_usecase/get_list_product_by_url_usecase.dart';
import 'package:e_commerce_frontend/scr/domain/usecases/product_usecase/get_list_product_usecase.dart';
import 'package:e_commerce_frontend/scr/domain/usecases/product_usecase/get_product_usecase.dart';
import 'package:e_commerce_frontend/scr/domain/usecases/resend_verification_code_usecase.dart';
import 'package:e_commerce_frontend/scr/domain/usecases/signup_usecase.dart';
import 'package:e_commerce_frontend/scr/domain/usecases/user_usecase/get_user_info_usecase.dart';
import 'package:e_commerce_frontend/scr/domain/usecases/user_usecase/update_user_info_partially_usecase.dart';
import 'package:e_commerce_frontend/scr/domain/usecases/user_usecase/update_user_info_usecase.dart';
import 'package:e_commerce_frontend/scr/domain/usecases/verify_email_usecase.dart';
import 'package:e_commerce_frontend/scr/presentation/bloc/authentication_watcher/authentication_watcher_bloc.dart';
import 'package:e_commerce_frontend/scr/presentation/bloc/email_verify/email_verify_bloc.dart';
import 'package:e_commerce_frontend/scr/presentation/bloc/generic_product/generic_product_bloc.dart';
import 'package:e_commerce_frontend/scr/presentation/bloc/login/login_bloc.dart';
import 'package:e_commerce_frontend/scr/presentation/bloc/oauth_authentication/oauth_bloc.dart';
import 'package:e_commerce_frontend/scr/presentation/bloc/product/product_bloc.dart';
import 'package:e_commerce_frontend/scr/presentation/bloc/signup/signup_bloc.dart';
import 'package:e_commerce_frontend/scr/presentation/bloc/user_profile_setting/user_profile_setting_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // Properties and helpers
  final share = await SharedPreferences.getInstance();
  locator.registerLazySingleton<SharedPrefManagementHelper>(
    () => SharedPrefManagementHelper(share),
  );
  locator.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
  locator.registerLazySingleton<TokenManagerHelper>(
    () => TokenManagerHelper(locator()),
  );
  locator.registerLazySingleton<Dio>(() {
    final dio = Dio();

    // Add logging interceptor
    dio.interceptors.add(LoggingInterceptor());

    // Add auth interceptor (after the token manager is registered)
    dio.interceptors.add(AuthInterceptor(tokenManagerHelper: locator()));

    // Optional: Add error handling interceptor
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) {
          // Handle common errors (e.g. 401, 404, etc.)
          if (error.response?.statusCode == 401) {
            // Handle unauthorized access (e.g. redirect to login)
          }
          return handler.next(error);
        },
      ),
    );

    return dio;
  });

  //Data sources
  locator.registerLazySingleton<AuthDatasource>(
    () => AuthDatasource(locator()),
  );
  locator.registerLazySingleton<UserDatasource>(
    () => UserDatasource(locator()),
  );
  locator.registerLazySingleton<ProductDatasource>(
    () => ProductDatasource(locator()),
  );

  // Register repositories
  locator.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImp(datasource: locator()),
  );
  locator.registerLazySingleton<SignupRepository>(
    () => SignupRepositoryImp(datasource: locator()),
  );
  locator.registerLazySingleton<VerifyEmailRepository>(
    () => VerifyEmailRepositoryImp(datasource: locator()),
  );
  locator.registerLazySingleton<ResendVerificationCodeRepository>(
    () => ResendVerificationCodeRepositoryImp(datasource: locator()),
  );
  locator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImp(datasource: locator()),
  );
  locator.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImp(datasource: locator()),
  );

  //Register use cases
  locator.registerLazySingleton<LoginUsecase>(() => LoginUsecase(locator()));
  locator.registerLazySingleton<SignupUsecase>(() => SignupUsecase(locator()));
  locator.registerLazySingleton<VerifyEmailUsecase>(
    () => VerifyEmailUsecase(verifyEmailRepository: locator()),
  );
  locator.registerLazySingleton<ResendVerificationCodeUsecase>(
    () => ResendVerificationCodeUsecase(
      resendVerificationCodeRepository: locator(),
    ),
  );
  locator.registerLazySingleton<GetUserInfoUsecase>(
    () => GetUserInfoUsecase(userRepository: locator()),
  );
  locator.registerLazySingleton<UpdateUserInfoUsecase>(
    () => UpdateUserInfoUsecase(userRepository: locator()),
  );
  locator.registerLazySingleton<UpdateUserInfoPartiallyUsecase>(
    () => UpdateUserInfoPartiallyUsecase(userRepository: locator()),
  );
  locator.registerLazySingleton<GetListProductUsecase>(
    () => GetListProductUsecase(productRepository: locator()),
  );
  locator.registerLazySingleton<GetListProductByUrlUsecase>(
    () => GetListProductByUrlUsecase(productRepository: locator()),
  );
  locator.registerLazySingleton<GetProductUsecase>(
    () => GetProductUsecase(productRepository: locator()),
  );

  // Register Blocs
  locator.registerFactory<OAuthAuthenticationBloc>(
    () => OAuthAuthenticationBloc(),
  );
  locator.registerFactory<LoginBloc>(
    () => LoginBloc(
      loginUsecase: locator(),
      getUserInfoUsecase: locator(),
      tokenManagerHelper: locator(),
      sharedPrefManagementHelper: locator(),
    ),
  );
  locator.registerFactory<SignupBloc>(
    () => SignupBloc(
      signupUsecase: locator(),
      loginUsecase: locator(),
      tokenManagerHelper: locator(),
      sharedPrefManagementHelper: locator(),
    ),
  );
  locator.registerFactory<EmailVerifyBloc>(
    () => EmailVerifyBloc(
      verifyEmailUsecase: locator(),
      resendVerificationCodeUsecase: locator(),
    ),
  );
  locator.registerLazySingleton<AuthenticationWatcherBloc>(
    () => AuthenticationWatcherBloc(
      getUserInfoUsecase: locator(),
      tokenManagementHelper: locator(),
      sharedPrefManagementHelper: locator(),
    ),
  );
  locator.registerFactory<UserProfileSettingBloc>(
    () => UserProfileSettingBloc(
      sharedPrefManagementHelper: locator(),
      getUserInfoUsecase: locator(),
      updateUserProfilePartiallyUsecase: locator(),
      updateUserProfileUsecase: locator(),
    ),
  );
  locator.registerFactory<GenericProductBloc>(
    () => GenericProductBloc(
      getListProductUsecase: locator(),
      getListProductByUrlUseCase: locator(),
      sharedPrefManagementHelper: locator(),
    ),
  );
  locator.registerFactory<ProductBloc>(
    () => ProductBloc(getProductUsecase: locator()),
  );
}
