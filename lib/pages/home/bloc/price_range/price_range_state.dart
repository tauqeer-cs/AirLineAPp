part of 'price_range_cubit.dart';



class PriceRangeState extends Equatable {
  final List<DateRangePrice> prices;
  final BlocState blocState;
  final String message;

  const PriceRangeState({
    this.prices =const [],
    this.blocState = BlocState.initial,
    this.message = '',
  });

  PriceRangeState copyWith({
    BlocState? blocState,
    String? message,
    List<DateRangePrice>? prices,
  }) {
    return PriceRangeState(
      blocState: blocState ?? this.blocState,
      message: message ?? this.message,
      prices: prices ?? this.prices,
    );
  }

  @override
  List<Object?> get props => [prices, blocState, message];
}
