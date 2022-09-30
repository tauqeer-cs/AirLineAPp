// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'number_person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NumberPerson _$NumberPersonFromJson(Map<String, dynamic> json) => NumberPerson(
      numberOfInfant: json['numberOfInfant'] as int? ?? 0,
      numberOfAdult: json['numberOfAdult'] as int? ?? 0,
      numberOfChildren: json['numberOfChildren'] as int? ?? 0,
    );

Map<String, dynamic> _$NumberPersonToJson(NumberPerson instance) =>
    <String, dynamic>{
      'numberOfInfant': instance.numberOfInfant,
      'numberOfAdult': instance.numberOfAdult,
      'numberOfChildren': instance.numberOfChildren,
    };
