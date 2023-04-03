part of 'check_in_cubit.dart';

class CheckInState extends Equatable {
  final BlocState blocState;
  final String message;
  final bool isRememberMe;
  final ManageBookingResponse? manageBookingResponse;
  final bool isLoadingInfo;
  final bool loadingListDetailItem;
  final UpcomingBookings? bookingSelected;

  final bool checkedDeparture;

  final bool listToCall;
  final bool checkReturn;
  final List<UpcomingBookings>? upcomingBookings;

  final String? pnrEntered;
  final String? lastName;

  const CheckInState( {
    this.blocState = BlocState.initial,
    this.message = "",
    this.isRememberMe = true,
    this.checkedDeparture = false,
    this.manageBookingResponse,
    this.pnrEntered,
    this.lastName,
    this.isLoadingInfo = false,
    this.loadingListDetailItem = false,
    this.upcomingBookings,
    this.bookingSelected,
    this.listToCall = false,
    this.checkReturn = false,
  });

  @override
  List<Object?> get props => [
        blocState,
        message,
        isRememberMe,
        manageBookingResponse,
        pnrEntered,
        lastName,
        isLoadingInfo,
        upcomingBookings,
    loadingListDetailItem,
    bookingSelected,
    listToCall,
    checkedDeparture,
    checkReturn

      ];

  CheckInState copyWith(
      {BlocState? blocState,
      String? message,
      bool? isRememberMe,
      bool? isLoadingInfo,
      ManageBookingResponse? manageBookingResponse,
      String? pnrEntered,
      String? lastName,
        bool? loadingListDetailItem,
        UpcomingBookings? bookingSelected,
        bool? listToCall,
        bool? checkedDeparture,
        bool? checkReturn,
      List<UpcomingBookings>? upcomingBookings}) {
    return CheckInState(
      message: message ?? this.message,
      blocState: blocState ?? this.blocState,
      isRememberMe: isRememberMe ?? this.isRememberMe,
      manageBookingResponse:
          manageBookingResponse ?? this.manageBookingResponse,
      pnrEntered: pnrEntered ?? this.pnrEntered,
      lastName: lastName ?? this.lastName,
      isLoadingInfo: isLoadingInfo ?? this.isLoadingInfo,
      upcomingBookings: upcomingBookings ?? this.upcomingBookings,
      loadingListDetailItem: loadingListDetailItem ?? this.loadingListDetailItem,
      bookingSelected: bookingSelected ?? this.bookingSelected,
      listToCall: listToCall ?? this.listToCall,
      checkedDeparture: checkedDeparture ?? this.checkedDeparture,
      checkReturn: checkReturn ?? this.checkReturn,

    );
  }
}
