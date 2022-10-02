import 'package:app/localizations/localizations_util.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'number_person.g.dart';

@JsonSerializable()
class NumberPerson extends Equatable {
  final int numberOfInfant;
  final int numberOfAdult;
  final int numberOfChildren;

  const NumberPerson({
    this.numberOfInfant = 0,
    this.numberOfAdult = 0,
    this.numberOfChildren = 0,
  });

  @override
  String toString() {
    List<String> texts = [];
    if (numberOfAdult > 0) {
      final text = "$numberOfAdult ${numberOfAdult > 1 ? 'Adults' : 'Adult'}";
      texts.add(text);
    }
    if (numberOfChildren > 0) {
      final text =
          "$numberOfChildren ${numberOfChildren > 1 ? 'Children' : 'Child'}";
      texts.add(text);
    }
    if (numberOfInfant > 0) {
      final text =
          "$numberOfInfant ${numberOfInfant > 1 ? 'Infants' : 'Infant'}";
      texts.add(text);
    }
    return texts.join(", ");
  }

  int get totalPerson => numberOfAdult+numberOfChildren;
  String toBeautify() {
    List<String> texts = [];
    if (numberOfAdult > 0) {
      final text = "($numberOfAdult) ${numberOfAdult > 1 ? 'Adults' : 'Adult'}";
      texts.add(text);
    }
    if (numberOfChildren > 0) {
      final text =
          "($numberOfChildren) ${numberOfChildren > 1 ? 'Children' : 'Child'}";
      texts.add(text);
    }
    if (numberOfInfant > 0) {
      final text =
          "($numberOfInfant) ${numberOfInfant > 1 ? 'Infants' : 'Infant'}";
      texts.add(text);
    }
    final combine = texts.join(", ");
    return "$combine passenger(s)";
  }

  factory NumberPerson.fromJson(Map<String, dynamic> json) =>
      _$NumberPersonFromJson(json);

  Map<String, dynamic> toJson() => _$NumberPersonToJson(this);

  static const empty =
      NumberPerson(numberOfAdult: 0, numberOfChildren: 0, numberOfInfant: 0);

  @override
  // TODO: implement props
  List<Object?> get props => [
        numberOfInfant,
        numberOfAdult,
        numberOfChildren,
      ];

  NumberPerson copyWith({
    int? numberOfInfant,
    int? numberOfAdult,
    int? numberOfChildren,
  }) {
    return NumberPerson(
      numberOfInfant: numberOfInfant ?? this.numberOfInfant,
      numberOfAdult: numberOfAdult ?? this.numberOfAdult,
      numberOfChildren: numberOfChildren ?? this.numberOfChildren,
    );
  }
}

enum PeopleType { adults, children, infants }
