// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airports_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AirportsResponse _$AirportsResponseFromJson(Map<String, dynamic> json) =>
    AirportsResponse(
      airports: (json['airports'] as List<dynamic>?)
          ?.map((e) => Airports.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AirportsResponseToJson(AirportsResponse instance) =>
    <String, dynamic>{
      'airports': instance.airports,
    };
