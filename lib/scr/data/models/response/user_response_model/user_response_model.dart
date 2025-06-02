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

  UserResponseModel({
    this.email,
    this.name,
    this.phoneNumber,
    this.address,
    this.profilePictureUrl,
    this.birthday,
    this.isVerified,
  });

  factory UserResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseModelToJson(this);

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
    );
  }
}
