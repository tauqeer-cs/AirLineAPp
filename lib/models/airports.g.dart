// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airports.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Airports _$AirportsFromJson(Map<String, dynamic> json) => Airports(
      connections: (json['connections'] as List<dynamic>?)
          ?.map((e) => Airports.fromJson(e as Map<String, dynamic>))
          .toList(),
      code: json['code'] as String?,
      name: json['name'] as String?,
      contryCode: json['contryCode'] as String?,
      currency: json['currency'] as String?,
    );

Map<String, dynamic> _$AirportsToJson(Airports instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connections', instance.connections);
  writeNotNull('code', instance.code);
  writeNotNull('name', instance.name);
  writeNotNull('contryCode', instance.contryCode);
  writeNotNull('currency', instance.currency);
  return val;
}
