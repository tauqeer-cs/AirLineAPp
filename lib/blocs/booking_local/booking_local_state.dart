part of 'booking_local_cubit.dart';



class BookingLocalState extends Equatable {
  final List<BookingLocal> bookings;
  final BlocState blocState;
  final String message;

  const BookingLocalState({
    this.bookings =const [],
    this.blocState = BlocState.initial,
    this.message = '',
  });

  BookingLocalState copyWith({
    BlocState? blocState,
    String? message,
    List<BookingLocal>? bookings,
  }) {
    return BookingLocalState(
      blocState: blocState ?? this.blocState,
      message: message ?? this.message,
      bookings: bookings ?? this.bookings,
    );
  }

  @override
  List<Object?> get props => [bookings, blocState, message];
}

