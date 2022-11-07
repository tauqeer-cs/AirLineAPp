import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable(explicitToJson: true)
class Profile extends Equatable {
  int? userID;
  UserProfile? userProfile;
  CommunicationPreferences? communicationPreferences;

  Profile({this.userID, this.userProfile, this.communicationPreferences});

  @override
  List<Object?> get props => [userID, userProfile, communicationPreferences];

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
//userProfile

@JsonSerializable(explicitToJson: true)
class UserProfile extends Equatable {
  String? title;
  String? firstName;
  String? lastName;
  String? nationality;
  String? icNumber;
  DateTime? dob;
  String? phoneCode;
  String? phoneNumber;
  String? address;
  String? city;
  String? state;
  String? postCode;

  EmergencyContact? emergencyContact;

  String? country;
  int? memberID;
  String? referralCode;
  String? referralBy;

  UserProfile(
      {this.title,
      this.firstName,
      this.lastName,
      this.nationality,
      this.icNumber,
      this.dob,
      this.phoneCode,
      this.phoneNumber,
      this.address,
      this.city,
      this.state,
      this.postCode,
      this.country,
      this.memberID,
      this.referralCode,
      this.referralBy,
      this.emergencyContact});

  @override
  List<Object?> get props => [
        title,
        firstName,
        lastName,
        nationality,
        icNumber,
        dob,
        phoneCode,
        phoneNumber,
        address,
        city,
        state,
        postCode,
        country,
        memberID,
        referralCode,
        referralBy,
        emergencyContact
      ];

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}

/*
	"email": false,
		"webPushNotification": false,
		"sms": false,
		"whatsapp": false
* */
@JsonSerializable(explicitToJson: true)
class CommunicationPreferences extends Equatable {
  bool? email;
  bool? webPushNotification;
  bool? whatsapp;
  bool? sms;

  CommunicationPreferences(
      {this.email, this.webPushNotification, this.whatsapp, this.sms});

  @override
  List<Object?> get props => [email, webPushNotification, whatsapp, sms];

  factory CommunicationPreferences.fromJson(Map<String, dynamic> json) =>
      _$CommunicationPreferencesFromJson(json);

  Map<String, dynamic> toJson() => _$CommunicationPreferencesToJson(this);
}

//communicationPreferences
/*
"firstName": "",
			"lastName": "",
			"relationship": "",
			"phoneCode": "",
			"phoneNumber": ""

* */
@JsonSerializable(explicitToJson: true)
class EmergencyContact extends Equatable {
  String? firstName;
  String? lastName;
  String? relationship;
  String? phoneCode;
  String? phoneNumber;

  EmergencyContact(
      {this.firstName,
      this.lastName,
      this.relationship,
      this.phoneCode,
      this.phoneNumber});

  @override
  List<Object?> get props =>
      [firstName, lastName, relationship, phoneCode, phoneNumber];

  factory EmergencyContact.fromJson(Map<String, dynamic> json) =>
      _$EmergencyContactFromJson(json);

  Map<String, dynamic> toJson() => _$EmergencyContactToJson(this);
}
