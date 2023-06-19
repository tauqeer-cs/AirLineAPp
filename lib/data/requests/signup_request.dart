import 'package:app/utils/date_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'signup_request.g.dart';

@JsonSerializable()
class SignupRequest extends Equatable {
  const SignupRequest({
    this.title = "Mr.",
    this.firstName,
    this.lastName,
    this.email,
    this.phoneCode = "60",
    this.phoneNumber,
    this.password,
    this.gender = "male",
    this.dob,
    this.address,
    this.country = "MYS",
    this.state,
    this.city,
    this.postCode,
    this.referralCode,
    this.confirmPassword,
  });

  @JsonKey(name: "Title")
  final String? title;
  @JsonKey(name: "FirstName")
  final String? firstName;
  @JsonKey(name: "LastName")
  final String? lastName;
  @JsonKey(name: "Email")
  final String? email;
  @JsonKey(name: "PhoneCode")
  final String? phoneCode;
  @JsonKey(name: "PhoneNumber")
  final String? phoneNumber;
  @JsonKey(name: "Password")
  final String? password;
  @JsonKey(name: "Gender")
  final String? gender;
  @JsonKey(name: "DOB", toJson: AppDateUtils.toDateWithoutTimeToJson)
  final DateTime? dob;
  @JsonKey(name: "Address")
  final String? address;
  @JsonKey(name: "Country")
  final String? country;
  @JsonKey(name: "State")
  final String? state;
  @JsonKey(name: "City")
  final String? city;
  @JsonKey(name: "PostCode")
  final String? postCode;
  @JsonKey(name: "ReferralCode")
  final String? referralCode;
  @JsonKey(name: "ConfirmPassword")
  final String? confirmPassword;

  static const empty = SignupRequest();
  SignupRequest copyWith({
    String? title,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneCode,
    String? phoneNumber,
    String? password,
    String? gender,
    DateTime? dob,
    String? address,
    String? country,
    String? state,
    String? city,
    String? postCode,
    String? referralCode,
    String? confirmPassword,
  }) =>
      SignupRequest(
        title: title ?? this.title,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        phoneCode: phoneCode ?? this.phoneCode,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        password: password ?? this.password,
        gender: gender ?? this.gender,
        dob: dob ?? this.dob,
        address: address ?? this.address,
        country: country ?? this.country,
        state: state ?? this.state,
        city: city ?? this.city,
        postCode: postCode ?? this.postCode,
        referralCode: referralCode ?? this.referralCode,
        confirmPassword: confirmPassword ?? this.confirmPassword,
      );

  factory SignupRequest.fromJson(Map<String, dynamic> json) =>
      _$SignupRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignupRequestToJson(this);
  
  @override
  // TODO: implement props
  List<Object?> get props => [
        title,
        firstName,
        lastName,
        email,
        phoneCode,
        phoneNumber,
        password,
        gender,
        dob,
        address,
        country,
        state,
        city,
        postCode,
        referralCode,
        confirmPassword,
      ];
}
