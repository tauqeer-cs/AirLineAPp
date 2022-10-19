// ignore_for_file: constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@HiveType(typeId: 5)
@JsonSerializable(includeIfNull: false, explicitToJson: true)
class User extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String? userName;
  @HiveField(1)
  final String? email;
  @HiveField(2)
  final String? contactNo;
  @HiveField(3)
  final bool? authenticated;
  @HiveField(4)
  final String? token;
  @HiveField(5)
  final String? surName;
  @HiveField(6)
  final String? message;
  @HiveField(7)
  final String? address;
  @HiveField(8)
  final String? postcode;
  @HiveField(9)
  final String? countryCode;
  @HiveField(10)
  final String? avatarUrl;
  @HiveField(11)
  final String? location;
  @HiveField(12)
  final String? uuid;
  @HiveField(13)
  final double? currentBalance;
  @HiveField(14)
  final bool? isAccountVerified;
  @HiveField(15)
  final String? firstName;
  @HiveField(16)
  final DateTime? accountExpiryDate;

  User({
    this.userName,
    this.email,
    this.contactNo,
    this.authenticated,
    this.token,
    this.surName,
    this.message,
    this.address,
    this.postcode,
    this.countryCode,
    this.avatarUrl,
    this.uuid,
    this.location,
    this.currentBalance,
    this.isAccountVerified,
    this.firstName,
    this.accountExpiryDate,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [
    userName,
    email,
    contactNo,
    authenticated,
    token,
    surName,
    message,
    address,
    postcode,
    countryCode,
    avatarUrl,
    uuid,
    location,
    currentBalance,
    isAccountVerified,
    firstName,
    accountExpiryDate,
  ];

  /// Empty user which represents an unauthenticated user.
  static User empty = User(email: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;

  User copyWith({
    String? userName,
    String? email,
    String? contactNo,
    bool? authenticated,
    String? token,
    String? surName,
    String? message,
    String? address,
    String? postcode,
    String? countryCode,
    String? avatarUrl,
    String? location,
    String? uuid,
    double? currentBalance,
    bool? isAccountVerified,
    String? firstName,
    DateTime? accountExpiryDate,
  }) {
    return User(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      contactNo: contactNo ?? this.contactNo,
      authenticated: authenticated ?? this.authenticated,
      token: token ?? this.token,
      surName: surName ?? this.surName,
      message: message ?? this.message,
      address: address ?? this.address,
      postcode: postcode ?? this.postcode,
      countryCode: countryCode ?? this.countryCode,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      uuid: uuid ?? this.uuid,
      location: location ?? this.location,
      currentBalance: currentBalance ?? this.currentBalance,
      isAccountVerified: isAccountVerified ?? this.isAccountVerified,
      firstName: firstName ?? this.firstName,
      accountExpiryDate: accountExpiryDate ?? this.accountExpiryDate,
    );
  }
}

@HiveType(typeId: 1)
enum UserStatus {
  @HiveField(0)
  Inactive,
  @HiveField(1)
  Active,
  @HiveField(2)
  Suspend,
  @HiveField(3)
  Delete
}
