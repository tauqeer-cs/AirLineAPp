// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_local_variable

part of 'airports_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AirportsResponseAdapter extends TypeAdapter<AirportsResponse> {
  @override
  final int typeId = 6;

  @override
  AirportsResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AirportsResponse();
  }

  @override
  void write(BinaryWriter writer, AirportsResponse obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AirportsResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AirportsResponse _$AirportsResponseFromJson(Map<String, dynamic> json) =>
    AirportsResponse(
      airports: (json['airports'] as List<dynamic>?)
          ?.map((e) => Airports.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AirportsResponseToJson(AirportsResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('airports', instance.airports);
  return val;
}
