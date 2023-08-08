part of 'countries_cubit.dart';

class CountriesState extends Equatable {
  final List<Country> countries;
  final List<States>? states;

  final BlocState blocState;
  final String message;

  const CountriesState({
    this.countries =const [],
    this.blocState = BlocState.initial,
    this.message = '',
    this.states,

  });
  CountriesState copyWith({
    BlocState? blocState,
    String? message,
    List<Country>? countries,
    List<States>? states,
  }) {
    return CountriesState(
      blocState: blocState ?? this.blocState,
      message: message ?? this.message,
      countries: countries ?? this.countries,
      states: states ?? this.states,
    );
  }
  @override
  List<Object?> get props => [countries, blocState, message,states];
}
