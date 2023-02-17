part of 'bookings_cubit.dart';


class BookingsState extends Equatable {
  final BlocState blocState;
  final String message;
  final bool isRememberMe;
  final bool isManageOpen;

  const BookingsState({
    this.blocState = BlocState.initial,
    this.message = "",
    this.isRememberMe = true,
    this.isManageOpen = true,
  });

  @override
  List<Object?> get props => [blocState, message, isRememberMe];

  BookingsState copyWith(
      {BlocState? blocState, String? message, bool? isRememberMe,bool? isManageOpen}) {
    return BookingsState(
      message: message ?? this.message,
      blocState: blocState ?? this.blocState,
      isRememberMe: isRememberMe ?? this.isRememberMe,
      isManageOpen: isManageOpen ?? this.isManageOpen,
    );
  }
}

