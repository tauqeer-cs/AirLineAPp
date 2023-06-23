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
