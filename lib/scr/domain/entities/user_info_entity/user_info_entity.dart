import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_info_entity.g.dart';

@JsonSerializable()
class UserInfoEntity extends Equatable{
  final String email;
  final String name;
  final String address;
  final String phoneNumber;
  final DateTime birthday;
  final String image;
  final bool isVerified;

  const UserInfoEntity({
    required this.email,
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.birthday,
    required this.image,
    required this.isVerified,
  });

  @override
  List<Object?> get props => <Object?>[
    email,
    name,
    address,
    phoneNumber,
    birthday,
    image,
    isVerified,
  ];

  factory UserInfoEntity.fromJson(Map<String, dynamic> json) =>
      _$UserInfoEntityFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoEntityToJson(this);
}