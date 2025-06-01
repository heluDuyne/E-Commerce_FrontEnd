import 'package:json_annotation/json_annotation.dart';

part 'email_verify_request_model.g.dart';

@JsonSerializable()
class EmailVerifyRequestModel {
  final String email;
  @JsonKey(name: 'verification_code')
  final String verificationCode;

  EmailVerifyRequestModel({
    required this.email,
    required this.verificationCode,
  });

  factory EmailVerifyRequestModel.fromJson(Map<String, dynamic> json) =>
      _$EmailVerifyRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmailVerifyRequestModelToJson(this);
}
