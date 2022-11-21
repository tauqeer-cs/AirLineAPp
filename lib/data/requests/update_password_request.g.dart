// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_password_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePasswordRequest _$UpdatePasswordRequestFromJson(
        Map<String, dynamic> json) =>
    UpdatePasswordRequest(
      email: json['Email'] as String?,
      previousPassword: json['PreviousPassword'] as String?,
      newPassword: json['NewPassword'] as String?,
      passphrase: json['Passphrase'] as String?,
      password: json['Password'] as String?,
    );

Map<String, dynamic> _$UpdatePasswordRequestToJson(
    UpdatePasswordRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Email', instance.email);
  writeNotNull('PreviousPassword', instance.previousPassword);
  writeNotNull('NewPassword', instance.newPassword);
  writeNotNull('Passphrase', instance.passphrase);
  writeNotNull('Password', instance.password);
  return val;
}
