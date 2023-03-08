part of 'manage_booking_cubit.dart';

@CopyWith(copyWithNull: true)
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
  final String flightMessageError;

  final bool loadingSummary;

  final bool loadingDatesData;
  final bool loadingSelectingFlight;
  final bool loadingCheckoutPayment;

  final ChangeFlightRequestResponse? changeFlightResponse;

  final String? superPnrNo;
  final int? orderId;

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
    this.orderId,
    this.selectedReturnFlight,
    this.isRememberMe = true,
    this.isManageOpen = true,
    this.isLoadingInfo = false,
    this.dataLoaded = false,
    this.manageBookingResponse,
    this.pnrEntered,
    this.superPnrNo,
    this.checkedDeparture = false,
    this.checkReturn = false,
    this.lastName,
    this.changeFlightResponse,
    this.flightSearchResponse,
    this.loadingDatesData = false,
    this.flightMessageError = '',
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
        superPnrNo,
        orderId,
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
      String flightMessageError = '',
      bool? loadingSelectingFlight,
      String? superPnrNo,
      int? orderId,
      ChangeFlightRequestResponse? changeFlightResponse}) {
    return ManageBookingState(
      message: message ?? this.message,
      blocState: blocState ?? this.blocState,
      isRememberMe: isRememberMe ?? this.isRememberMe,
      isManageOpen: isManageOpen ?? this.isManageOpen,
      loadingSelectingFlight:
          loadingSelectingFlight ?? this.loadingSelectingFlight,
      superPnrNo: superPnrNo ?? this.superPnrNo,
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
      selectedDepartureFlight: removeSelectedDeparture == true
          ? null
          : selectedDepartureFlight ?? this.selectedDepartureFlight,
      selectedReturnFlight: removeSelectedReturn
          ? null
          : selectedReturnFlight ?? this.selectedReturnFlight,
      changeFlightResponse: changeFlightResponse ?? this.changeFlightResponse,
      loadingDatesData: loadingDatesData ?? this.loadingDatesData,
      loadingSummary: loadingSummary ?? this.loadingSummary,
      flightMessageError: flightMessageError,
      orderId: orderId ?? this.orderId,
    );
  }
}

/*
extension $ManageBookingStateCopyWith on BookingState {
  /// Returns a callable class that can be used as follows: `instanceOfBookingState.copyWith(...)` or like so:`instanceOfBookingState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ManageBookingStateCWProxy get copyWith => _$ManageBookingStateCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `BookingState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BookingState(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  ManageBookingState copyWithNull({
    bool departureColorMapping = false,
  }) {
    return ManageBookingState(
      this.selectedDepartureFlight = this.,
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
      this.flightMessageError = '',
    );
  }
}


* */
