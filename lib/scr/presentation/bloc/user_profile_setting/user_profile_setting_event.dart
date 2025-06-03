part of 'user_profile_setting_bloc.dart';

@freezed
class UserProfileSettingEvent with _$UserProfileSettingEvent {
  const factory UserProfileSettingEvent.initial() = Initial;
  const factory UserProfileSettingEvent.loadUser() = LoadUser;
  const factory UserProfileSettingEvent.updateUserProfile({required UserRequestModel userInfo}) = UpdateUserProfile;
  const factory UserProfileSettingEvent.updateUserProfilePartially({required UserRequestModel userInfo}) = UpdateUserProfilePartially;
  const factory UserProfileSettingEvent.updateGender({required Gender? gender}) = UpdateGender;
  const factory UserProfileSettingEvent.updateDate({required DateTime? date}) = UpdateDate;
  const factory UserProfileSettingEvent.updateFullName({required String fullName}) = UpdateFullName;
  const factory UserProfileSettingEvent.updatePhone({required String? phone}) = UpdatePhone;
}