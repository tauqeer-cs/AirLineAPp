// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      userID: json['userID'] as int?,
      userProfile: json['userProfile'] == null
          ? null
          : UserProfile.fromJson(json['userProfile'] as Map<String, dynamic>),
      communicationPreferences: json['communicationPreferences'] == null
          ? null
          : CommunicationPreferences.fromJson(
              json['communicationPreferences'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('userID', instance.userID);
  writeNotNull('userProfile', instance.userProfile?.toJson());
  writeNotNull(
      'communicationPreferences', instance.communicationPreferences?.toJson());
  return val;
}

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      title: json['title'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      nationality: json['nationality'] as String?,
      icNumber: json['icNumber'] as String?,
      dob: json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
      phoneCode: json['phoneCode'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      postCode: json['postCode'] as String?,
      country: json['country'] as String?,
      memberID: json['memberID'] as int?,
      referralCode: json['referralCode'] as String?,
      referralBy: json['referralBy'] as String?,
      email: json['email'] as String?,
      emergencyContact: json['emergencyContact'] == null
          ? null
          : EmergencyContact.fromJson(
              json['emergencyContact'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('firstName', instance.firstName);
  writeNotNull('lastName', instance.lastName);
  writeNotNull('nationality', instance.nationality);
  writeNotNull('icNumber', instance.icNumber);
  writeNotNull('dob', instance.dob?.toIso8601String());
  writeNotNull('phoneCode', instance.phoneCode);
  writeNotNull('phoneNumber', instance.phoneNumber);
  writeNotNull('address', instance.address);
  writeNotNull('city', instance.city);
  writeNotNull('state', instance.state);
  writeNotNull('postCode', instance.postCode);
  writeNotNull('email', instance.email);
  writeNotNull('emergencyContact', instance.emergencyContact?.toJson());
  writeNotNull('country', instance.country);
  writeNotNull('memberID', instance.memberID);
  writeNotNull('referralCode', instance.referralCode);
  writeNotNull('referralBy', instance.referralBy);
  return val;
}

CommunicationPreferences _$CommunicationPreferencesFromJson(
        Map<String, dynamic> json) =>
    CommunicationPreferences(
      email: json['email'] as bool?,
      webPushNotification: json['webPushNotification'] as bool?,
      whatsapp: json['whatsapp'] as bool?,
      sms: json['sms'] as bool?,
    );

Map<String, dynamic> _$CommunicationPreferencesToJson(
    CommunicationPreferences instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('email', instance.email);
  writeNotNull('webPushNotification', instance.webPushNotification);
  writeNotNull('whatsapp', instance.whatsapp);
  writeNotNull('sms', instance.sms);
  return val;
}

EmergencyContact _$EmergencyContactFromJson(Map<String, dynamic> json) =>
    EmergencyContact(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      relationship: json['relationship'] as String?,
      phoneCode: json['phoneCode'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
    );

Map<String, dynamic> _$EmergencyContactToJson(EmergencyContact instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('firstName', instance.firstName);
  writeNotNull('lastName', instance.lastName);
  writeNotNull('relationship', instance.relationship);
  writeNotNull('phoneCode', instance.phoneCode);
  writeNotNull('phoneNumber', instance.phoneNumber);
  return val;
}
