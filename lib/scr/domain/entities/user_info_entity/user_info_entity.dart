import 'package:e_commerce_frontend/scr/core/common_domain/enum/user_gender_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_info_entity.g.dart';

@JsonSerializable()
class UserInfoEntity extends Equatable {
  final String email;
  final String name;
  final String address;
  final String phoneNumber;
  final DateTime birthday;
  final String image;
  final bool isVerified;
  final Gender gender;

  const UserInfoEntity({
    required this.email,
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.birthday,
    required this.image,
    required this.isVerified,
    required this.gender,
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
    gender,
  ];

  UserInfoEntity copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    String? address,
    String? image,
    bool? isVerified,
    Gender? gender,
    DateTime? birthday,
  }) {
    return UserInfoEntity(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      image: image ?? this.image,
      isVerified: isVerified ?? this.isVerified,
      address: address ?? this.address,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
    );
  }

  factory UserInfoEntity.fromJson(Map<String, dynamic> json) =>
      _$UserInfoEntityFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoEntityToJson(this);
}
