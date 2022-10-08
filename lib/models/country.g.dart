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

Map<String, dynamic> _$CountriesToJson(Countries instance) => <String, dynamic>{
      'countries': instance.countries,
    };

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      countryCode: json['countryCode'] as String?,
      countryCode2: json['countryCode2'] as String?,
      country: json['country'] as String?,
      phoneCode: json['phoneCode'] as String?,
      phoneCodeDisplay: json['phoneCodeDisplay'] as String?,
    );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'countryCode': instance.countryCode,
      'countryCode2': instance.countryCode2,
      'country': instance.country,
      'phoneCode': instance.phoneCode,
      'phoneCodeDisplay': instance.phoneCodeDisplay,
    };
