import 'package:app/data/requests/flight_summary_pnr_request.dart';
import 'package:app/models/home_content.dart';
import 'package:app/models/number_person.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'signup_request.g.dart';

@JsonSerializable()
class SignupRequest extends Equatable {
  const SignupRequest({
    this.title,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneCode,
    this.phoneNumber,
    this.password,
    this.gender,
    this.dob,
    this.address,
    this.country,
    this.state,
    this.city,
    this.postCode,
    this.referralCode,
    this.confirmPassword,
  });

  final String? title;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneCode;
  final String? phoneNumber;
  final String? password;
  final String? gender;
  final DateTime? dob;
  final String? address;
  final String? country;
  final String? state;
  final String? city;
  final String? postCode;
  final String? referralCode;
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

  @override
  // TODO: implement props
  List<Object?> get props => [
        this.title,
        this.firstName,
        this.lastName,
        this.email,
        this.phoneCode,
        this.phoneNumber,
        this.password,
        this.gender,
        this.dob,
        this.address,
        this.country,
        this.state,
        this.city,
        this.postCode,
        this.referralCode,
        this.confirmPassword,
      ];
}
