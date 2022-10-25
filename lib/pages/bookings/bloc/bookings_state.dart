part of 'bookings_cubit.dart';


class BookingsState extends Equatable {
  final BlocState blocState;
  final String message;
  final bool isRememberMe;

  const BookingsState({
    this.blocState = BlocState.initial,
    this.message = "",
    this.isRememberMe = true,
  });

  @override
  List<Object?> get props => [blocState, message, isRememberMe];

  BookingsState copyWith(
      {BlocState? blocState, String? message, bool? isRememberMe}) {
    return BookingsState(
      message: message ?? this.message,
      blocState: blocState ?? this.blocState,
      isRememberMe: isRememberMe ?? this.isRememberMe,
    );
  }
}

