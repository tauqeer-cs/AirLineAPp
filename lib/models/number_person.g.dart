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
      departureWheelChair: json['departureWheelChair'] == null
          ? null
          : Bundle.fromJson(
              json['departureWheelChair'] as Map<String, dynamic>),
      returnWheelChair: json['returnWheelChair'] == null
          ? null
          : Bundle.fromJson(json['returnWheelChair'] as Map<String, dynamic>),
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
      departureInsurance: json['departureInsurance'] == null
          ? null
          : Bundle.fromJson(json['departureInsurance'] as Map<String, dynamic>),
      departureOkId: json['departureOkId'] as String?,
      returnOkId: json['returnOkId'] as String?,
      returnInsurance: json['returnInsurance'] == null
          ? null
          : Bundle.fromJson(json['returnInsurance'] as Map<String, dynamic>),
      useWheelChair: json['useWheelChair'] as bool?,
      departureSports: json['departureSports'] == null
          ? null
          : Bundle.fromJson(json['departureSports'] as Map<String, dynamic>),
      returnSports: json['returnSports'] == null
          ? null
          : Bundle.fromJson(json['returnSports'] as Map<String, dynamic>),
      insuranceGroup: json['insuranceGroup'] == null
          ? null
          : Bundle.fromJson(json['insuranceGroup'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PersonToJson(Person instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('peopleType', _$PeopleTypeEnumMap[instance.peopleType]);
  writeNotNull('departureBundle', instance.departureBundle);
  writeNotNull('returnBundle', instance.returnBundle);
  val['departureMeal'] = instance.departureMeal;
  val['returnMeal'] = instance.returnMeal;
  writeNotNull('departureSeats', instance.departureSeats);
  writeNotNull('returnSeats', instance.returnSeats);
  writeNotNull('departureBaggage', instance.departureBaggage);
  writeNotNull('returnBaggage', instance.returnBaggage);
  writeNotNull('departureSports', instance.departureSports);
  writeNotNull('returnSports', instance.returnSports);
  writeNotNull('departureWheelChair', instance.departureWheelChair);
  writeNotNull('returnWheelChair', instance.returnWheelChair);
  writeNotNull('departureOkId', instance.departureOkId);
  writeNotNull('returnOkId', instance.returnOkId);
  writeNotNull('departureInsurance', instance.departureInsurance);
  writeNotNull('returnInsurance', instance.returnInsurance);
  writeNotNull('insuranceGroup', instance.insuranceGroup);
  writeNotNull('useWheelChair', instance.useWheelChair);
  writeNotNull('numberOrder', instance.numberOrder);
  writeNotNull('passenger', instance.passenger);
  return val;
}

const _$PeopleTypeEnumMap = {
  PeopleType.adult: 'adult',
  PeopleType.child: 'child',
  PeopleType.infant: 'infant',
};
