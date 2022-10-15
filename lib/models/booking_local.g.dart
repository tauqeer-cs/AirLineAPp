// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_local.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookingLocalAdapter extends TypeAdapter<BookingLocal> {
  @override
  final int typeId = 4;

  @override
  BookingLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookingLocal(
      bookingId: fields[0] as String?,
      departureDate: fields[1] as DateTime?,
      returnDate: fields[2] as DateTime?,
      departureString: fields[3] as String?,
      returnString: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BookingLocal obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.bookingId)
      ..writeByte(1)
      ..write(obj.departureDate)
      ..writeByte(2)
      ..write(obj.returnDate)
      ..writeByte(3)
      ..write(obj.departureString)
      ..writeByte(4)
      ..write(obj.returnString);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookingLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingLocal _$BookingLocalFromJson(Map<String, dynamic> json) => BookingLocal(
      bookingId: json['bookingId'] as String?,
      departureDate: json['departureDate'] == null
          ? null
          : DateTime.parse(json['departureDate'] as String),
      returnDate: json['returnDate'] == null
          ? null
          : DateTime.parse(json['returnDate'] as String),
      departureString: json['departureString'] as String?,
      returnString: json['returnString'] as String?,
    );

Map<String, dynamic> _$BookingLocalToJson(BookingLocal instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('bookingId', instance.bookingId);
  writeNotNull('departureDate', instance.departureDate?.toIso8601String());
  writeNotNull('returnDate', instance.returnDate?.toIso8601String());
  writeNotNull('departureString', instance.departureString);
  writeNotNull('returnString', instance.returnString);
  return val;
}
