part of 'search_flight_cubit.dart';

class SearchFlightState extends Equatable {
  final SearchFlightResponse? flights;
  final FilterState? filterState;
  final BlocState blocState;
  final String message;

  final bool? isVisaPromo;


  const SearchFlightState({
    this.flights,
    this.blocState = BlocState.initial,
    this.message = '',
    this.filterState,
    this.isVisaPromo,
  });

  SearchFlightState copyWith({
    BlocState? blocState,
    String? message,
    FilterState? filterState,
    SearchFlightResponse? flights,
    bool? visaPromo
  }) {
    return SearchFlightState(
      blocState: blocState ?? this.blocState,
      message: message ?? this.message,
      filterState: filterState ?? this.filterState,
      flights: flights ?? this.flights,
      isVisaPromo: visaPromo ?? isVisaPromo,
    );
  }

  @override
  List<Object?> get props => [flights, blocState, message, filterState,isVisaPromo];

  void reloadView() {}


}
