part of 'manage_booking_cubit.dart';


class ManageBookingState extends Equatable {
  final BlocState blocState;
  final String message;
  final bool isRememberMe;
  final bool isManageOpen;
  final bool isLoadingInfo;

  const ManageBookingState({
    this.blocState = BlocState.initial,
    this.message = "",
    this.isRememberMe = true,
    this.isManageOpen = true,
    this.isLoadingInfo = false,
  });

  @override
  List<Object?> get props => [blocState, message, isRememberMe, isLoadingInfo];

  ManageBookingState copyWith(
      {BlocState? blocState,
        String? message,
        bool? isRememberMe,
        bool? isManageOpen,
        bool? isLoadingInfo}) {
    return ManageBookingState(
      message: message ?? this.message,
      blocState: blocState ?? this.blocState,
      isRememberMe: isRememberMe ?? this.isRememberMe,
      isManageOpen: isManageOpen ?? this.isManageOpen,
      isLoadingInfo: isLoadingInfo ?? this.isLoadingInfo,

    );
  }
}
