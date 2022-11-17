// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airports.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AirportsAdapter extends TypeAdapter<Airports> {
  @override
  final int typeId = 7;

  @override
  Airports read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Airports();
  }

  @override
  void write(BinaryWriter writer, Airports obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AirportsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
