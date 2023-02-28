import 'package:app/models/number_person.dart';
import 'package:app/utils/date_utils.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_insider/enum/InsiderGender.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Profile extends Equatable {
  final int? userID;
  final UserProfile? userProfile;
  final CommunicationPreferences? communicationPreferences;

  const Profile({this.userID, this.userProfile, this.communicationPreferences});

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
  final int? memberPoint;


  String? get emailShow {
    if (email == null) {
      return null;
    }
    return email!.trim();
  }

  final EmergencyContact? emergencyContact;
  final String? country;
  final int? memberID;
  final String? referralCode;
  final String? referralBy;
  final List<FriendsFamily>? friendsAndFamily;
  final List<MemberCard>? memberCards;

  UserProfile copyWith({
    String? title,
    String? firstName,
    String? lastName,
    String? nationality,
    String? icNumber,
    DateTime? dob,
    String? phoneCode,
    String? phoneNumber,
    String? address,
    String? city,
    String? state,
    String? postCode,
    String? email,
    EmergencyContact? emergencyContact,
    String? country,
    int? memberID,
    String? referralCode,
    String? referralBy,
    List<FriendsFamily>? friendsAndFamily,
    List<MemberCard>? memberCards,
    int? memberPoint,
  }) {
    return UserProfile(
      title: title ?? this.title,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      nationality: nationality ?? this.nationality,
      icNumber: icNumber ?? this.icNumber,
      dob: dob ?? this.dob,
      phoneCode: phoneCode ?? this.phoneCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      postCode: postCode ?? this.postCode,
      email: email ?? this.email,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      country: country ?? this.country,
      memberID: memberID ?? this.memberID,
      referralCode: email ?? this.referralCode,
      referralBy: referralBy ?? this.referralBy,
      friendsAndFamily: friendsAndFamily ?? this.friendsAndFamily,
      memberCards: memberCards ?? this.memberCards,
      memberPoint: memberPoint ?? this.memberPoint,

    );
  }

  const UserProfile({
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
    this.friendsAndFamily,
    this.memberCards,
    this.memberPoint
  });

  @override
  List<Object?> get props =>
      [
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
        friendsAndFamily,
        memberCards,
        memberPoint
      ];

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);

  int insiderGender(){
    if(["Mrs.", "Ms."].contains(title)) return InsiderGender.FEMALE;
    if(["Mr.", "Tun."].contains(title)) return InsiderGender.MALE;
    return InsiderGender.OTHER;
  }

  int userAge() {
    if (dob == null) return 0;
    final today = DateTime.now();
    final year = today.year - dob!.year;
    final mth = today.month - dob!.month;
    final days = today.day - dob!.day;
    if (mth < 0) {
      return year - 1;
    }
    else {
      return year;
    }
  }
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
    if (title == null) {
      return 'Mr.';
    } else if (title == 'Tan S') {
      return 'Tan Sri';
    }

    return title!;
  }

  DateTime? get dobDate {
    if (dob == null) {
      return null;
    }
    return DateTime.parse(dob!);
  }

  String get fullName {
    String name = firstName ?? '';
    if (name.isNotEmpty) {
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
  List<Object?> get props =>
      [
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

@JsonSerializable(explicitToJson: true)
class MemberCard extends Equatable {
  /*
   "": "2501",
        "": "",
        "": "JENNY",
        "": "8829022000788477505",
        "": "VSA",
        "": "Jenny"
   visa.png


trash.png

"expiryDate": "2501",

			"cardHolderName": "Sdfff",
			"token": "8801223000836177736",
			"cardType": "MST",
			"cardNickName": ""


			  {
        "expiryDate": "2501",
        "countryCode": "",
        "cardHolderName": "JENNY",
        "token": "8829022000788477505",
        "cardType": "VSA",
        "cardNickName": "Jenny"
      },
   */

  bool get hasCardExpired {
    if (expiryDate != null) {
      String yearPart = expiryDate!.substring(0, 2);
      int year = int.parse(yearPart) + 2000;

      if (year > DateTime
          .now()
          .year) {
        return false;
      } else if (year < DateTime
          .now()
          .year) {
        return true;
      }

      String monthPart = expiryDate!.substring(2, 4);
      int month = int.parse(monthPart) + 2000;

      if (month > DateTime
          .now()
          .month) {
        return false;
      }

      return true;
    }
    return false;
  }

  String get cardImageName {
    if (cardType == 'VSA') {
      return 'visa';
    } else if (cardType == 'UNP' || cardType == 'UP') {
      return 'unionpay_logo';
    }

    return 'mc';
  }

  final String? expiryDate;
  final String? countryCode;
  final String? cardHolderName;
  final String? token;
  final String? cardType;
  final String? cardNickName;

  String get cardDisplay {
    if (cardNickName != null && cardNickName!.isNotEmpty) {
      return cardNickName!;
    } else if (cardHolderName != null && cardHolderName!.isNotEmpty) {
      return cardHolderName!;
    }

    return '';
  }

  const MemberCard({
    this.expiryDate,
    this.countryCode,
    this.cardHolderName,
    this.token,
    this.cardType,
    this.cardNickName,
  });

  @override
  List<Object?> get props =>
      [
        expiryDate,
        countryCode,
        cardHolderName,
        token,
        cardType,
        cardNickName,
      ];

  factory MemberCard.fromJson(Map<String, dynamic> json) =>
      _$MemberCardFromJson(json);

  Map<String, dynamic> toJson() => _$MemberCardToJson(this);
}

//"friendsAndFamilyID": 55,
//"title": "Mr.",
//"firstName": "gffh",
//"lastName": "fgfg",
//"dob": "1998-01-05T02:10:33",
//"nationality": "Malaysia",
//"memberID": 0
