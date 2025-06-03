import 'package:e_commerce_frontend/scr/core/common_domain/enum/user_gender_enum.dart';
import 'package:intl/intl.dart';
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
  @JsonKey(fromJson: _birthdayFromJson, toJson: _birthdayToJson)
  final DateTime? birthday;
  @JsonKey(fromJson: _genderFromJson, toJson: _genderToJson)
  final Gender? gender;

  const UserRequestModel({
    this.email,
    this.password,
    this.name,
    this.phoneNumber,
    this.address,
    this.birthday,
    this.gender,
  });

  factory UserRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UserRequestModelFromJson(json);

  Map<String, dynamic> toJson({bool includeNulls = false}) {
    var json = _$UserRequestModelToJson(this);
    if (!includeNulls) {
      // Remove null fields for partial updates
      json.removeWhere((key, value) => value == null);
    }
    return json;
  }

  static DateTime? _birthdayFromJson(String? dateString) {
    if (dateString == null || dateString.isEmpty) return null;
    try {
      return DateFormat('yyyy-MM-dd').parse(dateString);
    } catch (e) {
      return null;
    }
  }

  static String? _birthdayToJson(DateTime? date) {
    if (date == null) return null;
    // Format as yyyy-MM-dd
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static _genderFromJson(String? code) {
    if (code == null) return null;
    return Gender.values.firstWhere(
      (gender) => gender.code == code,
      orElse: () => Gender.other,
    );
  }

  static String? _genderToJson(Gender? gender) => gender?.code;
}
