import 'dart:async';
import 'dart:convert';

import 'package:e_commerce_frontend/scr/core/common_domain/entities/based_api_result/api_result_model.dart';
import 'package:e_commerce_frontend/scr/core/common_domain/usecases/base_params_usecase.dart';
import 'package:e_commerce_frontend/scr/core/utils/constants/constants.dart';
import 'package:e_commerce_frontend/scr/core/utils/helpers/shared_pref_management_helper/shared_pref_management_helper.dart';
import 'package:e_commerce_frontend/scr/core/utils/helpers/token_management_helper/token_management_helper.dart';
import 'package:e_commerce_frontend/scr/domain/entities/user_info_entity/user_info_entity.dart';
import 'package:e_commerce_frontend/scr/domain/usecases/user_usecase/get_user_info_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication_watcher_event.dart';
part 'authentication_watcher_state.dart';
part 'authentication_watcher_bloc.freezed.dart';

class AuthenticationWatcherBloc
    extends Bloc<AuthenticationWatcherEvent, AuthenticationWatcherState> {
  final TokenManagerHelper tokenManagementHelper;
  final SharedPrefManagementHelper sharedPrefManagementHelper;
  final GetUserInfoUsecase getUserInfoUsecase;
  AuthenticationWatcherBloc({
    required this.getUserInfoUsecase,
    required this.tokenManagementHelper,
    required this.sharedPrefManagementHelper,
  }) : super(const AuthenticationWatcherState.initial()) {
    on<AuthCheckRequest>(_onAuthCheckRequest);
    on<SignOut>(_onSignOut);
  }

  FutureOr<void> _onAuthCheckRequest(
    AuthCheckRequest event,
    Emitter<AuthenticationWatcherState> emit,
  ) async {
    emit(const Authenticating());
    var token = await tokenManagementHelper.getToken();
    if (token.isNotEmpty) {
      var userInfoString = sharedPrefManagementHelper.getKeyString(USER);
      if (userInfoString.isNotEmpty) {
        var userInfoJson = json.decode(userInfoString) as Map<String, dynamic>;
        var userInfo = UserInfoEntity.fromJson(userInfoJson);
        if (userInfo.email.isEmpty || userInfo.name.isEmpty) {
          _getUser(event, emit, userInfo);
          return;
        } else {
          if (userInfo.isVerified == false) {
            print('User is not verified: ${userInfo.email}');
            emit(
              IsNotVerified(
                message: 'Please verify your email to continue!',
                email: userInfo.email,
              ),
            );
            return;
          }
          emit(Authenticated(userInfo, 'Welcome back ${userInfo.name}!'));
          return;
        }
      } else {
        var userInfoJson = json.decode(userInfoString) as Map<String, dynamic>;
        var userInfo = UserInfoEntity.fromJson(userInfoJson);
        _getUser(event, emit, userInfo);
        return;
      }
    } else {
      emit(const Unauthenticated('Please log in to continue!'));
    }
  }

  FutureOr<void> _onSignOut(
    SignOut event,
    Emitter<AuthenticationWatcherState> emit,
  ) async {
    bool isDeleted = await tokenManagementHelper.deleteToken();
    if (isDeleted) {
      sharedPrefManagementHelper.deleteKeyString(USER);
      emit(const Unauthenticated('Signed out successfully!'));
    } else {
      emit(const AuthenticationWatcherError('Failed to sign out'));
    }
  }

  Future<void> _getUser(
    AuthCheckRequest event,
    Emitter<AuthenticationWatcherState> emit,
    UserInfoEntity userInfo,
  ) async {
    var result = await getUserInfoUsecase.call(NoParams());
    switch (result) {
      case Success():
        userInfo = result.data;
        sharedPrefManagementHelper.saveKeyString(
          USER,
          json.encode(userInfo.toJson()),
        );
        if (userInfo.isVerified == false) {
          print('User is not verified: ${userInfo.email}');
          emit(
            IsNotVerified(
              message: 'Please verify your email to continue!',
              email: userInfo.email,
            ),
          );
          return;
        }
        emit(Authenticated(userInfo, 'Welcome back ${userInfo.name}!'));
      case Failure():
        print('Failed to fetch user info: ${result.errorResultModel.message}');
        emit(AuthenticationWatcherError('Failed to fetch user info'));
    }
  }
}
