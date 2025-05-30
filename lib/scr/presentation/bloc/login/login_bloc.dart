import 'dart:async';

import 'package:e_commerce_frontend/scr/core/common_domain/entities/based_api_result/api_result_model.dart';
import 'package:e_commerce_frontend/scr/core/utils/helpers/token_management_helper/token_management_helper.dart';
import 'package:e_commerce_frontend/scr/data/models/request/login_request_model.dart';
import 'package:e_commerce_frontend/scr/domain/usecases/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase loginUsecase;
  final TokenManagerHelper tokenManagerHelper;
  LoginBloc(this.loginUsecase, this.tokenManagerHelper)
    : super(LoginState.initial()) {
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
        var token = 'Token${result.data}';
        var isSaved = await tokenManagerHelper.saveToken(token);
        if (!isSaved) {
          emit(LoginState.error("Failed to save token"));
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
