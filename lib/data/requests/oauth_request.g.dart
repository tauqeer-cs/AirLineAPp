// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oauth_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OauthRequest _$OauthRequestFromJson(Map<String, dynamic> json) => OauthRequest(
      platform: json['platform'] as String?,
      token: json['token'] as String?,
      fcmToken: json['fcmToken'] as String?,
    );

Map<String, dynamic> _$OauthRequestToJson(OauthRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('platform', instance.platform);
  writeNotNull('token', instance.token);
  writeNotNull('fcmToken', instance.fcmToken);
  return val;
}
