// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Countries _$CountriesFromJson(Map<String, dynamic> json) => Countries(
      countries: (json['countries'] as List<dynamic>?)
          ?.map((e) => Country.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CountriesToJson(Countries instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('countries', instance.countries);
  return val;
}

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      countryCode: json['countryCode'] as String?,
      countryCode2: json['countryCode_2'] as String?,
      country: json['country'] as String?,
      phoneCode: json['phoneCode'] as String?,
      phoneCodeDisplay: json['phoneCodeDisplay'] as String?,
    );

Map<String, dynamic> _$CountryToJson(Country instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('countryCode', instance.countryCode);
  writeNotNull('countryCode_2', instance.countryCode2);
  writeNotNull('country', instance.country);
  writeNotNull('phoneCode', instance.phoneCode);
  writeNotNull('phoneCodeDisplay', instance.phoneCodeDisplay);
  return val;
}
