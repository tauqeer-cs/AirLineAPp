part of 'filter_cubit.dart';

class FilterState extends Equatable {
  final BlocState blocState;
  final String message;
  final FlightType flightType;
  final NumberPerson numberPerson;
  final Airports? destination;
  final Airports? origin;
  final DateTime? departDate;
  final DateTime? returnDate;

  const FilterState({
    this.blocState = BlocState.initial,
    this.message = "",
    this.flightType = FlightType.round,
    this.numberPerson = NumberPerson.empty,
    this.destination,
    this.origin,
    this.departDate,
    this.returnDate,
  });

  bool get isValid =>
      numberPerson != null && destination != null && origin != null &&
          departDate != null &&
          (returnDate != null || flightType == FlightType.round);

  @override
  List<Object?> get props =>
      [
        blocState,
        message,
        flightType,
        numberPerson,
        destination,
        origin,
        departDate,
        returnDate,
      ];

  FilterState copyWith({
    BlocState? blocState,
    String? message,
    FlightType? flightType,
    NumberPerson? numberPerson,
    Airports? destination,
    Airports? origin,
    DateTime? departDate,
    DateTime? returnDate,
  }) {
    return FilterState(
      message: message ?? this.message,
      blocState: blocState ?? this.blocState,
      flightType: flightType ?? this.flightType,
      numberPerson: numberPerson ?? this.numberPerson,
      destination: destination ?? this.destination,
      origin: origin ?? this.origin,
      departDate: departDate ?? this.departDate,
      returnDate: returnDate ?? this.returnDate,
    );
  }

  FilterState copyWithNull({
    BlocState? blocState,
    String? message,
    FlightType? flightType,
    NumberPerson? numberPerson,
    Airports? destination,
    Airports? origin,
    DateTime? departDate,
    DateTime? returnDate,
  }) {
    return FilterState(
      message: message ?? this.message,
      blocState: blocState ?? this.blocState,
      flightType: flightType ?? this.flightType,
      numberPerson: numberPerson ?? this.numberPerson,
      destination: destination,
      origin: origin ?? this.origin,
      departDate: departDate ?? this.departDate,
      returnDate: returnDate ?? this.returnDate,
    );
  }
}
