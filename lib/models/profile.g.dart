// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CommunicationPreferencesCWProxy {
  CommunicationPreferences email(bool? email);

  CommunicationPreferences sms(bool? sms);

  CommunicationPreferences webPushNotification(bool? webPushNotification);

  CommunicationPreferences whatsapp(bool? whatsapp);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CommunicationPreferences(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CommunicationPreferences(...).copyWith(id: 12, name: "My name")
  /// ````
  CommunicationPreferences call({
    bool? email,
    bool? sms,
    bool? webPushNotification,
    bool? whatsapp,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCommunicationPreferences.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCommunicationPreferences.copyWith.fieldName(...)`
class _$CommunicationPreferencesCWProxyImpl
    implements _$CommunicationPreferencesCWProxy {
  final CommunicationPreferences _value;

  const _$CommunicationPreferencesCWProxyImpl(this._value);

  @override
  CommunicationPreferences email(bool? email) => this(email: email);

  @override
  CommunicationPreferences sms(bool? sms) => this(sms: sms);

  @override
  CommunicationPreferences webPushNotification(bool? webPushNotification) =>
      this(webPushNotification: webPushNotification);

  @override
  CommunicationPreferences whatsapp(bool? whatsapp) => this(whatsapp: whatsapp);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CommunicationPreferences(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CommunicationPreferences(...).copyWith(id: 12, name: "My name")
  /// ````
  CommunicationPreferences call({
    Object? email = const $CopyWithPlaceholder(),
    Object? sms = const $CopyWithPlaceholder(),
    Object? webPushNotification = const $CopyWithPlaceholder(),
    Object? whatsapp = const $CopyWithPlaceholder(),
  }) {
    return CommunicationPreferences(
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as bool?,
      sms: sms == const $CopyWithPlaceholder()
          ? _value.sms
          // ignore: cast_nullable_to_non_nullable
          : sms as bool?,
      webPushNotification: webPushNotification == const $CopyWithPlaceholder()
          ? _value.webPushNotification
          // ignore: cast_nullable_to_non_nullable
          : webPushNotification as bool?,
      whatsapp: whatsapp == const $CopyWithPlaceholder()
          ? _value.whatsapp
          // ignore: cast_nullable_to_non_nullable
          : whatsapp as bool?,
    );
  }
}

extension $CommunicationPreferencesCopyWith on CommunicationPreferences {
  /// Returns a callable class that can be used as follows: `instanceOfCommunicationPreferences.copyWith(...)` or like so:`instanceOfCommunicationPreferences.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CommunicationPreferencesCWProxy get copyWith =>
      _$CommunicationPreferencesCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `CommunicationPreferences(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CommunicationPreferences(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  CommunicationPreferences copyWithNull({
    bool email = false,
    bool sms = false,
    bool webPushNotification = false,
    bool whatsapp = false,
  }) {
    return CommunicationPreferences(
      email: email == true ? null : this.email,
      sms: sms == true ? null : this.sms,
      webPushNotification:
          webPushNotification == true ? null : this.webPushNotification,
      whatsapp: whatsapp == true ? null : this.whatsapp,
    );
  }
}

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
      friendsAndFamily: (json['friendsAndFamily'] as List<dynamic>?)
          ?.map((e) => FriendsFamily.fromJson(e as Map<String, dynamic>))
          .toList(),
      memberCards: (json['memberCards'] as List<dynamic>?)
          ?.map((e) => MemberCard.fromJson(e as Map<String, dynamic>))
          .toList(),
      memberPoint: json['memberPoint'] as int?,
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
  writeNotNull('dob', AppDateUtils.toDateWithoutTimeToJson(instance.dob));
  writeNotNull('phoneCode', instance.phoneCode);
  writeNotNull('phoneNumber', instance.phoneNumber);
  writeNotNull('address', instance.address);
  writeNotNull('city', instance.city);
  writeNotNull('state', instance.state);
  writeNotNull('postCode', instance.postCode);
  writeNotNull('email', instance.email);
  writeNotNull('memberPoint', instance.memberPoint);
  writeNotNull('emergencyContact', instance.emergencyContact?.toJson());
  writeNotNull('country', instance.country);
  writeNotNull('memberID', instance.memberID);
  writeNotNull('referralCode', instance.referralCode);
  writeNotNull('referralBy', instance.referralBy);
  writeNotNull('friendsAndFamily',
      instance.friendsAndFamily?.map((e) => e.toJson()).toList());
  writeNotNull(
      'memberCards', instance.memberCards?.map((e) => e.toJson()).toList());
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
      email: json['email'] as String?,
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
  writeNotNull('email', instance.email);
  return val;
}

FriendsFamily _$FriendsFamilyFromJson(Map<String, dynamic> json) =>
    FriendsFamily(
      friendsAndFamilyID: json['friendsAndFamilyID'] as int?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      title: json['title'] as String?,
      dob: json['dob'] as String?,
      nationality: json['nationality'] as String?,
      memberID: json['memberID'] as int?,
    );

Map<String, dynamic> _$FriendsFamilyToJson(FriendsFamily instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('friendsAndFamilyID', instance.friendsAndFamilyID);
  writeNotNull('title', instance.title);
  writeNotNull('firstName', instance.firstName);
  writeNotNull('lastName', instance.lastName);
  writeNotNull('dob', instance.dob);
  writeNotNull('nationality', instance.nationality);
  writeNotNull('memberID', instance.memberID);
  return val;
}

MemberCard _$MemberCardFromJson(Map<String, dynamic> json) => MemberCard(
      expiryDate: json['expiryDate'] as String?,
      countryCode: json['countryCode'] as String?,
      cardHolderName: json['cardHolderName'] as String?,
      token: json['token'] as String?,
      cardType: json['cardType'] as String?,
      cardNickName: json['cardNickName'] as String?,
    );

Map<String, dynamic> _$MemberCardToJson(MemberCard instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('expiryDate', instance.expiryDate);
  writeNotNull('countryCode', instance.countryCode);
  writeNotNull('cardHolderName', instance.cardHolderName);
  writeNotNull('token', instance.token);
  writeNotNull('cardType', instance.cardType);
  writeNotNull('cardNickName', instance.cardNickName);
  return val;
}
