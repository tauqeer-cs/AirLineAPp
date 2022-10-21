// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupRequest _$SignupRequestFromJson(Map<String, dynamic> json) =>
    SignupRequest(
      title: json['Title'] as String?,
      firstName: json['FirstName'] as String?,
      lastName: json['LastName'] as String?,
      email: json['Email'] as String?,
      phoneCode: json['PhoneCode'] as String?,
      phoneNumber: json['PhoneNumber'] as String?,
      password: json['Password'] as String?,
      gender: json['Gender'] as String?,
      dob: json['DOB'] == null ? null : DateTime.parse(json['DOB'] as String),
      address: json['Address'] as String?,
      country: json['Country'] as String?,
      state: json['State'] as String?,
      city: json['City'] as String?,
      postCode: json['PostCode'] as String?,
      referralCode: json['ReferralCode'] as String?,
      confirmPassword: json['ConfirmPassword'] as String?,
    );

Map<String, dynamic> _$SignupRequestToJson(SignupRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Title', instance.title);
  writeNotNull('FirstName', instance.firstName);
  writeNotNull('LastName', instance.lastName);
  writeNotNull('Email', instance.email);
  writeNotNull('PhoneCode', instance.phoneCode);
  writeNotNull('PhoneNumber', instance.phoneNumber);
  writeNotNull('Password', instance.password);
  writeNotNull('Gender', instance.gender);
  writeNotNull('DOB', instance.dob?.toIso8601String());
  writeNotNull('Address', instance.address);
  writeNotNull('Country', instance.country);
  writeNotNull('State', instance.state);
  writeNotNull('City', instance.city);
  writeNotNull('PostCode', instance.postCode);
  writeNotNull('ReferralCode', instance.referralCode);
  writeNotNull('ConfirmPassword', instance.confirmPassword);
  return val;
}
