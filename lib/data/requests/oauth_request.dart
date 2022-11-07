import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'oauth_request.g.dart';

@JsonSerializable()
class OauthRequest extends Equatable {
  const OauthRequest({
    this.platform,
    this.token,
    this.fcmToken,
  });

  factory OauthRequest.fromJson(Map<String, dynamic> json) =>
      _$OauthRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OauthRequestToJson(this);

  final String? platform;
  final String? token;
  final String? fcmToken;

  OauthRequest copyWith({
    String? platform,
    String? token,
    String? fcmToken,
  }) =>
      OauthRequest(
        platform: platform ?? this.platform,
        token: token ?? this.token,
        fcmToken: fcmToken ?? this.fcmToken,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
        platform,
        token,
        fcmToken,
      ];
}
