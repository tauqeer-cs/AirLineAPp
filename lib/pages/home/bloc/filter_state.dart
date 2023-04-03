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
  final String? promoCode;

  const FilterState({
    this.blocState = BlocState.initial,
    this.message = "",
    this.flightType = FlightType.round,
    this.numberPerson = NumberPerson.adult,
    this.destination,
    this.origin,
    this.departDate,
    this.returnDate,
    this.promoCode,
  });

  bool get isValid {


   return  (numberPerson != NumberPerson.empty && numberPerson.hasAdult) &&
        destination != null &&
        origin != null &&
        departDate != null &&
        (returnDate != null || flightType == FlightType.oneWay);
  }


  String get beautify =>
      "${origin?.name?.camelCase()} To ${destination?.name?.camelCase()}";

  String get beautifyReverse =>
      "${destination?.name?.camelCase()} To ${origin?.name?.camelCase()}";

  String get beautifyShort => "${origin?.code} To ${destination?.code}";

  Widget beautifyWithRow(bool isReverse, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        kVerticalSpacerMini,
        Text(
          isReverse ? destination?.code ?? "" : origin?.code ?? "",
          style: kLargeRegular.copyWith(color: isActive ? Colors.white : null),
        ),
        FaIcon(FontAwesomeIcons.plane,color: isActive ? Colors.white : Styles.kBorderColor),
        Text(
          isReverse ? origin?.code ?? "" : destination?.code ?? "",
          style: kLargeRegular.copyWith(color: isActive ? Colors.white : null),
        ),
        kVerticalSpacerMini,
      ],
    );
  }

  String get beautifyCode => "${origin?.code}-${destination?.code}";

  String get routeShort => "${origin?.code}-${destination?.code}";

  String get beautifyReverseShort => "${destination?.code} To ${origin?.code}";

  @override
  List<Object?> get props => [
        blocState,
        message,
        flightType,
        numberPerson,
        destination,
        origin,
        departDate,
        returnDate,
        promoCode,
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
    String? promoCode,
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
      promoCode: promoCode ?? this.promoCode,
    );
  }
}
