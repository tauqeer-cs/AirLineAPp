// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'number_person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NumberPerson _$NumberPersonFromJson(Map<String, dynamic> json) => NumberPerson(
      persons: (json['persons'] as List<dynamic>?)
              ?.map((e) => Person.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$NumberPersonToJson(NumberPerson instance) =>
    <String, dynamic>{
      'persons': instance.persons,
    };

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      peopleType: $enumDecodeNullable(_$PeopleTypeEnumMap, json['peopleType']),
      bundle: json['bundle'] == null
          ? null
          : InboundBundle.fromJson(json['bundle'] as Map<String, dynamic>),
      meal: json['meal'] == null
          ? null
          : InboundBundle.fromJson(json['meal'] as Map<String, dynamic>),
      seats: json['seats'] == null
          ? null
          : Seats.fromJson(json['seats'] as Map<String, dynamic>),
      numberOrder: json['numberOrder'] as int?,
    );

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'peopleType': _$PeopleTypeEnumMap[instance.peopleType],
      'bundle': instance.bundle,
      'meal': instance.meal,
      'seats': instance.seats,
      'numberOrder': instance.numberOrder,
    };

const _$PeopleTypeEnumMap = {
  PeopleType.adult: 'adult',
  PeopleType.child: 'child',
  PeopleType.infant: 'infant',
};
