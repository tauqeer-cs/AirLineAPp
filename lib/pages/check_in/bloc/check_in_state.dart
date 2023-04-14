part of 'check_in_cubit.dart';

@CopyWith(copyWithNull: true)
class CheckInState extends Equatable {
  final BlocState blocState;
  final String message;
  final bool isRememberMe;
  final ManageBookingResponse? manageBookingResponse;
  final bool isLoadingInfo;
  final bool loadingListDetailItem;
  final UpcomingBookings? bookingSelected;

  final bool showUpcoming;
  final bool loadBoardingDate;

  final bool checkedDeparture;


  final bool isDownloading;

  final bool listToCall;
  final bool checkReturn;
  final List<UpcomingBookings>? upcomingBookings;
  final List<UpcomingBookings>? pastBookings;

  final List<BoardingPassPassenger>? outboundBoardingPassPassenger;
  final List<BoardingPassPassenger>? inboundBoardingPassPassenger;

  final String? pnrEntered;
  final String? lastName;

  final bool checkingInFlight;

  const CheckInState( {
    this.blocState = BlocState.initial,
    this.message = "",
    this.pastBookings,
    this.isRememberMe = true,
    this.checkingInFlight = false,
    this.checkedDeparture = false,
    this.manageBookingResponse,
    this.pnrEntered,
    this.lastName,
    this.loadBoardingDate = false,
    this.isLoadingInfo = false,
    this.loadingListDetailItem = false,
    this.upcomingBookings,
    this.bookingSelected,
    this.listToCall = false,
    this.checkReturn = false,
    this.showUpcoming = true,
    this.outboundBoardingPassPassenger,
    this.inboundBoardingPassPassenger ,
    this.isDownloading = false,
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
    checkReturn,
    showUpcoming,
    pastBookings,
    isDownloading,
    loadBoardingDate,
    outboundBoardingPassPassenger,
    inboundBoardingPassPassenger,
    checkingInFlight,
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
        bool? showUpcoming,
      bool? loadBoardingDate,
        bool? checkingInFlight,
      List<UpcomingBookings>? upcomingBookings,
        List<UpcomingBookings>? pastBookings,
        List<BoardingPassPassenger>? outboundBoardingPassPassenger,
        List<BoardingPassPassenger>? inboundBoardingPassPassenger,
        bool? isDownloading,
      }) {
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
      showUpcoming: showUpcoming ?? this.showUpcoming,
      pastBookings: pastBookings ?? this.pastBookings,
      checkingInFlight: checkingInFlight ?? this.checkingInFlight,
      loadBoardingDate: loadBoardingDate ?? this.loadBoardingDate,
      outboundBoardingPassPassenger: outboundBoardingPassPassenger ?? this.outboundBoardingPassPassenger,
      inboundBoardingPassPassenger: inboundBoardingPassPassenger ?? this.inboundBoardingPassPassenger,
      isDownloading: isDownloading ?? this.isDownloading,

    );
  }
}
