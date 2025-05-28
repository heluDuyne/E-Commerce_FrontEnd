import 'package:json_annotation/json_annotation.dart';

part 'oauth_request_model.g.dart';

@JsonSerializable()
class OauthRequestModel {
  final String? type;
  final String? accessToken;

  const OauthRequestModel({
    this.type,
    this.accessToken,
  });

  factory OauthRequestModel.fromJson(Map<String, dynamic> json) =>
      _$OauthRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$OauthRequestModelToJson(this);
}