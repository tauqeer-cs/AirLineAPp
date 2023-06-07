part of 'manage_booking_cubit.dart';

@CopyWith(copyWithNull: true)
class ManageBookingState extends Equatable {
  final AddonType? addOnOptionSelected;

  final VerifyResponse? verifyResponse;

  final BlocState blocState;
  final String message;
  final bool showPending;

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

  final PassengersWithSSR? selectedPax;

  final bool contactsSectionExpanded;
  final bool emergencySectionExpanded;
  final bool companyTaxInvoiceExpanded;
  final bool paymentDetailsExpanded;

  const ManageBookingState({
    this.blocState = BlocState.initial,
    this.message = "",
    this.addOnOptionSelected,
    this.selectedPax,
    this.verifyResponse,
    this.contactsSectionExpanded = false,
  this.emergencySectionExpanded = false,
  this.companyTaxInvoiceExpanded = false,
  this.paymentDetailsExpanded = false,
    this.loadingSummary = false,
    this.loadingSelectingFlight = false,
    this.loadingCheckoutPayment = false,
    this.selectedDepartureFlight,
    this.orderId,
    this.showPending = false,
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
    showPending,
        flightSearchResponse,
        changeFlightResponse,
        loadingDatesData,
    verifyResponse,
        loadingSelectingFlight,
        loadingCheckoutPayment,
        loadingSummary,
        superPnrNo,
        orderId,
        flightMessageError,
        selectedPax,
        addOnOptionSelected,
    contactsSectionExpanded,
     emergencySectionExpanded,
    companyTaxInvoiceExpanded,
    paymentDetailsExpanded,
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
        bool? showPending,
      ChangeFlightRequestResponse? changeFlightResponse,
        PassengersWithSSR? selectedPax,
        AddonType? addOnOptionSelected,
        bool? contactsSectionExpanded,
        bool? emergencySectionExpanded,
        bool? companyTaxInvoiceExpanded,
        bool? paymentDetailsExpanded,
        VerifyResponse? verifyResponse,
      }) {
    return ManageBookingState(
      verifyResponse: verifyResponse ?? this.verifyResponse,
      message: message ?? this.message,
      contactsSectionExpanded: contactsSectionExpanded ?? this.contactsSectionExpanded,
      emergencySectionExpanded: emergencySectionExpanded ?? this.emergencySectionExpanded,
      companyTaxInvoiceExpanded: companyTaxInvoiceExpanded ?? this.companyTaxInvoiceExpanded,
      paymentDetailsExpanded: paymentDetailsExpanded ?? this.paymentDetailsExpanded,
      addOnOptionSelected: addOnOptionSelected ?? this.addOnOptionSelected,
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
      showPending: showPending ?? this.showPending,


      selectedPax: selectedPax ?? this.selectedPax,
    );
  }
}

