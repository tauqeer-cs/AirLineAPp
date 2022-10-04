import 'package:app/data/responses/verify_response.dart';
import 'package:app/localizations/localizations_util.dart';
import 'package:app/utils/string_utils.dart';
import 'package:collection/collection.dart';
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

  List<Seats?> selectedSeats(bool isDeparture) {
    if (isDeparture) return persons.map((e) => e.departureSeats).toList()..removeWhere((element) => element==null);
    return persons.map((e) => e.returnSeats).toList()..removeWhere((element) => element==null);
  }

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

  num getTotal() {
    num total = 0;
    for (var element in persons) {
      total = total + element.getTotalPrice();
    }
    return total;
  }

  num getTotalBundlesPartial(bool isDeparture) {
    num total = 0;
    for (var element in persons) {
      total = total + element.getPartialPriceBundle(isDeparture);
    }
    return total;
  }

  num getTotalSeatsPartial(bool isDeparture) {
    num total = 0;
    for (var element in persons) {
      total = total + element.getPartialPriceSeatPartial(isDeparture);
    }
    return total;
  }

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
  final InboundBundle? returnBundle;
  final InboundBundle? returnMeal;
  final Seats? departureSeats;
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

  num getTotalPrice() {
    num totalPrice = 0;
    totalPrice = getTotalPriceBundle() + getTotalPriceSeat();
    return totalPrice;
  }

  num getTotalPriceBundle() {
    num totalPrice = 0;
    totalPrice = getPartialPriceBundle(false) + getPartialPriceBundle(true);
    return totalPrice;
  }

  num getPartialPriceBundle(bool isDeparture) {
    num totalPrice = isDeparture
        ? (departureBundle?.bundle?.amount ?? 0)
        : (returnBundle?.bundle?.amount ?? 0);
    return totalPrice;
  }

  num getTotalPriceSeat() {
    num totalPrice = 0;
    totalPrice =
        getPartialPriceSeatPartial(false) + getPartialPriceSeatPartial(true);
    return totalPrice;
  }

  num getPartialPriceSeatPartial(bool isDeparture) {
    num totalPrice = isDeparture
        ? (departureSeats?.seatPriceOffers?.firstOrNull?.amount ?? 0)
        : (returnSeats?.seatPriceOffers?.firstOrNull?.amount ?? 0);
    return totalPrice;
  }

  Person copyWith({
    PeopleType? peopleType,
    InboundBundle? Function()? departureBundle,
    InboundBundle? Function()? returnBundle,
    InboundBundle? departureMeal,
    InboundBundle? returnMeal,
    Seats? Function()? departureSeats,
    Seats? Function()? returnSeats,
    int? numberOrder,
  }) {
    return Person(
      peopleType: peopleType ?? this.peopleType,
      departureBundle:
          departureBundle != null ? departureBundle() : this.departureBundle,
      departureMeal: departureMeal ?? this.departureMeal,
      departureSeats:
          departureSeats != null ? departureSeats() : this.departureSeats,
      returnBundle: returnBundle != null ? returnBundle() : this.returnBundle,
      returnMeal: returnMeal ?? this.returnMeal,
      returnSeats: returnSeats != null ? returnSeats() : this.returnSeats,
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
