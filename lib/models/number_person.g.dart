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
      departureBundle: json['departureBundle'] == null
          ? null
          : InboundBundle.fromJson(
              json['departureBundle'] as Map<String, dynamic>),
      returnBundle: json['returnBundle'] == null
          ? null
          : InboundBundle.fromJson(
              json['returnBundle'] as Map<String, dynamic>),
      departureSeats: json['departureSeats'] == null
          ? null
          : Seats.fromJson(json['departureSeats'] as Map<String, dynamic>),
      returnSeats: json['returnSeats'] == null
          ? null
          : Seats.fromJson(json['returnSeats'] as Map<String, dynamic>),
      departureMeal: (json['departureMeal'] as List<dynamic>?)
              ?.map((e) => Bundle.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      returnMeal: (json['returnMeal'] as List<dynamic>?)
              ?.map((e) => Bundle.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      departureBaggage: json['departureBaggage'] == null
          ? null
          : Bundle.fromJson(json['departureBaggage'] as Map<String, dynamic>),
      returnBaggage: json['returnBaggage'] == null
          ? null
          : Bundle.fromJson(json['returnBaggage'] as Map<String, dynamic>),
      numberOrder: json['numberOrder'] as int?,
      passenger: json['passenger'] == null
          ? null
          : Passenger.fromJson(json['passenger'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'peopleType': _$PeopleTypeEnumMap[instance.peopleType],
      'departureBundle': instance.departureBundle,
      'returnBundle': instance.returnBundle,
      'departureMeal': instance.departureMeal,
      'returnMeal': instance.returnMeal,
      'departureSeats': instance.departureSeats,
      'returnSeats': instance.returnSeats,
      'departureBaggage': instance.departureBaggage,
      'returnBaggage': instance.returnBaggage,
      'numberOrder': instance.numberOrder,
      'passenger': instance.passenger,
    };

const _$PeopleTypeEnumMap = {
  PeopleType.adult: 'adult',
  PeopleType.child: 'child',
  PeopleType.infant: 'infant',
};
