part of 'manage_booking_cubit.dart';

@CopyWith(copyWithNull: true)
class ManageBookingState extends Equatable {
  final AddonType? addOnOptionSelected;

  final bool showingVoucher;

  final FightAddOns? addOnList;

  final AvailableRedeemOptions? rewardItem;

  final bool? hasPendingError;

  final String? flightToken;
  final RedemptionOption? redemptionOption;

  final ChangeSsrResponse? changeSsrResponse;

  final bool showReward;


  final bool isLoadingPromo;

  final bool isPaying;

  final bool showErrorOnContact;
  final bool showErrorOnEmergency;




  final String? newContactFirstName;

  final String? newContactLastName;
  final String? newContactCountryPhCode;
  final String? newContactPhNo;
  final String? newContactEmail;

  final String? newEmergencyFirstName;
  final String? newEmergencyLastName;
  final String? newEmergencyCountryPhCode;
  final String? newEmergencyPhNo;
  final String? newEmergencyRelation;

  final bool anyContactValueChange;

  final bool savingContactChanges;

  final FR.FlightSSR? flightSSR;
  final FlightSeats? flightSeats;

  String  findSeatObjectFromId(String seatId) {

    return '';
  }
  //BundleGroupSeat.fromJson(json['seatGroup'] as Map<String, dynamic>)


  final String? newCompanyTaxName;
  final String? newCompanyTaxAddress;
  final String? newCompanyTaxState;
  final String? newCompanyTaxCity;
  final String? newCompanyTaxPostCode;
  final String? newCompanyTaxEmailAddress;
  final bool? promoReady;


  final BlocState blocState;
  final String message;
  final bool showPending;

  final bool isRememberMe;
  final bool isManageOpen;
  final bool isLoadingInfo;
  final bool dataLoaded;
  final InsuranceType? insuranceType;
  final InsuranceType? confirmedInsuranceType;

  final bool seatDeparture;
  final bool foodDepearture;
  final bool baggageDeparture;
  final bool specialAppOpsDeparture;

  final ManageBookingResponse? manageBookingResponse;
  final String? pnrEntered;
  final FlightResponse? flightSearchResponse;
  final String flightMessageError;
  final bool loadingSummary;
  final bool extraLoading;


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


  const ManageBookingState( {
     this.showReward = false,
    this.promoReady = false,
    this.blocState = BlocState.initial,
    this.message = "",
    this.addOnOptionSelected,
    this.anyContactValueChange = false,
    this.selectedPax,
    this.flightToken,
    this.changeSsrResponse,
    this.isPaying = false,
    this.foodDepearture = true,
    this.baggageDeparture = true,
    this.specialAppOpsDeparture = true,
    this.insuranceType,
    this.rewardItem,
    this.showingVoucher = false,
    this.contactsSectionExpanded = false,
    this.emergencySectionExpanded = false,
    this.companyTaxInvoiceExpanded = false,
    this.paymentDetailsExpanded = false,
    this.loadingSummary = false,
    this.seatDeparture = true,
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
    this.newContactFirstName,
    this.newContactLastName,
    this.newContactCountryPhCode,
    this.newContactPhNo,
    this.newContactEmail,
    this.newEmergencyFirstName,
    this.newEmergencyLastName,
    this.newEmergencyCountryPhCode,
    this.newEmergencyPhNo,
    this.newEmergencyRelation,
    this.newCompanyTaxName,
    this.newCompanyTaxAddress,
    this.newCompanyTaxState,
    this.newCompanyTaxCity,
    this.newCompanyTaxPostCode,
    this.newCompanyTaxEmailAddress,
    this.addOnList,
    this.savingContactChanges = false,
    this.flightSSR,
    this.flightSeats,
    this.extraLoading = false,
    this.confirmedInsuranceType,
    this.redemptionOption,
    this.isLoadingPromo = false,
    this.hasPendingError = false,
    this.showErrorOnContact = false,
    this.showErrorOnEmergency = false,

  });

  @override
  List<Object?> get props => [
        blocState,
        message,
    anyContactValueChange,
        isRememberMe,
        selectedDepartureFlight,
        selectedReturnFlight,
        isLoadingInfo,
        dataLoaded,
        manageBookingResponse,
        pnrEntered,
    flightToken,
        checkedDeparture,
        checkReturn,
        lastName,
        showPending,
        insuranceType,
        flightSearchResponse,
        changeFlightResponse,
        loadingDatesData,
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
        seatDeparture,
        foodDepearture,
        baggageDeparture,
        specialAppOpsDeparture,
    extraLoading,
    newEmergencyFirstName,
    flightSSR,
    newEmergencyLastName,
    newEmergencyCountryPhCode,
    newEmergencyPhNo,
    newEmergencyRelation,
    newCompanyTaxName,
    newCompanyTaxAddress,
    newCompanyTaxState,
    newCompanyTaxCity,
    newCompanyTaxPostCode,
    newCompanyTaxEmailAddress,
    savingContactChanges,
    addOnList,
    flightSeats,
    isPaying,
    confirmedInsuranceType,
    promoReady,
    isLoadingPromo,
    rewardItem,
    showReward,
    hasPendingError,
    showingVoucher,
 changeSsrResponse,
  showErrorOnContact,
  showErrorOnEmergency,

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
    InsuranceType? insuranceType,
    bool? seatDeparture,
    bool? foodDepearture,
    bool? baggageDeparture,
    bool? specialAppOpsDeparture,
    String? newContactFirstName,
    String? newContactLastName,
    String? newContactCountryPhCode,
    String? newContactPhNo,
    String? newContactEmail,
    String? newEmergencyFirstName,
    String? newEmergencyLastName,
    String? newEmergencyCountryPhCode,
    String? newEmergencyPhNo,
    String? newEmergencyRelation,
    String? newCompanyTaxAame,
    String? newCompanyTaxAddress,
    String? newCompanyTaxState,
    String? newCompanyTaxCity,
    String? newCompanyTaxPostCode,
    String? newCompanyTaxEmailAddress,
    bool? anyContactValueChange,
    bool? savingContactChanges,
    FR.FlightSSR? flightSSR,
    FightAddOns? addOnList,
    FlightSeats? flightSeats,
    bool? isPaying,
    bool? extraLoading,
    String? flightToken,
    InsuranceType? confirmedInsuranceType,
    RedemptionOption? redemptionOption,
    bool? promoReady,
    bool? isLoadingPromo,
    AvailableRedeemOptions? rewardItem,
    bool? showReward,
    bool? hasPendingError,
    bool? showingVoucher,
    ChangeSsrResponse? changeSsrResponse,
     bool? showErrorOnContact,
     bool? showErrorOnEmergency,

  }) {
    return ManageBookingState(

      changeSsrResponse : changeSsrResponse ?? this.changeSsrResponse,
      showErrorOnContact : showErrorOnContact ?? this.showErrorOnContact,
      showErrorOnEmergency : showErrorOnEmergency ?? this.showErrorOnEmergency,
      showingVoucher : showingVoucher ?? this.showingVoucher,
      showReward : showReward ?? this.showReward,
      rewardItem : rewardItem ?? this.rewardItem,
      confirmedInsuranceType : confirmedInsuranceType ?? this.confirmedInsuranceType,
      extraLoading : extraLoading ?? this.extraLoading,
      redemptionOption : redemptionOption ?? this.redemptionOption,
      promoReady : promoReady ?? this.promoReady,
      isPaying : isPaying ?? this.isPaying,
      flightSeats : flightSeats ?? this.flightSeats,
      addOnList : addOnList ?? this.addOnList,
      flightToken : flightToken ?? this.flightToken,
      flightSSR : flightSSR ?? this.flightSSR,
      savingContactChanges : savingContactChanges ?? this.savingContactChanges,
      anyContactValueChange : anyContactValueChange ?? this.anyContactValueChange,
      newEmergencyFirstName :  newEmergencyFirstName ?? this.newEmergencyFirstName,
      newEmergencyLastName :  newEmergencyLastName ?? this.newEmergencyLastName,
      newEmergencyCountryPhCode  : newEmergencyCountryPhCode  ?? this.newEmergencyCountryPhCode,
      newEmergencyPhNo :  newEmergencyPhNo ?? this.newEmergencyPhNo,
      newEmergencyRelation :  newEmergencyRelation ?? this.newEmergencyRelation,
      newContactFirstName :  newContactFirstName ?? this.newContactFirstName,
      newContactLastName :  newContactLastName ?? this.newContactLastName,
      newContactCountryPhCode  : newContactCountryPhCode ?? this.newContactCountryPhCode,
      newContactPhNo  :  newContactPhNo ?? this.newContactPhNo,
      newContactEmail  :  newContactEmail ?? this.newContactEmail,
      foodDepearture : foodDepearture ?? this.foodDepearture,
      seatDeparture :  seatDeparture ?? this.seatDeparture,
      baggageDeparture  : baggageDeparture ?? this.baggageDeparture,
      specialAppOpsDeparture : specialAppOpsDeparture ?? this.specialAppOpsDeparture,
      message: message ?? this.message,
      contactsSectionExpanded:
          contactsSectionExpanded ?? this.contactsSectionExpanded,
      emergencySectionExpanded:
          emergencySectionExpanded ?? this.emergencySectionExpanded,
      companyTaxInvoiceExpanded:
          companyTaxInvoiceExpanded ?? this.companyTaxInvoiceExpanded,
      paymentDetailsExpanded:
          paymentDetailsExpanded ?? this.paymentDetailsExpanded,
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
      insuranceType: insuranceType ?? this.insuranceType,
      newCompanyTaxName : newCompanyTaxAame  ?? newCompanyTaxName,
      newCompanyTaxAddress :  newCompanyTaxAddress ?? this.newCompanyTaxAddress,
      newCompanyTaxState  : newCompanyTaxState ?? this.newCompanyTaxState,
      newCompanyTaxCity : newCompanyTaxCity ?? this.newCompanyTaxCity,
      newCompanyTaxPostCode : newCompanyTaxPostCode ?? this.newCompanyTaxPostCode,
      newCompanyTaxEmailAddress : newCompanyTaxEmailAddress ?? this.newCompanyTaxEmailAddress,
      isLoadingPromo : isLoadingPromo ?? this.isLoadingPromo,
      hasPendingError : hasPendingError ?? this.hasPendingError,
    );
  }
}
