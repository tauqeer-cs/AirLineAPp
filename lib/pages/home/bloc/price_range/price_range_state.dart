part of 'price_range_cubit.dart';



class PriceRangeState extends Equatable {
  final List<DateRangePrice> prices;
  final List<DateTime> loadedDate;
  final BlocState blocState;
  final String message;
  final DateTime? loadingDate;

  const PriceRangeState({
    this.loadingDate,
    this.prices =const [],
    this.blocState = BlocState.initial,
    this.message = '',
    this.loadedDate = const []
  });

  PriceRangeState copyWith({
    BlocState? blocState,
    String? message,
    List<DateRangePrice>? prices,
    DateTime? loadingDate,
    List<DateTime>? loadedDate,

  }) {
    return PriceRangeState(
      loadedDate: loadedDate ?? this.loadedDate,
      blocState: blocState ?? this.blocState,
      message: message ?? this.message,
      prices: prices ?? this.prices,
      loadingDate: loadingDate ?? this.loadingDate,
    );
  }

  @override
  List<Object?> get props => [prices, blocState, message];
}
