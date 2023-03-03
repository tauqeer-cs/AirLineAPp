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
  final FlightResponse? flightSearchResponse;
  final String? flightMessageError;

  final bool loadingSummary;

  final bool loadingDatesData;
  final bool loadingSelectingFlight;
  final bool loadingCheckoutPayment;

  final CRP.ChangeFlightRequestResponse? changeFlightResponse;

  final InboundOutboundSegment? selectedDepartureFlight;
  final InboundOutboundSegment? selectedReturnFlight;

  final String? lastName;
  final bool checkedDeparture;
  final bool checkReturn;

  const ManageBookingState({
    this.blocState = BlocState.initial,
    this.message = "",
    this.loadingSummary = false,
    this.loadingSelectingFlight = false,
    this.loadingCheckoutPayment = false,
    this.selectedDepartureFlight,
    this.selectedReturnFlight,
    this.isRememberMe = true,
    this.isManageOpen = true,
    this.isLoadingInfo = false,
    this.dataLoaded = false,
    this.manageBookingResponse,
    this.pnrEntered,
    this.checkedDeparture = false,
    this.checkReturn = false,
    this.lastName,
    this.changeFlightResponse,
    this.flightSearchResponse,
    this.loadingDatesData = false,
    this.flightMessageError,
  });

  @override
  List<Object?> get props => [
        blocState,
        message,
        isRememberMe,
        selectedDepartureFlight,
        selectedReturnFlight,
        isLoadingInfo,
        dataLoaded,
        manageBookingResponse,
        pnrEntered,
        checkedDeparture,
        checkReturn,
        lastName,
        flightSearchResponse,
        changeFlightResponse,
        loadingDatesData,
        loadingSelectingFlight,
        loadingCheckoutPayment,
        loadingSummary,
        flightMessageError
      ];

  ManageBookingState copyWith(
      {BlocState? blocState,
      String? message,
      bool? isRememberMe,
      bool? isManageOpen,
      bool? isLoadingInfo,
      bool? dataLoaded,
      ManageBookingResponse? manageBookingResponse,
      String? pnrEntered,
      bool? checkedDeparture,
      bool? checkReturn,
      bool? loadingCheckoutPayment,
      String? lastName,
      bool? loadingSummary,
      FlightResponse? flightSearchResponse,
      InboundOutboundSegment? selectedDepartureFlight,
      InboundOutboundSegment? selectedReturnFlight,
      bool removeSelectedDeparture = false,
      bool removeSelectedReturn = false,
      bool? loadingDatesData,
      String? flightMessageError,
      bool? loadingSelectingFlight,
      CRP.ChangeFlightRequestResponse? changeFlightResponse}) {
    return ManageBookingState(
      message: message ?? this.message,
      blocState: blocState ?? this.blocState,
      isRememberMe: isRememberMe ?? this.isRememberMe,
      isManageOpen: isManageOpen ?? this.isManageOpen,
      loadingSelectingFlight:
          loadingSelectingFlight ?? this.loadingSelectingFlight,
      isLoadingInfo: isLoadingInfo ?? this.isLoadingInfo,
      dataLoaded: dataLoaded ?? this.dataLoaded,
      manageBookingResponse:
          manageBookingResponse ?? this.manageBookingResponse,
      pnrEntered: pnrEntered ?? this.pnrEntered,
      checkedDeparture: checkedDeparture ?? this.checkedDeparture,
      checkReturn: checkReturn ?? this.checkReturn,
      lastName: lastName ?? this.lastName,
      loadingCheckoutPayment:
          loadingCheckoutPayment ?? this.loadingCheckoutPayment,
      flightSearchResponse: flightSearchResponse ?? this.flightSearchResponse,
      selectedDepartureFlight: removeSelectedDeparture
          ? null
          : selectedDepartureFlight ?? this.selectedDepartureFlight,
      selectedReturnFlight: removeSelectedReturn
          ? null
          : selectedReturnFlight ?? this.selectedReturnFlight,
      changeFlightResponse: changeFlightResponse ?? this.changeFlightResponse,
      loadingDatesData: loadingDatesData ?? this.loadingDatesData,
      loadingSummary: loadingSummary ?? this.loadingSummary,
      flightMessageError: flightMessageError ?? this.flightMessageError,
    );
  }
}
