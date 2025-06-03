part of 'user_profile_setting_bloc.dart';

@freezed
class UserProfileSettingState with _$UserProfileSettingState {
  const factory UserProfileSettingState.initial() = UserProfileInitial;

  const factory UserProfileSettingState.loading() = UserProfileLoading;

  const factory UserProfileSettingState.loaded({
    required UserInfoEntity userInfo,
  }) = UserProfileLoaded;

  const factory UserProfileSettingState.updated({
    required UserInfoEntity userInfo,
  }) = UserProfileUpdated;

  const factory UserProfileSettingState.error({required String message}) =
      UserProfileError;
}