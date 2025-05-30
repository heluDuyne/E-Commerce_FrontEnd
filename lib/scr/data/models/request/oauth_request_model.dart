import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class OauthRequestModel {
  final String? type;
  final String? accessToken;

  const OauthRequestModel({
    this.type,
    this.accessToken,
  });
}