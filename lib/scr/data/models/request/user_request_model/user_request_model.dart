import 'package:json_annotation/json_annotation.dart';

part 'user_request_model.g.dart';

@JsonSerializable()
class UserRequestModel {
  final String? email;
  final String? password;
  final String? name;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  final String? address;
  final DateTime? birthday;
  @JsonKey(name: 'image')
  final String? profilePictureUrl;

  const UserRequestModel({
    this.email,
    this.password,
    this.name,
    this.phoneNumber,
    this.address,
    this.birthday,
    this.profilePictureUrl,
  });

  factory UserRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UserRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserRequestModelToJson(this);
}