// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupRequest _$SignupRequestFromJson(Map<String, dynamic> json) =>
    SignupRequest(
      title: json['title'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      phoneCode: json['phoneCode'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      password: json['password'] as String?,
      gender: json['gender'] as String?,
      dob: json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
      address: json['address'] as String?,
      country: json['country'] as String?,
      state: json['state'] as String?,
      city: json['city'] as String?,
      postCode: json['postCode'] as String?,
      referralCode: json['referralCode'] as String?,
      confirmPassword: json['confirmPassword'] as String?,
    );

Map<String, dynamic> _$SignupRequestToJson(SignupRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('firstName', instance.firstName);
  writeNotNull('lastName', instance.lastName);
  writeNotNull('email', instance.email);
  writeNotNull('phoneCode', instance.phoneCode);
  writeNotNull('phoneNumber', instance.phoneNumber);
  writeNotNull('password', instance.password);
  writeNotNull('gender', instance.gender);
  writeNotNull('dob', instance.dob?.toIso8601String());
  writeNotNull('address', instance.address);
  writeNotNull('country', instance.country);
  writeNotNull('state', instance.state);
  writeNotNull('city', instance.city);
  writeNotNull('postCode', instance.postCode);
  writeNotNull('referralCode', instance.referralCode);
  writeNotNull('confirmPassword', instance.confirmPassword);
  return val;
}
