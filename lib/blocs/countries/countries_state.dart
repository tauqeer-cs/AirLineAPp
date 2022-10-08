part of 'countries_cubit.dart';

class CountriesState extends Equatable {
  final List<Country> countries;
  final BlocState blocState;
  final String message;

  const CountriesState({
    this.countries =const [],
    this.blocState = BlocState.initial,
    this.message = '',
  });
  CountriesState copyWith({
    BlocState? blocState,
    String? message,
    List<Country>? countries,
  }) {
    return CountriesState(
      blocState: blocState ?? this.blocState,
      message: message ?? this.message,
      countries: countries ?? this.countries,
    );
  }
  @override
  List<Object?> get props => [countries, blocState, message];
}
