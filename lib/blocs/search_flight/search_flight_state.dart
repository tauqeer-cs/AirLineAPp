part of 'search_flight_cubit.dart';

class SearchFlightState extends Equatable {
  final SearchFlightResponse? flights;
  final FilterState? filterState;
  final BlocState blocState;
  final String message;

  const SearchFlightState({
    this.flights,
    this.blocState = BlocState.initial,
    this.message = '',
    this.filterState,
  });

  SearchFlightState copyWith({
    BlocState? blocState,
    String? message,
    FilterState? filterState,
    SearchFlightResponse? flights,
  }) {
    return SearchFlightState(
      blocState: blocState ?? this.blocState,
      message: message ?? this.message,
      filterState: filterState ?? this.filterState,
      flights: flights ?? this.flights,
    );
  }

  @override
  List<Object?> get props => [flights, blocState, message, filterState];
}
