import 'package:app/utils/date_utils.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Profile extends Equatable {
  final int? userID;
  final UserProfile? userProfile;
  final CommunicationPreferences? communicationPreferences;


  const Profile(
      {this.userID,
      this.userProfile,
      this.communicationPreferences});

  @override
  List<Object?> get props => [userID, userProfile, communicationPreferences];

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
//userProfile

@JsonSerializable(explicitToJson: true)
class UserProfile extends Equatable {
  final String? title;
  final String? firstName;
  final String? lastName;
  final String? nationality;
  final String? icNumber;
  @JsonKey(toJson: AppDateUtils.toDateWithoutTimeToJson)
  final DateTime? dob;
  final String? phoneCode;
  final String? phoneNumber;
  final String? address;
  final String? city;
  final String? state;
  final String? postCode;
  final String? email;
  final EmergencyContact? emergencyContact;
  final String? country;
  final int? memberID;
  final String? referralCode;
  final String? referralBy;
  final List<FriendsFamily>? friendsAndFamily;

  const UserProfile( {
    this.title,
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
    this.email,
    this.emergencyContact,
    this.friendsAndFamily
  });

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
        emergencyContact,
        email,
    friendsAndFamily
      ];

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}

@JsonSerializable(explicitToJson: true)
@CopyWith(copyWithNull: true)
class CommunicationPreferences extends Equatable {
  final bool? email;
  final bool? webPushNotification;
  final bool? whatsapp;
  final bool? sms;

  const CommunicationPreferences({
    this.email,
    this.webPushNotification,
    this.whatsapp,
    this.sms,
  });

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
  final String? firstName;
  final String? lastName;
  final String? relationship;
  final String? phoneCode;
  final String? phoneNumber;
  final String? email;

  const EmergencyContact({
    this.firstName,
    this.lastName,
    this.relationship,
    this.phoneCode,
    this.phoneNumber,
    this.email,
  });

  @override
  List<Object?> get props =>
      [firstName, lastName, relationship, phoneCode, phoneNumber];

  factory EmergencyContact.fromJson(Map<String, dynamic> json) =>
      _$EmergencyContactFromJson(json);

  Map<String, dynamic> toJson() => _$EmergencyContactToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FriendsFamily extends Equatable {
  final int? friendsAndFamilyID;
  final String? title;
  final String? firstName;
  final String? lastName;
  final String? dob;
  final String? nationality;
  final int? memberID;

  String get titleToShow {
    if(title == null) {
      return 'Mr.';
    }
    else if(title == 'Tan S') {
      return 'Tan Sri';
    }

    return title!;

  }
  DateTime? get dobDate {
    if(dob == null) {
      return null;
    }
    return DateTime.parse(dob!);
  }
  String get fullName {

    String name = firstName ?? '';
    if(name.isNotEmpty) {
      name = '$name ';
    }
    name = name + (lastName ?? '');

    return name;

  }
  const FriendsFamily({
    this.friendsAndFamilyID,
    this.firstName,
    this.lastName,
    this.title,
    this.dob,
    this.nationality,
    this.memberID,
  });

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        friendsAndFamilyID,
        title,
        dob,
        nationality,
        memberID
      ];

  factory FriendsFamily.fromJson(Map<String, dynamic> json) =>
      _$FriendsFamilyFromJson(json);

  Map<String, dynamic> toJson() => _$FriendsFamilyToJson(this);
}

//"friendsAndFamilyID": 55,
//"title": "Mr.",
//"firstName": "gffh",
//"lastName": "fgfg",
//"dob": "1998-01-05T02:10:33",
//"nationality": "Malaysia",
//"memberID": 0
