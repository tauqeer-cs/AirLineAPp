part of 'manage_booking_cubit.dart';

class ManageBookingState extends Equatable {
  final BlocState blocState;
  final String message;
  final bool isRememberMe;
  final bool isManageOpen;
  final bool isLoadingInfo;
  final bool dataLoaded;
  final ManageBookingResponse? manageBookingResponse;
  final String? pnrEntered;

  final bool checkedDeparture;
  final bool checkReturn;

  const ManageBookingState({
    this.blocState = BlocState.initial,
    this.message = "",
    this.isRememberMe = true,
    this.isManageOpen = true,
    this.isLoadingInfo = false,
    this.dataLoaded = false,
    this.manageBookingResponse,
    this.pnrEntered,
    this.checkedDeparture = false,
    this.checkReturn = false,
  });

  @override
  List<Object?> get props => [
        blocState,
        message,
        isRememberMe,
        isLoadingInfo,
        dataLoaded,
        manageBookingResponse,
        pnrEntered,
        checkedDeparture,
        checkReturn
      ];

  ManageBookingState copyWith({
    BlocState? blocState,
    String? message,
    bool? isRememberMe,
    bool? isManageOpen,
    bool? isLoadingInfo,
    bool? dataLoaded,
    ManageBookingResponse? manageBookingResponse,
    String? pnrEntered,
    bool? checkedDeparture,
    bool? checkReturn,
  }) {
    return ManageBookingState(
      message: message ?? this.message,
      blocState: blocState ?? this.blocState,
      isRememberMe: isRememberMe ?? this.isRememberMe,
      isManageOpen: isManageOpen ?? this.isManageOpen,
      isLoadingInfo: isLoadingInfo ?? this.isLoadingInfo,
      dataLoaded: dataLoaded ?? this.dataLoaded,
      manageBookingResponse:
          manageBookingResponse ?? this.manageBookingResponse,
      pnrEntered: pnrEntered ?? this.pnrEntered,
      checkedDeparture: checkedDeparture ?? this.checkedDeparture,
      checkReturn: checkReturn ?? this.checkReturn,
    );
  }
}
