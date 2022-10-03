import 'package:app/data/responses/verify_response.dart';
import 'package:app/localizations/localizations_util.dart';
import 'package:app/utils/string_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'number_person.g.dart';

@JsonSerializable()
class NumberPerson extends Equatable {
  final List<Person> persons;

  const NumberPerson({
    this.persons = const [],
  });

  static const empty = NumberPerson(persons: const []);

  int get numberOfAdult =>
      persons.where((element) => element.peopleType == PeopleType.adult).length;

  int get numberOfChildren =>
      persons.where((element) => element.peopleType == PeopleType.child).length;

  int get numberOfInfant => persons
      .where((element) => element.peopleType == PeopleType.infant)
      .length;

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

  int get totalPerson => numberOfAdult + numberOfChildren;

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

  @override
  // TODO: implement props
  List<Object?> get props => [persons];
}

@JsonSerializable()
class Person extends Equatable {
  final PeopleType? peopleType;
  final InboundBundle? departureBundle;
  final InboundBundle? departureMeal;
  final Seats? departureSeats;
  final InboundBundle? returnBundle;
  final InboundBundle? returnMeal;
  final Seats? returnSeats;
  final int? numberOrder;

  const Person({
    this.peopleType,
    this.departureBundle,
    this.departureMeal,
    this.departureSeats,
    this.returnBundle,
    this.returnMeal,
    this.returnSeats,
    this.numberOrder,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [this.peopleType, numberOrder];

  Person copyWith({
    PeopleType? peopleType,
    InboundBundle? bundle,
    InboundBundle? meal,
    Seats? seats,
    int? numberOrder,
  }) {
    return Person(
      peopleType: peopleType ?? this.peopleType,
      bundle: bundle ?? this.bundle,
      meal: meal ?? this.meal,
      seats: seats ?? this.seats,
      numberOrder: numberOrder ?? this.numberOrder,
    );
  }

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);

  @override
  String toString() {
    return "${peopleType?.name.capitalize() ?? ""} $numberOrder";
  }
}

enum PeopleType { adult, child, infant }
