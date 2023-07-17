import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

@JsonSerializable()
class Countries extends Equatable {
  const Countries({
    this.countries,
  });

  final List<Country>? countries;

  Countries copyWith({
    List<Country>? countries,
  }) =>
      Countries(
        countries: countries ?? this.countries,
      );

  factory Countries.fromJson(Map<String, dynamic> json) =>
      _$CountriesFromJson(json);

  Map<String, dynamic> toJson() => _$CountriesToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [
        countries,
      ];
}

@JsonSerializable()
class Country extends Equatable {
  const Country({
    this.countryCode,
    //this.countryCode2,
    this.country,
    this.phoneCode,
    this.phoneCodeDisplay,
  });

  final String? countryCode;
  @JsonKey(name: 'countryCode_2')
  //final String? countryCode2;
  final String? country;
  final String? phoneCode;
  final String? phoneCodeDisplay;

  Country copyWith({
    String? countryCode,
    String? countryCode2,
    String? country,
    String? phoneCode,
    String? phoneCodeDisplay,
  }) =>
      Country(
        countryCode: countryCode ?? this.countryCode,
       // countryCode2: countryCode2 ?? this.countryCode2,
        country: country ?? this.country,
        phoneCode: phoneCode ?? this.phoneCode,
        phoneCodeDisplay: phoneCodeDisplay ?? this.phoneCodeDisplay,
      );

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [
        phoneCode,
      ];


  static const Country defaultCountry = Country(
    countryCode: "MYS",
    phoneCode: "60",
    phoneCodeDisplay: "+60",
    country: "Malaysia",
    //countryCode2: "MY",
  );
}

class StatesApiResponse {
  StateResult? result;
  bool? success;
  String? message;

  StatesApiResponse({this.result, this.success, this.message});

  StatesApiResponse.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? new StateResult.fromJson(json['result']) : null;
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}

class StateResult {
  List<States>? states;

  StateResult({this.states});

  StateResult.fromJson(Map<String, dynamic> json) {
    if (json['states'] != null) {
      states = <States>[];
      json['states'].forEach((v) {
        states!.add(new States.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.states != null) {
      data['states'] = this.states!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class States {
  String? stateName;
  List<String>? stateCities;

  States({this.stateName, this.stateCities});

  States.fromJson(Map<String, dynamic> json) {
    stateName = json['stateName'];
    stateCities = json['stateCities'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stateName'] = this.stateName;
    data['stateCities'] = this.stateCities;
    return data;
  }
}
