import 'dart:async';
import 'dart:convert';

import 'package:e_commerce_frontend/scr/core/common_domain/entities/based_api_result/api_result_model.dart';
import 'package:e_commerce_frontend/scr/core/utils/constants/constants.dart';
import 'package:e_commerce_frontend/scr/core/utils/helpers/shared_pref_management_helper/shared_pref_management_helper.dart';
import 'package:e_commerce_frontend/scr/core/utils/helpers/token_management_helper/token_management_helper.dart';
import 'package:e_commerce_frontend/scr/data/models/request/login_request_model/login_request_model.dart';
import 'package:e_commerce_frontend/scr/domain/usecases/login_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_frontend/scr/data/models/request/user_request_model/user_request_model.dart';
import 'package:e_commerce_frontend/scr/domain/usecases/signup_usecase.dart';
import 'package:e_commerce_frontend/scr/domain/entities/user_info_entity/user_info_entity.dart';

part 'signup_event.dart';
part 'signup_state.dart';
part 'signup_bloc.freezed.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupUsecase signupUsecase;
  final LoginUsecase loginUsecase;
  final TokenManagerHelper tokenManagerHelper;
  final SharedPrefManagementHelper sharedPrefManagementHelper;
  SignupBloc({
    required this.signupUsecase,
    required this.loginUsecase,
    required this.tokenManagerHelper,
    required this.sharedPrefManagementHelper,
  }) : super(SignupState.initial()) {
    on<Initial>(_InitialEvent);
    on<CreateUserEvent>(_onSignupEvent);
  }

  FutureOr<void> _InitialEvent(Initial event, Emitter<SignupState> emit) {
    emit(const SignupState.initial());
  }

  FutureOr<void> _onSignupEvent(
    CreateUserEvent event,
    Emitter<SignupState> emit,
  ) async {
    emit(const SignupState.loading());
    var result = await signupUsecase.call(event.userRequestModel);
    switch (result) {
      case Success():
        if (result.data == null) {
          emit(SignupState.error("Signup failed, no user info received"));
          return;
        } else {
          await sharedPrefManagementHelper.saveKey(
            USER,
            json.encode(result.data!.toJson()),
          );
          var loginResult = await loginUsecase.call(
            LoginRequestModel(
              email: result.data?.email,
              password: event.userRequestModel.password,
            ),
          );
          switch (loginResult) {
            case Success():
              if (loginResult.data == null) {
                emit(SignupState.error("Login failed, no token received"));
                return;
              }
              var json = loginResult.data ?? '';
              var token = jsonDecode(json) as Map<String, dynamic>;
              var isSaved = await tokenManagerHelper.saveToken(token['token']);
              if (!isSaved) {
                emit(SignupState.error("Failed to save token"));
                return;
              }
              emit(SignupState.success(userInfo: result.data!));
            case Failure():
              emit(
                SignupState.error(
                  loginResult.errorResultModel.message ?? "Login failed",
                ),
              );
              return;
          }
        }
      case Failure():
        emit(
          SignupState.error(
            result.errorResultModel.message ?? "Sign up failed",
          ),
        );
    }
  }
}
