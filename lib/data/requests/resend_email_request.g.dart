// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resend_email_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResendEmailRequest _$ResendEmailRequestFromJson(Map<String, dynamic> json) =>
    ResendEmailRequest(
      email: json['Email'] as String?,
    );

Map<String, dynamic> _$ResendEmailRequestToJson(ResendEmailRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Email', instance.email);
  return val;
}
