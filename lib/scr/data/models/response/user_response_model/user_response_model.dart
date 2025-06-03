import 'package:e_commerce_frontend/scr/core/common_domain/enum/user_gender_enum.dart';
import 'package:e_commerce_frontend/scr/core/utils/mapper/data_mapper.dart';
import 'package:e_commerce_frontend/scr/domain/entities/user_info_entity/user_info_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_response_model.g.dart';

@JsonSerializable()
class UserResponseModel extends DataMapper<UserInfoEntity> {
  final String? email;
  final String? name;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  final String? address;
  final DateTime? birthday;
  @JsonKey(name: 'image')
  final String? profilePictureUrl;
  @JsonKey(name: 'is_verified')
  final bool? isVerified;
  @JsonKey(
    fromJson: _genderFromJson,
    toJson: _genderToJson,
  )
  final Gender? gender;

  UserResponseModel({
    this.email,
    this.name,
    this.phoneNumber,
    this.address,
    this.profilePictureUrl,
    this.birthday,
    this.isVerified,
    this.gender,
  });

  factory UserResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseModelToJson(this);

  static _genderFromJson(String? code) {
    if (code == null) return null;
    return Gender.values.firstWhere(
      (gender) => gender.code == code,
      orElse: () => Gender.other,
    );
  }

  static String? _genderToJson(Gender? gender) => gender?.code;

  @override
  UserInfoEntity mapToEntity() {
    return UserInfoEntity(
      email: email ?? '',
      name: name ?? '',
      address: address ?? '',
      phoneNumber: phoneNumber ?? '',
      birthday: birthday ?? DateTime.now(),
      image: profilePictureUrl ?? '',
      isVerified: isVerified ?? false,
      gender: gender ?? Gender.other,
    );
  }
}
