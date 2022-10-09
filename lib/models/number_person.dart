import 'package:app/data/requests/flight_summary_pnr_request.dart';
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
    if (isDeparture)
      return persons.map((e) => e.departureSeats).toList()
        ..removeWhere((element) => element == null);
    return persons.map((e) => e.returnSeats).toList()
      ..removeWhere((element) => element == null);
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

  num getTotalMealPartial(bool isDeparture) {
    num total = 0;
    for (var element in persons) {
      total = total + element.getPartialPriceMeal(isDeparture);
    }
    return total;
  }

  num getTotalBaggagePartial(bool isDeparture) {
    num total = 0;
    for (var element in persons) {
      total = total + element.getPartialPriceBaggage(isDeparture);
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
  final InboundBundle? returnBundle;
  final List<Bundle> departureMeal;
  final List<Bundle> returnMeal;
  final Seats? departureSeats;
  final Seats? returnSeats;
  final Bundle? departureBaggage;
  final Bundle? returnBaggage;
  final int? numberOrder;
  final Passenger? passenger;

  const Person({
    this.peopleType,
    this.departureBundle,
    this.returnBundle,
    this.departureSeats,
    this.returnSeats,
    this.departureMeal = const [],
    this.returnMeal = const [],
    this.departureBaggage,
    this.returnBaggage,
    this.numberOrder,
    this.passenger,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [this.peopleType, numberOrder];

  Map<num?, List<Bundle>> groupedMeal(bool isDeparture) {
    final meals = isDeparture ? departureMeal : returnMeal;
    var newMap = groupBy(meals, (meal) => meal.serviceID);
    return newMap;
  }

  Passenger toPassenger({
    required List<Rows> outboundRows,
    required List<Rows> inboundRows,
    num? inboundPhysicalId,
    num? outboundPhysicalId,
  }) {
    List<Bound> outboundSSR = [];
    List<Bound> inboundSSR = [];
    //bundle
    if (departureBundle?.toBound() != null) {
      outboundSSR.add(departureBundle!.toBound());
    }
    if (returnBundle?.toBound() != null) {
      inboundSSR.add(returnBundle!.toBound());
    }
    //meal
    final departureMeal = groupedMeal(true);
    final returnMeal = groupedMeal(false);

    departureMeal.forEach((key, value) {
      final firstValue = value.first;
      final outBoundMeal = Bound(
          quantity: value.length,
          serviceId: firstValue.serviceID,
          logicalFlightId: firstValue.logicalFlightID,
          price: firstValue.amount,
          servicesType: "MEAL",
          name: firstValue.description?.toLowerCase());
      outboundSSR.add(outBoundMeal);
    });
    returnMeal.forEach((key, value) {
      final firstValue = value.first;
      final inboundMeal = Bound(
          quantity: value.length,
          serviceId: firstValue.serviceID,
          logicalFlightId: firstValue.logicalFlightID,
          price: firstValue.amount,
          servicesType: "MEAL",
          name: firstValue.description?.toLowerCase());
      inboundSSR.add(inboundMeal);
    });
    //baggage
    if (departureBaggage?.toBound() != null) {
      outboundSSR.add(departureBaggage!.toBound());
    }
    if (returnBaggage?.toBound() != null) {
      inboundSSR.add(returnBaggage!.toBound());
    }
    final outboundSeat = departureSeats?.toOutbound(outboundRows);
    final inboundSeat = returnSeats?.toOutbound(inboundRows);
    final passenger = Passenger(
      paxType: peopleType?.code ?? "",
      ssr: Ssr(
        inbound: inboundSSR,
        outbound: outboundSSR,
      ),
      seat: Seat(
        outbound: outboundSeat?.copyWith(physicalFlightId: outboundPhysicalId) ?? Outbound(),
        inbound: inboundSeat?.copyWith(physicalFlightId: inboundPhysicalId) ?? Outbound(),
      ),
    );
    return passenger;
  }

  num getTotalPrice() {
    num totalPrice = 0;
    totalPrice = getTotalPriceBundle() +
        getTotalPriceSeat() +
        getTotalPriceMeal() +
        getTotalPriceBaggage();
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

  num getTotalPriceMeal() {
    num totalPrice = 0;
    totalPrice = getPartialPriceMeal(false) + getPartialPriceMeal(true);
    return totalPrice;
  }

  num getPartialPriceMeal(bool isDeparture) {
    num totalPrice = 0;
    if (isDeparture) {
      for (var element in departureMeal) {
        totalPrice = totalPrice + (element.amount ?? 0);
      }
    } else {
      for (var element in returnMeal) {
        totalPrice = totalPrice + (element.amount ?? 0);
      }
    }
    return totalPrice;
  }

  num getTotalPriceBaggage() {
    num totalPrice = 0;
    totalPrice = getPartialPriceBundle(false) + getPartialPriceBundle(true);
    return totalPrice;
  }

  num getPartialPriceBaggage(bool isDeparture) {
    num totalPrice = isDeparture
        ? (departureBaggage?.amount ?? 0)
        : (returnBaggage?.amount ?? 0);
    return totalPrice;
  }

  Person copyWith({
    PeopleType? peopleType,
    InboundBundle? Function()? departureBundle,
    InboundBundle? Function()? returnBundle,
    List<Bundle>? departureMeal,
    List<Bundle>? returnMeal,
    Seats? Function()? departureSeats,
    Seats? Function()? returnSeats,
    Bundle? Function()? departureBaggage,
    Bundle? Function()? returnBaggage,
    int? numberOrder,
  }) {
    return Person(
      peopleType: peopleType ?? this.peopleType,
      returnBundle: returnBundle != null ? returnBundle() : this.returnBundle,
      departureBundle:
          departureBundle != null ? departureBundle() : this.departureBundle,
      returnSeats: returnSeats != null ? returnSeats() : this.returnSeats,
      departureSeats:
          departureSeats != null ? departureSeats() : this.departureSeats,
      departureMeal: departureMeal ?? this.departureMeal,
      returnMeal: returnMeal ?? this.returnMeal,
      departureBaggage:
          departureBaggage != null ? departureBaggage() : this.departureBaggage,
      returnBaggage:
          returnBaggage != null ? returnBaggage() : this.returnBaggage,
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

enum PeopleType {
  adult("ADT"),
  child("CHD"),
  infant("INF");

  const PeopleType(this.code);

  final String code;
}
