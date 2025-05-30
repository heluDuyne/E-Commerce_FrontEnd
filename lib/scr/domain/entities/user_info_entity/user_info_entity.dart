import 'package:equatable/equatable.dart';

class UserInfoEntity extends Equatable{
  final String email;
  final String name;
  final String address;
  final String phoneNumber;
  final DateTime birthday;
  final String image;

  const UserInfoEntity({
    required this.email,
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.birthday,
    required this.image,
  });

  @override
  List<Object?> get props => <Object?>[
    email,
    name,
    address,
    phoneNumber,
    birthday,
    image,
  ];
}