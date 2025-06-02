import 'dart:async';
import 'dart:convert';

import 'package:e_commerce_frontend/scr/core/common_domain/entities/based_api_result/api_result_model.dart';
import 'package:e_commerce_frontend/scr/core/common_domain/usecases/base_params_usecase.dart';
import 'package:e_commerce_frontend/scr/core/utils/constants/constants.dart';
import 'package:e_commerce_frontend/scr/core/utils/helpers/shared_pref_management_helper/shared_pref_management_helper.dart';
import 'package:e_commerce_frontend/scr/core/utils/helpers/token_management_helper/token_management_helper.dart';
import 'package:e_commerce_frontend/scr/data/models/request/login_request_model/login_request_model.dart';
import 'package:e_commerce_frontend/scr/domain/usecases/login_usecase.dart';
import 'package:e_commerce_frontend/scr/domain/usecases/user_usecase/get_user_info_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase loginUsecase;
  final GetUserInfoUsecase getUserInfoUsecase;
  final TokenManagerHelper tokenManagerHelper;
  final SharedPrefManagementHelper sharedPrefManagementHelper;
  LoginBloc({
    required this.loginUsecase,
    required this.getUserInfoUsecase,
    required this.tokenManagerHelper,
    required this.sharedPrefManagementHelper,
  }) : super(LoginState.initial()) {
    on<Initial>(_onInitial);
    on<SignInEvent>(_onLogin);
  }

  FutureOr<void> _onInitial(Initial event, Emitter<LoginState> emit) {
    emit(const LoginState.initial());
  }

  FutureOr<void> _onLogin(SignInEvent event, Emitter<LoginState> emit) async {
    emit(const LoginState.logingin());
    var result = await loginUsecase.call(event.loginRequestModel);
    switch (result) {
      case Success():
        if (result.data == null) {
          emit(LoginState.error("Login failed, no token received"));
          return;
        }
        var tokenJson = result.data ?? '';
        var token = jsonDecode(tokenJson) as Map<String, dynamic>;
        var isSaved = await tokenManagerHelper.saveToken(token['token']);
        if (!isSaved) {
          emit(LoginState.error("Failed to save token"));
          return;
        }
        var userInfoResult = await getUserInfoUsecase.call(NoParams());
        switch (userInfoResult) {
          case Success():
            if (userInfoResult.data.email.isEmpty ||
                userInfoResult.data.name.isEmpty) {
              emit(LoginState.error("Failed to retrieve user info"));
              return;
            }
            await sharedPrefManagementHelper.saveKeyString(
              USER,
              json.encode(userInfoResult.data.toJson()),
            );
          case Failure():
            print(userInfoResult.errorResultModel.message);
            emit(LoginState.error("Failed to retrieve user info"));
            return;
        }
        emit(const LoginState.loggedIn());
      case Failure():
        emit(
          LoginState.error(
            result.errorResultModel.message ?? "There's something wrong",
          ),
        );
    }
  }
}
