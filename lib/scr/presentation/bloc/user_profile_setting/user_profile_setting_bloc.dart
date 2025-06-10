import 'dart:async';
import 'dart:convert';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:e_commerce_frontend/scr/core/common_domain/entities/based_api_result/api_result_model.dart';
import 'package:e_commerce_frontend/scr/core/common_domain/enum/user_gender_enum.dart';
import 'package:e_commerce_frontend/scr/core/utils/constants/constants.dart';
import 'package:e_commerce_frontend/scr/core/utils/helpers/shared_pref_management_helper/shared_pref_management_helper.dart';
import 'package:e_commerce_frontend/scr/data/models/request/user_request_model/user_request_model.dart';
import 'package:e_commerce_frontend/scr/domain/entities/user_info_entity/user_info_entity.dart';
import 'package:e_commerce_frontend/scr/domain/usecases/user_usecase/get_user_info_usecase.dart';
import 'package:e_commerce_frontend/scr/domain/usecases/user_usecase/update_user_info_partially_usecase.dart';
import 'package:e_commerce_frontend/scr/domain/usecases/user_usecase/update_user_info_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_setting_event.dart';
part 'user_profile_setting_state.dart';
part 'user_profile_setting_bloc.freezed.dart';

class UserProfileSettingBloc
    extends Bloc<UserProfileSettingEvent, UserProfileSettingState> {
  final SharedPrefManagementHelper sharedPrefManagementHelper;
  final GetUserInfoUsecase getUserInfoUsecase;
  final UpdateUserInfoPartiallyUsecase updateUserProfilePartiallyUsecase;
  final UpdateUserInfoUsecase updateUserProfileUsecase;
  UserInfoEntity? _userInfo;
  String? _tempFullName;
  String? _tempPhoneNumber;
  DateTime? _tempBirthday;
  Gender? _tempGender;

  UserProfileSettingBloc({
    required this.sharedPrefManagementHelper,
    required this.getUserInfoUsecase,
    required this.updateUserProfilePartiallyUsecase,
    required this.updateUserProfileUsecase,
  }) : super(const UserProfileInitial()) {
    on<Initial>(_onInitial);
    on<LoadUser>(_onLoadUser);
    on<UpdateUserProfile>(_onUpdateUserProfile);
    on<UpdateUserProfilePartially>(_onUpdateUserProfilePartially);
    on<UpdateFullName>(_onUpdateFullName, transformer: restartable());
    on<UpdatePhone>(_onUpdatePhoneNumber, transformer: restartable());
    on<UpdateGender>(_onUpdateGender);
    on<UpdateDate>(_onUpdateBirthday);
  }

  FutureOr<void> _onInitial(
    Initial event,
    Emitter<UserProfileSettingState> emit,
  ) {
    emit(const UserProfileInitial());
  }

  FutureOr<void> _onLoadUser(
    LoadUser event,
    Emitter<UserProfileSettingState> emit,
  ) async {
    emit(const UserProfileLoading());
    final userInfoJson = sharedPrefManagementHelper.getKeyString(USER);
    if (userInfoJson.isEmpty) {
      emit(const UserProfileError(message: 'User not found'));
      return;
    } else {
      try {
        var userJsonDecode = json.decode(userInfoJson) as Map<String, dynamic>;
        _userInfo = UserInfoEntity.fromJson(userJsonDecode);
        _tempFullName = _userInfo!.name;
        _tempPhoneNumber = _userInfo!.phoneNumber;
        _tempGender = _userInfo!.gender;
        _tempBirthday = _userInfo!.birthday;
        emit(UserProfileLoaded(userInfo: _userInfo!));
      } catch (e) {
        print('Failed to load user profile: ${e.toString()}');
        emit(UserProfileError(message: 'Failed to load user profile'));
      }
    }
  }

  FutureOr<void> _onUpdateUserProfile(
    UpdateUserProfile event,
    Emitter<UserProfileSettingState> emit,
  ) {}

  FutureOr<void> _onUpdateUserProfilePartially(
    UpdateUserProfilePartially event,
    Emitter<UserProfileSettingState> emit,
  ) async {
    emit(const UserProfileLoading());
    var result = await updateUserProfilePartiallyUsecase.call(event.userInfo);
    switch (result) {
      case Success():
        _userInfo = result.data;
        sharedPrefManagementHelper.saveKeyString(
          USER,
          json.encode(_userInfo?.toJson()),
        );
        emit(UserProfileUpdated(userInfo: _userInfo!));
      case Failure():
        emit(
          UserProfileError(
            message: result.errorResultModel.message ?? 'Update Error!',
          ),
        );
    }
  }

  void _emitLoadedStateWithTempValues(Emitter<UserProfileSettingState> emit) {
    if (_userInfo != null) {
      emit(
        UserProfileLoaded(
          userInfo: _userInfo!.copyWith(
            name: _tempFullName,
            phoneNumber: _tempPhoneNumber,
            gender: _tempGender,
            birthday: _tempBirthday,
          ),
        ),
      );
    }
  }

  FutureOr<void> _onUpdateFullName(
    UpdateFullName event,
    Emitter<UserProfileSettingState> emit,
  ) async {
    emit(const UserProfileLoading());
    _tempFullName = event.fullName;
    _emitLoadedStateWithTempValues(emit);
    await Future.delayed(Duration(milliseconds: 500));
  }

  FutureOr<void> _onUpdatePhoneNumber(
    UpdatePhone event,
    Emitter<UserProfileSettingState> emit,
  ) async {
    emit(const UserProfileLoading());
    _tempPhoneNumber = event.phone;
    _emitLoadedStateWithTempValues(emit);
    await Future.delayed(Duration(milliseconds: 500));
  }

  FutureOr<void> _onUpdateGender(
    UpdateGender event,
    Emitter<UserProfileSettingState> emit,
  ) {
    emit(const UserProfileLoading());
    _tempGender = event.gender;
    _emitLoadedStateWithTempValues(emit);
  }

  FutureOr<void> _onUpdateBirthday(
    UpdateDate event,
    Emitter<UserProfileSettingState> emit,
  ) {
    emit(const UserProfileLoading());
    _tempBirthday = event.date;
    _emitLoadedStateWithTempValues(emit);
  }
}
