import 'dart:collection';

import 'package:app/data/requests/flight_summary_pnr_request.dart';
import 'package:app/data/responses/verify_response.dart';
import 'package:app/utils/string_utils.dart';
import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'number_person.g.dart';

@JsonSerializable()
class NumberPerson extends Equatable {
  final List<Person> persons;

  const NumberPerson({
    this.persons = const [],
  });

  static const empty = NumberPerson(persons: []);

  static const adult = NumberPerson(persons: [Person.adult]);

  bool get hasAdult {
    var person = persons.where((e) => e.peopleType == PeopleType.adult)
        .toList();

    if (person.isNotEmpty) {
      return true;
    }

    return false;
  }

  bool get hasOneAdult {
    var person = persons.where((e) => e.peopleType == PeopleType.adult)
        .toList();
    if (person.isNotEmpty) {
      if (person.length == 1) {
        return true;
      }
      return false;
    }
    return false;
  }

  List<Seats?> selectedSeats(bool isDeparture) {
    if (isDeparture) {
      return persons.map((e) => e.departureSeats).toList()
        ..removeWhere((element) => element == null);
    }
    return persons.map((e) => e.returnSeats).toList()
      ..removeWhere((element) => element == null);
  }

  Person? getPersonBySeat(Seats seat, bool isDeparture) {
    if (isDeparture) {
      var returnValue = persons
          .firstWhereOrNull((element) => element.departureSeats == seat);
      return returnValue;
    }
    return persons.firstWhereOrNull((element) => element.returnSeats == seat);
  }

  int getPersonIndexBySeat(Seats seat, bool isDeparture) {
    final person = getPersonBySeat(seat, isDeparture);
    if (person == null) return 0 + 1;
    return persons.indexOf(person) + 1;
  }

  int getPersonIndex(Person? person) {
    if (person == null) return 0 + 1;
    return persons.indexOf(person) + 1;
  }

  int get numberOfAdult =>
      persons
          .where((element) => element.peopleType == PeopleType.adult)
          .length;

  int get numberOfChildren =>
      persons
          .where((element) => element.peopleType == PeopleType.child)
          .length;

  int get numberOfInfant =>
      persons
          .where((element) => element.peopleType == PeopleType.infant)
          .length;

  @override
  String toString() {
    List<String> texts = [];
    if (numberOfAdult > 0) {
      final text =
          "$numberOfAdult ${numberOfAdult > 1
          ? 'customerSelect.adults'.tr()
          : 'adult'.tr()}";
      texts.add(text);
    }
    if (numberOfChildren > 0) {
      final text =
          "$numberOfChildren ${numberOfChildren > 1 ? 'customerSelect.children'
          .tr() : 'child'.tr()}";
      texts.add(text);
    }
    if (numberOfInfant > 0) {
      final text =
          "$numberOfInfant ${numberOfInfant > 1 ? 'infants'.tr() : 'infant'
          .tr()}";
      texts.add(text);
    }
    return texts.join(", ");
  }

  int get totalPerson => numberOfAdult + numberOfChildren;

  int get totalPersonWithInfant =>
      numberOfAdult + numberOfChildren + numberOfInfant;

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

  num getTotalInsurance() {
    num total = 0;
    for (var element in persons) {
      total = total + element.getInsurancePrice();
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

  num getTotalWheelChairPartial(bool isDeparture) {
    num total = 0;
    for (var element in persons) {
      total = total + element.getPartialWheelChair(isDeparture);
    }
    return total;
  }

  num? getTotalSportsPartial(bool isDeparture) {
    num total = 0;
    for (var element in persons) {
      //here
      total = total + element.getPartialPriceSports(isDeparture);
    }
    if (total == 0.0) {
      return null;
    }
    return total;
  }

  String toBeautify() {
    List<String> texts = [];
    if (numberOfAdult > 0) {
      final text =
          "($numberOfAdult) ${numberOfAdult > 1 ? 'Adults' : 'adult'.tr()}";
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

@CopyWith(copyWithNull: true)
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
  final Bundle? departureSports;
  final Bundle? returnSports;
  final Bundle? departureWheelChair;
  final Bundle? returnWheelChair;
  final String? departureOkId;
  final String? returnOkId;
  final Bundle? departureInsurance;
  final Bundle? returnInsurance;
  final Bundle? insuranceGroup;
  final bool? useWheelChair;
  final int? numberOrder;
  final Passenger? passenger;


  const Person({
    this.peopleType,
    this.departureBundle,
    this.returnBundle,
    this.departureSeats,
    this.returnSeats,
    this.departureWheelChair,
    this.returnWheelChair,
    this.departureMeal = const [],
    this.returnMeal = const [],
    this.departureBaggage,
    this.returnBaggage,
    this.numberOrder,
    this.passenger,
    this.departureInsurance,
    this.departureOkId,
    this.returnOkId,
    this.returnInsurance,
    this.useWheelChair,
    this.departureSports,
    this.returnSports,
    this.insuranceGroup,
  });

  static const adult = Person(
    peopleType: PeopleType.adult,
    numberOrder: 1,
  );

  @override
  // TODO: implement props
  List<Object?> get props => [peopleType, numberOrder];

  Map<String?, List<Bundle>> groupedMeal(bool isDeparture) {
    final meals = isDeparture ? departureMeal : returnMeal;
    var newMap = groupBy(meals, (meal) => meal.ssrCode);
    return newMap;
  }

  Map<String?, List<Bundle>> groupedMealOld(bool isDeparture) {
    var meals = isDeparture ? departureMeal : returnMeal;
    meals = meals.where((e) => e.isOld == true).toList();
    var newMap = groupBy(meals, (meal) => meal.ssrCode);

    return newMap;
  }

  Map<String?, List<Bundle>> groupedMealNew(bool isDeparture) {
    var meals = isDeparture ? departureMeal : returnMeal;
    meals = meals.where((e) => e.isOld == false).toList();
    var newMap = groupBy(meals, (meal) => meal.ssrCode);
    return newMap;
  }

  Passenger toPassenger({
    required List<Rows> outboundRows,
    required List<Rows> inboundRows,
    String? inboundPhysicalId,
    String? outboundPhysicalId,
    NumberPerson? numberPerson,
    BundleGroupSeat? infantGroup,
    required String lfIdDeparture,
    required String lfIdReturn,

  }) {
    List<Bound> outboundSSR = [];
    List<Bound> inboundSSR = [];
    //bundle
    final infantIndex = peopleType == PeopleType.adult &&
        ((numberPerson?.numberOfInfant ?? 0) >= (numberOrder ?? 0))
        ? 1
        : 0;
    //infant
    if (infantIndex == 1) {
      final outBoundInfant = infantGroup?.outbound?.firstOrNull;
      final inBoundInfant = infantGroup?.inbound?.firstOrNull;
      outboundSSR.add(Bound(
        servicesType: "Infant",
        logicalFlightId: outBoundInfant?.logicalFlightID,
        quantity: 1,
        ssrCode: outBoundInfant?.ssrCode,
      ));
      inboundSSR.add(Bound(
        servicesType: "Infant",
        logicalFlightId: inBoundInfant?.logicalFlightID,
        quantity: 1,
        ssrCode: inBoundInfant?.ssrCode,
      ));
    }
    if (departureBundle?.toBound() != null) {
      outboundSSR.add(departureBundle!.toBound());
    }
    if (returnBundle?.toBound() != null) {
      inboundSSR.add(returnBundle!.toBound());
    }

    final departureMeal = groupedMeal(true);
    final returnMeal = groupedMeal(false);

    departureMeal.forEach((key, value) {
      final firstValue = value.firstOrNull;
      final outBoundMeal = Bound(
          quantity: value.length,
          ssrCode: firstValue?.ssrCode,
          logicalFlightId: firstValue?.logicalFlightID,
          price: firstValue?.finalAmount,
          servicesType: "MEAL",
          name: firstValue?.description?.toLowerCase());
      outboundSSR.add(outBoundMeal);
    });
    returnMeal.forEach((key, value) {
      final firstValue = value.firstOrNull;
      final inboundMeal = Bound(
          quantity: value.length,
          ssrCode: firstValue?.ssrCode,
          logicalFlightId: firstValue?.logicalFlightID,
          price: firstValue?.finalAmount,
          servicesType: "MEAL",
          name: firstValue?.description?.toLowerCase());
      inboundSSR.add(inboundMeal);
    });
    //baggage
    if (departureBaggage?.toBound() != null) {
      outboundSSR.add(departureBaggage!.toBound());
    }
    if (returnBaggage?.toBound() != null) {
      inboundSSR.add(returnBaggage!.toBound());
    }

    if (departureWheelChair?.toBound() != null) {
      outboundSSR.add(departureWheelChair!.toBound());
    }
    if (returnWheelChair?.toBound() != null) {
      inboundSSR.add(returnWheelChair!.toBound());
    }

    if (departureSports?.toBound(sports: true) != null) {
      outboundSSR.add(departureSports!.toBound(sports: true));
    }

    if (returnSports?.toBound(sports: true) != null) {
      inboundSSR.add(returnSports!.toBound(sports: true));
    }

    //if(this.)

    final outboundSeat = departureSeats?.toOutbound(outboundRows);
    final inboundSeat = returnSeats?.toOutbound(inboundRows);
    final passenger = Passenger(
        paxType: peopleType?.code ?? "",
        ssr: Ssr(
          inbound: inboundSSR,
          outbound: outboundSSR,
        ),
        seat: Seat(
          outbound:
          outboundSeat?.copyWith(physicalFlightId: outboundPhysicalId) ??
              const Outbound(),
          inbound: inboundSeat?.copyWith(physicalFlightId: inboundPhysicalId) ??
              const Outbound(),
        ),
        infantAssociateIndex: infantIndex);
    return passenger;
  }

  num getTotalPrice() {
    num totalPrice = 0;
    totalPrice = getTotalPriceBundle() +
        getTotalPriceSeat() +
        getTotalPriceMeal() +
        getTotalPriceBaggage() +
        getTotalPriceSports() +
        getInsurancePrice() +
        getTotalPriceWheelChair();
    return totalPrice;
  }

  num getTotalPriceBundle() {
    num totalPrice = 0;
    totalPrice = getPartialPriceBundle(false) + getPartialPriceBundle(true);
    return totalPrice;
  }

  num getPartialPriceBundle(bool isDeparture) {
    num totalPrice = isDeparture
        ? (departureBundle?.bundle?.finalAmount ?? 0)
        : (returnBundle?.bundle?.finalAmount ?? 0);
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

  num getOldMeanPrice(bool isDeparture) {
    num totalPrice = 0;
    if (isDeparture) {
      for (var element in departureMeal.where((e) => e.isOld == true)) {
        totalPrice = totalPrice + element.finalAmount;
      }
    } else {
      for (var element in returnMeal) {
        totalPrice = totalPrice + element.finalAmount;
      }
    }
    return totalPrice;
  }

  num getPartialPriceMeal(bool isDeparture) {
    num totalPrice = 0;
    if (isDeparture) {
      for (var element in departureMeal) {
        totalPrice = totalPrice + element.finalAmount;
      }
    } else {
      for (var element in returnMeal) {
        totalPrice = totalPrice + element.finalAmount;
      }
    }
    return totalPrice;
  }

  num getPartialPriceMealForNew(bool isDeparture) {
    num totalPrice = 0;
    if (isDeparture) {
      for (var element in departureMeal.where((e) => e.isOld == false)) {
        totalPrice = totalPrice + element.finalAmount;
      }
    } else {
      for (var element in returnMeal.where((e) => e.isOld == false)) {
        totalPrice = totalPrice + element.finalAmount;
      }
    }
    return totalPrice;
  }

  num getTotalPriceBaggage() {
    num totalPrice = 0;
    totalPrice = getPartialPriceBaggage(false) + getPartialPriceBaggage(true);
    return totalPrice;
  }

  num getTotalPriceSports() {
    num totalPrice = 0;

    totalPrice = getPartialPriceSports(false) + getPartialPriceSports(true);
    return totalPrice;
  }

  num getTotalPriceWheelChair() {
    num totalPrice = 0;
    totalPrice = getPartialWheelChair(false) + getPartialWheelChair(true);
    return totalPrice;
  }

  num getInsurancePrice() {
    num totalPrice = 0;

    totalPrice = getInsuranceTotalPrice();

    return totalPrice;
  }

  num getPartialPriceBaggage(bool isDeparture) {
    num totalPrice = isDeparture
        ? departureBaggage?.finalAmount ?? 0
        : returnBaggage?.finalAmount ?? 0;
    return totalPrice;
  }

  num getPartialPriceSports(bool isDeparture) {
    num totalPrice = isDeparture
        ? departureSports?.finalAmount ?? 0
        : returnSports?.finalAmount ?? 0;
    return totalPrice;
  }

  num getPartialWheelChair(bool isDeparture) {
    num totalPrice = isDeparture
        ? departureWheelChair?.finalAmount ?? 0
        : returnWheelChair?.finalAmount ?? 0;
    return totalPrice;
  }

  num getInsuranceTotalPrice() {
    num totalPrice = insuranceGroup?.finalAmount ?? 0;

    return totalPrice;
  }

  bool isWithInfant(NumberPerson? numberPerson) {
    if (peopleType == PeopleType.adult &&
        ((numberPerson?.numberOfInfant ?? 0) >= (numberOrder ?? 0))) {
      return true;
    }
    return false;
  }

  String getPersonSelectorText(bool isActive, bool isDeparture,
      AddonType addonType,
      {List<Rows> rows = const []}) {
    if (isActive) return "selecting".tr();
    switch (addonType) {
      case AddonType.seat:
        if (isDeparture && departureSeats == null) return "noSeatSelected".tr();
        if (!isDeparture && returnSeats == null) return "noSeatSelected".tr();
        final seats = isDeparture ? departureSeats : returnSeats;
        final row =
            rows.firstWhereOrNull((element) => element.rowId == seats?.rowId);
        return '${seats?.seatColumn}${row?.rowNumber}';
      case AddonType.meal:
        if (isDeparture && departureMeal.isEmpty) return "noMeal".tr();
        if (!isDeparture && returnMeal.isEmpty) return "noMeal".tr();
        final meals = isDeparture ? departureMeal : returnMeal;
        return '${meals.length} ${meals.length > 1 ? " meals".tr() : "meal"
            .tr()}';
      case AddonType.baggage:
        if (isDeparture && departureBaggage == null &&
            departureSports == null) {
          return "noBaggageSelected".tr();
        }
        if (!isDeparture && returnBaggage == null && returnSports == null) {
          return "noBaggageSelected".tr();
        }
        var baggage = isDeparture ? departureBaggage : returnBaggage;
        var sportsBaggage = isDeparture ? departureSports : returnSports;

        if(baggage != null) {
          if(baggage.ssrCode == 'NOSELECT') {
            baggage = null;
          }
        }

        if(sportsBaggage != null) {
          if(sportsBaggage.ssrCode == 'NOSELECT') {
            sportsBaggage = null;
          }
        }


        if (baggage != null && sportsBaggage != null) {
          return '2 ${'baggage'.tr()}';
        }
        else if (baggage != null) {
          return '1 ${'baggage'.tr()}';
        }
        else if (sportsBaggage != null) {
          return '1 Baggage';
        }
        return 'noBundleSelected'.tr();
      case AddonType.special:
        int number = 0;
        if (isDeparture && departureWheelChair != null) number = number + 1;
        if (!isDeparture && returnWheelChair != null) number = number + 1;
        if (isDeparture && departureInsurance != null) number = number + 1;
        if (!isDeparture && returnInsurance != null) number = number + 1;
        return "$number ${number > 1 ? 'items'.tr() : 'item'.tr()} ${'selected'
            .tr()}";
      case AddonType.bundle:
        if (isDeparture && departureBundle == null) {
          return "noBundleSelected".tr();
        }
        if (!isDeparture && returnBundle == null)
          return "noBundleSelected".tr();
        final bundle = isDeparture ? departureBundle : returnBundle;
        return '${bundle?.detail?.bundleDescription}';
      case AddonType.none:
        return '';
      case AddonType.insurance:
        return '';
    }
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
    Bundle? Function()? departureSports,
    Bundle? Function()? returnSports,
    Bundle? Function()? departureWheelChair,
    Bundle? Function()? returnWheelChair,
    String? Function()? departureOkId,
    String? Function()? returnOkId,
    int? numberOrder,
    Bundle? insurance,
    bool insuranceEmpty = false,
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
      departureSports:
      departureSports != null ? departureSports() : this.departureSports,
      returnSports: returnSports != null ? returnSports() : this.returnSports,
      departureWheelChair: departureWheelChair != null
          ? departureWheelChair()
          : this.departureWheelChair,
      returnWheelChair:
      returnWheelChair != null ? returnWheelChair() : this.returnWheelChair,
      departureOkId:
      departureOkId != null ? departureOkId() : this.departureOkId,
      returnOkId: returnOkId != null ? returnOkId() : this.returnOkId,
      numberOrder: numberOrder ?? this.numberOrder,
      insuranceGroup: insuranceEmpty ? (null) : insurance ?? insuranceGroup,
    );
  }

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);

  @override
  String toString() {
    var cc = peopleType?.name;

    return "${peopleType?.name.tr() ?? ""} $numberOrder";
  }

  String toStringShort() {
    return "${(peopleType?.name[0].capitalize()) ?? ""}$numberOrder";
  }

  String generateText(NumberPerson? numberPerson, {String? separator}) {
    if (peopleType == PeopleType.adult &&
        ((numberPerson?.numberOfInfant ?? 0) >= (numberOrder ?? 0))) {
      return "${peopleType?.name.tr() ?? ""} $numberOrder ${separator ??
          "+ "}${PeopleType.infant.name.tr()} $numberOrder";
    }

    return "${peopleType?.name.tr() ?? ""} $numberOrder";
  }

  DateTime dateLimitEnd(DateTime? departDate) {
    final now = departDate ?? DateTime.now();
    switch (peopleType) {
      case PeopleType.adult:
        return DateTime(now.year - 12, now.month, now.day);
      case PeopleType.child:
        return DateTime(now.year - 2, now.month, now.day);
      case PeopleType.infant:
        return now.add(const Duration(days: -8));
      default:
        return now;
    }
  }

  DateTime dateLimitStart(DateTime? departDate) {
    final now = departDate ?? DateTime.now();
    switch (peopleType) {
      case PeopleType.adult:
        return DateTime(now.year - 210, now.month, now.day);
      case PeopleType.child:
        return DateTime(now.year - 12, now.month, now.day);
      case PeopleType.infant:
        final start = DateTime(now.year - 2, now.month, now.day + 1);
        return start;
      default:
        return now;
    }
  }
}

enum AddonType {
  bundle,
  seat,
  meal,
  baggage,
  special,
  insurance,
  none,
}


enum PeopleType {
  adult("ADT"),
  child("CHD"),
  infant("INF");

  const PeopleType(this.code);

  final String code;
}

extension PeopleTypeToString on PeopleType {
  String toPersonTypeString() {
    return toString().replaceAll('PeopleType.', '').capitalize();
  }
}

List<String> availableTitle = [  "Mr.",  "Mrs.",  "Ms.",  "Tun",  "Tan Sri",  "Miss",
  "Datin",  "Dato",  "Datuk",  "Datuk Seri",  "Datuk Sri",  "Datin Seri",  "Dato Seri",  "Dato' Sri",  "Datin Sri",  "Master",  "Puan Sri",  "Toh Puan"];


List<String> availableTitleChild = ["Mstr.", "Miss"];

List<String> get availableRelations {
  return [
    "family".tr(),
    "friends".tr(),
    "spouse".tr(),
    "guardian".tr(),
    "others".tr()
  ];
}


Map<String, String> get availableRelationsMapping {
  return {
    'family'.tr(): 'Family',
    'friends'.tr(): 'Friends',
    'spouse'.tr(): 'Spouse',
    'guardian'.tr(): 'Guardian',
    'others'.tr(): 'Others',
  };
}


List<String> availableTitleAll =
[
  "Mr.",
  "Mrs.",
  "Ms.",
  "Tun",
  "Tan Sri",
  "Mstr.",
  "Miss",
  "Datin",
  "Dato",
  "Datuk",
  "Datuk Seri",
  "Datuk Sri",
  "Datin Seri",
  "Dato Seri",
  "Dato' Sri",
  "Datin Sri",
  "Master",
  "Puan Sri",
  "Toh Puan"
];

