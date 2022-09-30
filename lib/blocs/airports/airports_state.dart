part of 'airports_cubit.dart';


class AirportsState extends Equatable {
  final List<Airports> airports;
  final BlocState blocState;
  final String message;

  const AirportsState({
    this.airports =const [],
    this.blocState = BlocState.initial,
    this.message = '',
  });

  AirportsState copyWith({
    BlocState? blocState,
    String? message,
    List<Airports>? airports,
  }) {
    return AirportsState(
      blocState: blocState ?? this.blocState,
      message: message ?? this.message,
      airports: airports ?? this.airports,
    );
  }

  @override
  List<Object?> get props => [airports, blocState, message];
}

