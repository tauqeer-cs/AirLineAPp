import 'package:app/data/responses/verify_response.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../models/confirmation_model.dart';
import '../../models/number_person.dart';
import '../../utils/date_utils.dart';
import '../../data/responses/verify_response.dart' as Vs;
import '../requests/flight_summary_pnr_request.dart' as FS;
import 'change_flight_response.dart' as CR;

import '../../data/requests/flight_summary_pnr_request.dart' as FS;

class ManageBookingResponse {


  ManageBookingResponse copyWith({
    Result? result,
    bool? success,
    String? message,
    bool? customSelected,
    DateTime? newStartDateSelected,
    DateTime? newReturnDateSelected,

    Bundle? allInsuranceBundleSelected,
    FS.Bound? allInsuranceBoundSelected,
    Bundle? confirmedInsuranceBundleSelected,
    FS.Bound? confirmedInsuranceBoundSelected,


  }) {
    return ManageBookingResponse(
      result: result ?? this.result,
      success: success ?? this.success,
      message: message ?? this.message,
      customSelected: customSelected ?? this.customSelected,
      allInsuranceBundleSelected : allInsuranceBundleSelected ?? this.allInsuranceBundleSelected,
      allInsuranceBoundSelected :  allInsuranceBoundSelected ?? this.allInsuranceBoundSelected,
      confirmedInsuranceBundleSelected :  confirmedInsuranceBundleSelected ?? this.confirmedInsuranceBundleSelected,
      confirmedInsuranceBoundSelected : confirmedInsuranceBoundSelected ?? this.confirmedInsuranceBoundSelected,
    );
  }

  Result? result;
  bool? success;
  String? message;

  bool? allInsuranceSelected = false;

  Bundle? allInsuranceBundleSelected;
  FS.Bound? allInsuranceBoundSelected;

  Bundle? confirmedInsuranceBundleSelected;
  FS.Bound? confirmedInsuranceBoundSelected;



  bool customSelected = false;

  DateTime? newStartDateSelected;
  DateTime? newReturnDateSelected;

  num? get previousFirstBundleFart {
    return result?.passengersWithSSR?.first.fareAndBundleDetail?.totalAmount;
  }

  DateTime? get currentStartDate {
    if (customSelected && newStartDateSelected != null) {
      return newStartDateSelected;
    } else if (newStartDateSelected == null) {
      return result?.flightSegments?.first.outbound?.first.departureDateTime;
    }
    return newStartDateSelected;
  }

  DateTime? get currentEndDate {
    if (customSelected && newReturnDateSelected != null) {
      return newReturnDateSelected;
    }
    if (customSelected && newReturnDateSelected == null) {
      return null;
    } else if (newReturnDateSelected == null) {
      if (result?.flightSegments?.first.inbound?.isEmpty ?? true) {
        return null;
      }
      return result?.flightSegments?.first.inbound?.first.departureDateTime;
    }

    return newReturnDateSelected;
  }

  bool get isTwoWay {
    return result?.flightSegments?.first.inbound?.isNotEmpty ?? false;
  }

  bool get isOneWay {
    return result?.flightSegments?.first.inbound?.isEmpty ?? true;
  }

  ManageBookingResponse({
    this.result,
    this.success,
    this.message,
    this.customSelected = false,
    this.allInsuranceBundleSelected ,
  this.allInsuranceBoundSelected ,
  this.confirmedInsuranceBundleSelected ,
  this.confirmedInsuranceBoundSelected ,

});

  ManageBookingResponse.fromJson(Map<String, dynamic> json) {
    result = Result.fromJson(json);
    success = result?.success;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.toJson();
    }
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}

class Result {
  BookingContact? bookingContact;
  List<PassengersWithSSR>? passengersWithSSR;

  List<Person> get allPersonObject {

    List<Person> persons = [];

    for(PassengersWithSSR currnetItem in passengersWithSSR ?? []) {
      if(currnetItem.personObject != null) {
        persons.add(currnetItem.personObject!);

      }

    }
    return persons;

  }

  List<Passenger> get allPessengerObject {

    List<Passenger> persons = [];

    for(PassengersWithSSR currnetItem in passengersWithSSR ?? []) {
      if(currnetItem.passengers != null) {
        persons.add(currnetItem.passengers!);

      }

    }
    return persons;

  }



  List<PassengersWithSSR> get passengersWithSSRWithoutInfant {
    return passengersWithSSR
            ?.where((element) => element.isInfant == false)
            .toList() ??
        [];
  }

  Passenger? infanctWith(String givenName, String lastLame, String dob) {
    var response = passengersWithSSR?.firstWhere((element) =>
        element.passengers?.givenName == givenName ||
        element.passengers?.surname == lastLame ||
        element.passengers?.passengerType == 'INF');

    return response?.passengers;
  }

  PassengersWithSSR? infanct(String givenName, String lastLame, String dob) {
    var response = passengersWithSSR?.firstWhere((element) =>
        element.passengers?.givenName == givenName ||
        element.passengers?.surname == lastLame ||
        element.passengers?.passengerType == 'INF');

    return response;
  }

  SuperPNR? superPNR;
  SuperPNROrder? superPNROrder;
  String? message;

  List<PaymentOrder>? paymentOrders;
  FareAndBundleDetail? fareAndBundleDetail;
  SeatDetail? seatDetail;
  MealDetail? mealDetail;
  BaggageDetail? baggageDetail;
  CR.WheelChairDetail? wheelChairDetail;
  SportsEquipmentDetail? sportEquipmentDetail;
  InsuranceDetails? insuranceSSRDetail;
  List<FlightSegment>? flightSegments;
  FS.CompanyTaxInvoice? companyTaxInvoice;
  bool? isReturn;
  num? amountNeedToPay;
  bool? needPaymentFirst;

  //"amountNeedToPay": 228,
  //"needPaymentFirst": true,

  bool? success;


  bool? isRequiredPassport;

  bool get outboundCheckingAllowed {
    if (flightSegments != null) {
      if (flightSegments!.first.outbound != null) {
        if (flightSegments!.first.outbound!.first.isFullyCheckedIn == false) {
          if (flightSegments!.first.outbound!.first.isCheckInAllowed == true) {
            var departureTime =
                flightSegments!.first.outbound!.first.departureDateTime ??
                    DateTime.now().add(const Duration(minutes: 1));

            return true;

            var now = DateTime.now();

            if (DateTime.now().isBefore(departureTime)) {
              return true;
            }
            return false;
          }
        }
      }
    }
    print('');
    return false;
  }

  String toBeautify() {
    List<String> texts = [];
    int numberOfAdult = 0;
    int numberOfChildren = 0;
    int numberOfInfant = 0;

    if (numberOfAdult > 0) {
      final text =
          "($numberOfAdult) ${numberOfAdult > 1 ? 'Adults' : 'adult'.tr()}";
      texts.add(text);
    }
    if (numberOfChildren > 0) {
      final text =
          "($numberOfChildren) ${numberOfChildren > 1 ? 'Children' : 'Child'}";
      texts.add(text);
    }
    if (numberOfInfant > 0) {
      final text =
          "($numberOfInfant) ${numberOfInfant > 1 ? 'Infants' : 'Infant'}";
      texts.add(text);
    }
    final combine = texts.join(", ");
    return "$combine passenger(s)";
  }

  bool get inboundCheckingAllowed {
    if (flightSegments != null) {
      if (flightSegments!.first.inbound != null) {
        if (flightSegments!.first.inbound!.first.isFullyCheckedIn == false) {
          if (flightSegments!.first.inbound!.first.isCheckInAllowed == true) {
            var departureTime =
                flightSegments!.first.inbound!.first.departureDateTime ??
                    DateTime.now().add(const Duration(minutes: 1));

            return true;

            var now = DateTime.now();

            if (DateTime.now().isBefore(departureTime)) {
              return true;
            }
            return false;
          }
        }
      }
    }
    print('');
    return false;
  }

  String get returnDepartureAirportName {
    return flightSegments?.first.inbound?.first.departureAirportLocationName ??
        '';
  }

  String get departureAirportName {
    return flightSegments?.first.outbound?.first.departureAirportLocationName ??
        '';
  }

  String get departureAirportToDestinationName {
    return '${flightSegments?.first.outbound?.first.departureAirportLocationName ?? ''} to $arrivalAirportName -';
  }

  String get returnAirportToDestinationName {
    return '${flightSegments?.first.inbound?.first.departureAirportLocationName ?? ''} to $returnArrivalAirportName -';
  }

  String departureAirportTime(String? locale) {
    if (flightSegments?.first.outbound?.first.departureDateTime != null) {
      if (locale != null) {
        return AppDateUtils.formatHalfDate(
            flightSegments?.first.outbound?.first.departureDateTime,
            locale: locale);
      }
      return AppDateUtils.formatHalfDate(
          flightSegments?.first.outbound?.first.departureDateTime,
          locale: null);
    }
    return '';
  }

  String returnAirportTime(String? locale) {
    if (flightSegments?.first.outbound?.first.departureDateTime != null) {
      return AppDateUtils.formatHalfDate(
          flightSegments?.first.inbound?.first.departureDateTime,
          locale: locale);
    }
    return '';
    return flightSegments?.first.outbound?.first.departureDateTime.toString() ??
        '';
  }

  //

  String get arrivalAirportName {
    return flightSegments?.first.outbound?.first.arrivalAirportLocationName ??
        '';
  }

  String get journeyTimeInHourMin {
    return AppDateUtils.formatDuration(
        (flightSegments?.first.outbound?.first.duration ?? 0).toInt());
  }

  String get returnJourneyTimeInHourMin {
    return AppDateUtils.formatDuration(
        (flightSegments?.first.inbound?.first.duration ?? 0).toInt());
  }

  String get returnArrivalAirportName {
    return flightSegments?.first.inbound?.first.arrivalAirportLocationName ??
        '';
  }

  String departureDateWithTime(String? locale) {
    return AppDateUtils.formatFullDateTwoLines(
        flightSegments?.first.outbound?.first.departureDateTime,
        locale: locale);
  }

  String departureDate(String locale) {
    return AppDateUtils.formatHalfDateHalfMonth(
        flightSegments?.first.outbound?.first.departureDateTime,
        locale: locale);
  }

  String eturnDate(String locale) {
    return AppDateUtils.formatHalfDateHalfMonth(
        flightSegments?.first.inbound?.first.departureDateTime,
        locale: locale);
  }

  String arrivalDateWithTime(String? locale) {
    return AppDateUtils.formatFullDateTwoLines(
        flightSegments?.first.outbound?.first.arrivalDateTime,
        locale: locale);
  }

  String returnArrivalDateWithTime(String? locale) {
    return AppDateUtils.formatFullDateTwoLines(
        flightSegments?.first.inbound?.first.arrivalDateTime,
        locale: locale);
  }

  String returnDepartureDateWithTime(String? locale) {
    return AppDateUtils.formatFullDateTwoLines(
        flightSegments?.first.inbound?.first.departureDateTime,
        locale: locale);
  }

  String departureDateToShow(String? locale) {
    if (locale != null) {
      return AppDateUtils.formatHalfDateHalfMonth(
          flightSegments?.first.outbound?.first.departureDateTime,
          locale: locale);
    }
    return AppDateUtils.formatHalfDateHalfMonth(
        flightSegments?.first.outbound?.first.departureDateTime,
        locale: null);
  }

  String returnDepartureDateToShow(String? local) {
    return AppDateUtils.formatFullDate(
        flightSegments?.first.inbound?.first.departureDateTime,
        locale: local);
  }

  String get departureToDestinationCode {
    return '${flightSegments?.first.outbound?.first.departureAirportLocationCode ?? ''} ${'to'.tr()} ${flightSegments?.first.outbound?.first.arrivalAirportLocationCode ?? ''}';
  }

  String get departureToDestinationCodeDash {
    return '${flightSegments?.first.outbound?.first.departureAirportLocationCode ?? ''}${'—'.tr()}${flightSegments?.first.outbound?.first.arrivalAirportLocationCode ?? ''}';
  }


  String get returnToDestinationCode {
    return '${flightSegments?.first.inbound?.first.departureAirportLocationCode ?? ''} ${'to'.tr()} ${flightSegments?.first.inbound?.first.arrivalAirportLocationCode ?? ''}';
  }

  String get returnToDestinationCodeDash {
    return '${flightSegments?.first.inbound?.first.departureAirportLocationCode ?? ''}-${'to'.tr()}-${flightSegments?.first.inbound?.first.arrivalAirportLocationCode ?? ''}';
  }


  String get fromToDestinationName {
    return '${flightSegments?.first.inbound?.first.departureAirportLocationName ?? ''} ${'to'.tr()} ${flightSegments?.first.outbound?.first.arrivalAirportLocationName ?? ''}';
  }

  Result copyWith(
      {BookingContact? bookingContact,
      List<PassengersWithSSR>? passengersWithSSR,
      List<PaymentOrder>? paymentOrders,
      FareAndBundleDetail? fareAndBundleDetail,
      SeatDetail? seatDetail,
      MealDetail? mealDetail,
      BaggageDetail? baggageDetail,
        CR.WheelChairDetail? wheelChairDetail,
      SportsEquipmentDetail? sportEquipmentDetail,
      InsuranceDetails? insuranceSSRDetail,
      List<FlightSegment>? flightSegments,
        FS.CompanyTaxInvoice? companyTaxInvoice,
      bool? isReturn,
        String? message,
        num? amountNeedToPay,
        bool? needPaymentFirst,
        bool? success}) {
    return Result(
      bookingContact: bookingContact ?? this.bookingContact,
      message: message ?? this.message,
      needPaymentFirst: needPaymentFirst ?? this.needPaymentFirst,
      amountNeedToPay: amountNeedToPay ?? this.amountNeedToPay,
      passengersWithSSR: passengersWithSSR ?? this.passengersWithSSR,
      paymentOrders: paymentOrders ?? this.paymentOrders,
      fareAndBundleDetail: fareAndBundleDetail ?? this.fareAndBundleDetail,
      seatDetail: seatDetail ?? this.seatDetail,
      mealDetail: mealDetail ?? this.mealDetail,
      baggageDetail: baggageDetail ?? this.baggageDetail,
      wheelChairDetail: wheelChairDetail ?? this.wheelChairDetail,
      sportEquipmentDetail: sportEquipmentDetail ?? this.sportEquipmentDetail,
      insuranceSSRDetail: insuranceSSRDetail ?? this.insuranceSSRDetail,
      flightSegments: flightSegments ?? this.flightSegments,
      companyTaxInvoice: companyTaxInvoice ?? this.companyTaxInvoice,
      isReturn: isReturn ?? this.isReturn,
    );
  }

  Result(
      {this.bookingContact,
      this.passengersWithSSR,
      this.paymentOrders,
      this.fareAndBundleDetail,
      this.seatDetail,
      this.mealDetail,
      this.baggageDetail,
      this.wheelChairDetail,
      this.sportEquipmentDetail,
      this.insuranceSSRDetail,
      this.flightSegments,
      this.companyTaxInvoice,
      this.isReturn,
        this.amountNeedToPay ,
  this.needPaymentFirst ,
        this.message,
      this.success});

  bool initalEmergencyEmpty = false;

  num? superPNRID;
  String? superPNRNo = '';

  Result.fromJson(Map<String, dynamic> json) {
     superPNR =
        json['superPNR'] != null ? SuperPNR.fromJson(json['superPNR']) : null;

     if(superPNR != null) {
       if(superPNR?.superPNRID != null) {
         superPNRID = superPNR?.superPNRID;
       }
       if(superPNR?.superPNRNo != null) {
         superPNRNo = superPNR?.superPNRNo;
       }

     }
    superPNROrder = json['superPNROrder'] != null
        ? SuperPNROrder.fromJson(json['superPNROrder'])
        : null;

    bookingContact = json['bookingContact'] != null
        ? BookingContact.fromJson(json['bookingContact'])
        : null;
    if((bookingContact?.emergencyGivenName ?? '').isEmpty == true && (bookingContact?.emergencySurname ?? '').isEmpty == true && (bookingContact?.emergencyPhone ?? '').isEmpty == true){
      initalEmergencyEmpty = true;

    }

    if (json['passengersWithSSR'] != null) {
      passengersWithSSR = <PassengersWithSSR>[];

      json['passengersWithSSR'].forEach((v) {
        passengersWithSSR!.add(PassengersWithSSR.fromJson(v));
      });
    }
    if (json['paymentOrders'] != null) {
      paymentOrders = <PaymentOrder>[];
      json['paymentOrders'].forEach((v) {
        paymentOrders!.add(PaymentOrder.fromJson(v));
      });
    }
    fareAndBundleDetail = json['fareAndBundleDetail'] != null
        ? FareAndBundleDetail.fromJson(json['fareAndBundleDetail'])
        : null;
    seatDetail = json['seatDetail'] != null
        ? SeatDetail.fromJson(json['seatDetail'])
        : null;
    mealDetail = json['mealDetail'] != null
        ? MealDetail.fromJson(json['mealDetail'])
        : null;
    baggageDetail = json['baggageDetail'] != null
        ? BaggageDetail.fromJson(json['baggageDetail'])
        : null;
    wheelChairDetail = json['wheelChairDetail'] != null
        ? CR.WheelChairDetail.fromJson(json['wheelChairDetail'])
        : null;
    sportEquipmentDetail = json['sportEquipmentDetail'] != null
        ? SportsEquipmentDetail.fromJson(json['sportEquipmentDetail'])
        : null;
    insuranceSSRDetail = json['insuranceSSRDetail'] != null
        ? InsuranceDetails.fromJson(json['insuranceSSRDetail'])
        : null;
    if (json['flightSegments'] != null) {
      flightSegments = <FlightSegment>[];
      json['flightSegments'].forEach((v) {
        flightSegments!.add(FlightSegment.fromJson(v));
      });
    }
    companyTaxInvoice = json['companyTaxInvoice'] != null
        ? FS.CompanyTaxInvoice.fromJson(json['companyTaxInvoice'])
        : null;
    isReturn = json['isReturn'];
     needPaymentFirst = json['needPaymentFirst'];
     amountNeedToPay = json['amountNeedToPay'];

     isRequiredPassport = json['isRequiredPassport'];

     message = json['message'];

    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bookingContact != null) {
      data['bookingContact'] = bookingContact!.toJson();
    }
    if (passengersWithSSR != null) {
      data['passengersWithSSR'] =
          passengersWithSSR!.map((v) => v.toJson()).toList();
    }
    if (paymentOrders != null) {
      data['paymentOrders'] = paymentOrders!.map((v) => v.toJson()).toList();
    }
    if (fareAndBundleDetail != null) {
      data['fareAndBundleDetail'] = fareAndBundleDetail!.toJson();
    }
    if (seatDetail != null) {
      data['seatDetail'] = seatDetail!.toJson();
    }
    if (mealDetail != null) {
      data['mealDetail'] = mealDetail!.toJson();
    }
    if (baggageDetail != null) {
      data['baggageDetail'] = baggageDetail!.toJson();
    }
    if (wheelChairDetail != null) {
      //data['wheelChairDetail'] = wheelChairDetail!.toJson();
    }
    if (sportEquipmentDetail != null) {
      data['sportEquipmentDetail'] = sportEquipmentDetail!.toJson();
    }
    if (insuranceSSRDetail != null) {
      data['insuranceSSRDetail'] = insuranceSSRDetail!.toJson();
    }
    if (flightSegments != null) {
      data['flightSegments'] = flightSegments!.map((v) => v.toJson()).toList();
    }
    if (companyTaxInvoice != null) {
      data['companyTaxInvoice'] = companyTaxInvoice!.toJson();
    }
    data['isReturn'] = isReturn;

    data['success'] = success;
    return data;
  }
}

class PassengersWithSSR {

  num getPersonSeatPrice(bool isDepart) {
    if(seatDetail != null) {
      if((seatDetail?.seats ?? []).isNotEmpty ) {

        if(isDepart) {
          if((seatDetail?.departureSeat ?? []).isNotEmpty ) {
            return (seatDetail?.departureSeat ?? []).first.amount ?? 0.0;

          }
        }


        if((seatDetail?.returnSeat ?? []).isNotEmpty ) {
          return (seatDetail?.returnSeat ?? []).first.amount ?? 0.0;

        }
      }
    }

    return 0.0;

  }
  Vs.Seats? newDepartSeatSelected;
  Vs.Seats? newReturnSeatSelected;

  Vs.Seats? confirmedDepartSeatSelected;
  Vs.Seats? confirmedReturnSeatSelected;



  Bundle? newInsuranceBundleSelected;
  FS.Bound? newInsuranceBoundSelected;
  Bundle? confirmedInsuranceBundleSelected;
  FS.Bound? confirmedInsuranceBoundSelected;





  String? originalDepartSeatId;
  String? originalReturnSeatId;

   List<Bundle>? newDepartureMeal;
   List<Bundle>? newReturnMeal;

  List<Bundle>? confirmedDepartMeals;
  List<Bundle>? confirmedReturnMeals;

   Bundle? newDepartBaggageSelected;
  Bundle? newReturnBaggageSelected;
  Bundle? confirmDepartBaggageSelected;
  Bundle? confirmReturnBaggageSelected;


  Bundle? newDepartSportsSelected;
  Bundle? newReturnSportsSelected;

  Bundle? confirmedDepartSportsSelected;
  Bundle? confirmedReturnSportsSelected;



  Bundle? newReturnWheelChair;
  Bundle? newDepartWheelChair;

  Bundle? confirmReturnWheelChair;
  Bundle? confirmDepartWheelChair;

  bool originalHadWheelChairDepart = false;
  bool originalHadWheelChairReturn = false;


  num? originalDepartSeatPrice;
  num? originalReturnSeatPrice;



  String? wheelChairIdDepart;
  String? wheelChairIdReturn;


  String? originalDepartBaggageCode;
  String? originalReturnBaggageCode;

  double? originalDepartBaggagePrice;
  double? originalReturnBaggagePrice;


  String? originalDepartSportsCode;
  String? originalReturnSportsCode;
  double? originalDepartSportsPrice;
  double? originalReturnSportsPrice;

  //Bundle? baggage


  FS.Bound? get getInsurance {

    /*if(ssr != null) {
      if(ssr!.outbound != null && ssr!.outbound!.isNotEmpty) {
        var outBound = ssr!.outbound!;
        var object = outBound.where((e) => e.servicesType == 'Insurance').toList();
        if(object.isNotEmpty){
          return object.first;
        }
        return null;
      }
    }*/


    return null;
  }

  Bundle? get getInsurance2 {


    /*if(ssr != null) {
      if(ssr!.outbound != null && ssr!.outbound!.isNotEmpty) {
        var outBound = ssr!.outbound!;
        var object = outBound.where((e) => e.servicesType == 'Insurance').toList();
        if(object.isNotEmpty){
          return object.first;
        }
        return null;
      }
    }*/


    return null;
  }


  String toBeautify() {
    List<String> texts = [];
    int numberOfAdult = 0;
    int numberOfChildren = 0;
    int numberOfInfant = 0;

    if (numberOfAdult > 0) {
      final text =
          "($numberOfAdult) ${numberOfAdult > 1 ? 'Adults' : 'adult'.tr()}";
      texts.add(text);
    }
    if (numberOfChildren > 0) {
      final text =
          "($numberOfChildren) ${numberOfChildren > 1 ? 'Children' : 'Child'}";
      texts.add(text);
    }
    if (numberOfInfant > 0) {
      final text =
          "($numberOfInfant) ${numberOfInfant > 1 ? 'Infants' : 'Infant'}";
      texts.add(text);
    }
    final combine = texts.join(", ");
    return "$combine passenger(s)";
  }

  String? personOrgID;



  Passenger? passengers;

  Person? personObject;

  Seats? previousDepartureSeats;
  Seats? previousReturnSeats;
  Bundle? previousDepartureBaggage;
  Bundle? previousReturnBaggage;
  Bundle? previousDepartureSports;
  Bundle? previousReturnSports;
  Bundle? previousDepartureWheelChair;
  Bundle? previousReturnWheelChair;


  FareAndBundleDetail? fareAndBundleDetail;
  SeatDetail? seatDetail;
  MealDetail? mealDetail;
  BaggageDetail? baggageDetail;
  CR.WheelChairDetail? wheelChairDetail;
  SportsEquipmentDetail? sportEquipmentDetail;
  InsuranceDetails? insuranceSSRDetail;
  CheckInStatusInOut? checkInStatusInOut;

  String? checkInMemberID;
  String? checkInPassportNo;

  String? passportCountry;
  String? passExpdate;
  String? passPortdob;

  bool? haveInfant;

  bool? paxSelected;

  String? infantGivenName;
  String? infantSurname;
  String? infantDob;
  String? infantNationality;

  bool? infantExpanded;

  bool get isInfant {
    return passengers?.passengerType == 'INF';
  }

  PassengersWithSSR copyWith({
    String? personOrgID,
    Passenger? passengers,
    FareAndBundleDetail? fareAndBundleDetail,
    SeatDetail? seatDetail,
    MealDetail? mealDetail,
    BaggageDetail? baggageDetail,
    CR.WheelChairDetail? wheelChairDetail,
    SportsEquipmentDetail? sportEquipmentDetail,
    InsuranceDetails? insuranceSSRDetail,
    CheckInStatusInOut? checkInStatusInOut,
    String? checkInMemberID,
    String? checkInPassportNo,
    String? passportCountry,
    String? passExpdate,
    String? passPortdob,
    bool? haveInfant,
    bool? paxSelected,
    String? infantGivenName,
    String? infantSurname,
    String? infantDob,
    String? infantNationality,
    bool? infantExpanded,
    Person? personObject,
    String? originalDepartSeatId,
  String? originalReturnSeatId,
    Vs.Seats? newDepartSeatSelected,
    Vs.Seats? newReturnSeatSelected,
    Vs.Seats? confirmedDepartSeatSelected,
    Vs.Seats? confirmedSeatSelected,
    double? originalDepartSeatPrice,
    double? originalReturnSeatPrice,
    List<Bundle>? newDepartureMeal,
    List<Bundle>? newReturnMeal,
    Bundle? newDepartBaggageSelected,
    String? originalDepartBaggageCode,
    String? originalReturnBaggageCode,
    double? originalDepartBaggagePrice,
    double? originalReturnBaggagePrice,
    Bundle? newReturnBaggageSelected,
    Bundle? newDepartSportsSelected,
    Bundle? newReturnSportsSelected,
    String? originalDepartSportsCode,
    String? originalReturnSportsCode,
    double? originalDepartSportsPrice,
    double? originalReturnSportsPrice,
    bool? originalHadWheelChairDepart,
    bool? originalHadWheelChairReturn,
    Bundle? newReturnWheelChair,
    Bundle? newDepartWheelChair,
    String? wheelChairIdDepart,
    String? wheelChairIdReturn,
    List<Bundle>? confirmedDepartMeals,
    List<Bundle>? confirmedReturnMeals,
    Bundle? confirmDepartBaggageSelected,
    Bundle? confirmReturnBaggageSelected,

    Bundle? newInsuranceBundleSelected,
    FS.Bound? newInsuranceBoundSelected,
    Bundle? confirmedInsuranceBundleSelected,
    FS.Bound? confirmedInsuranceBoundSelected,
    Bundle? confirmedDepartSportsSelected,
    Bundle? confirmedReturnSportsSelected,

    Seats? previousDepartureSeats,
    Seats? previousReturnSeats,
    Bundle? previousDepartureBaggage,
    Bundle? previousReturnBaggage,
    Bundle? previousDepartureSports,
    Bundle? previousReturnSports,
    Bundle? previousDepartureWheelChair,
    Bundle? previousReturnWheelChair,

    Bundle? confirmReturnWheelChair,
    Bundle? confirmDepartWheelChair,


  }) {
    return PassengersWithSSR(
      confirmReturnWheelChair  : confirmReturnWheelChair  ?? this.confirmReturnWheelChair,
      confirmDepartWheelChair :   confirmDepartWheelChair ?? this.confirmDepartWheelChair,
      previousDepartureSeats : previousDepartureSeats  ?? this.previousDepartureSeats,
      previousReturnSeats :  previousReturnSeats ?? this.previousReturnSeats,
      previousDepartureBaggage : previousDepartureBaggage  ?? this.previousDepartureBaggage,
      previousReturnBaggage :   previousReturnBaggage ?? this.previousReturnBaggage,
      previousDepartureSports  :  previousDepartureSports ?? this.previousDepartureSports,
      previousReturnSports  :  previousReturnSports ?? this.previousReturnSports,
      previousDepartureWheelChair :   previousDepartureWheelChair ?? this.previousDepartureWheelChair,
      previousReturnWheelChair :   previousReturnWheelChair ?? this.previousReturnWheelChair,

seatDetail: seatDetail ?? this.seatDetail,
    confirmedDepartSportsSelected :  confirmedDepartSportsSelected ?? this.confirmedDepartSportsSelected,
      confirmedReturnSportsSelected :  confirmedReturnSportsSelected ?? this.confirmedReturnSportsSelected,
      newInsuranceBundleSelected :  newInsuranceBundleSelected ?? this.newInsuranceBundleSelected,
      newInsuranceBoundSelected :   newInsuranceBoundSelected ?? this.newInsuranceBoundSelected,
      confirmedInsuranceBundleSelected : confirmedInsuranceBundleSelected  ?? this.confirmedInsuranceBundleSelected,
      confirmedInsuranceBoundSelected :   confirmedInsuranceBoundSelected ?? this.confirmedInsuranceBoundSelected,
    confirmDepartBaggageSelected  : confirmDepartBaggageSelected  ?? this.confirmDepartBaggageSelected,
      confirmReturnBaggageSelected :  confirmReturnBaggageSelected ?? this.confirmReturnBaggageSelected,
      confirmedDepartMeals :  confirmedDepartMeals ?? this.confirmedDepartMeals,
      confirmedReturnMeals :  confirmedReturnMeals ?? this.confirmedReturnMeals,
      confirmedDepartSeatSelected :  confirmedDepartSeatSelected ?? this.confirmedDepartSeatSelected,
      confirmedReturnSeatSelected :  confirmedSeatSelected ?? confirmedReturnSeatSelected,
      wheelChairIdDepart :  wheelChairIdDepart ?? this.wheelChairIdDepart,
      wheelChairIdReturn :  wheelChairIdReturn ?? this.wheelChairIdReturn,
      originalHadWheelChairDepart :  originalHadWheelChairDepart ?? this.originalHadWheelChairDepart,
      originalHadWheelChairReturn :  originalHadWheelChairReturn ?? this.originalHadWheelChairReturn,
      newReturnWheelChair :  newReturnWheelChair ?? this.newReturnWheelChair,
      newDepartWheelChair :  newDepartWheelChair ?? this.newDepartWheelChair,
      newDepartSportsSelected :  newDepartSportsSelected ?? this.newDepartSportsSelected,
      newReturnSportsSelected :  newReturnSportsSelected ?? this.newReturnSportsSelected,
      originalDepartSportsCode : originalDepartSportsCode ?? this.originalDepartSportsCode,
      originalReturnSportsCode  : originalReturnSportsCode ?? this.originalReturnSportsCode,
      originalDepartSportsPrice  : originalDepartSportsPrice ?? this.originalDepartSportsPrice,
      originalReturnSportsPrice : originalReturnSportsPrice ?? this.originalReturnSportsPrice,
      newReturnBaggageSelected : newReturnBaggageSelected ?? this.newReturnBaggageSelected,
      originalDepartBaggagePrice :  originalDepartBaggagePrice ?? this.originalDepartBaggagePrice,
      originalReturnBaggagePrice :   originalReturnBaggagePrice ?? this.originalReturnBaggagePrice,
      originalDepartBaggageCode :  originalDepartBaggageCode ?? this.originalDepartBaggageCode,
      originalReturnBaggageCode :  originalReturnBaggageCode ?? this.originalReturnBaggageCode,
      newDepartureMeal :  newDepartureMeal ?? this.newDepartureMeal,
      newDepartBaggageSelected :  newDepartBaggageSelected ?? this.newDepartBaggageSelected,
      newReturnMeal : newReturnMeal ?? this.newReturnMeal,
      originalDepartSeatPrice :  originalDepartSeatPrice ?? this.originalDepartSeatPrice,
      originalReturnSeatPrice : originalReturnSeatPrice ?? this.originalReturnSeatPrice,
      personOrgID: personOrgID ?? this.personOrgID,
      newDepartSeatSelected: newDepartSeatSelected ?? this.newDepartSeatSelected,
      newReturnSeatSelected: newReturnSeatSelected ?? this.newReturnSeatSelected,
      originalReturnSeatId: originalReturnSeatId ?? this.originalReturnSeatId,
      originalDepartSeatId: originalDepartSeatId ?? this.originalDepartSeatId,
        passengers: passengers ?? this.passengers,
        fareAndBundleDetail: fareAndBundleDetail ?? this.fareAndBundleDetail,
        mealDetail: mealDetail ?? this.mealDetail,
        personObject: personObject ?? this.personObject,
        baggageDetail: baggageDetail ?? this.baggageDetail,
        wheelChairDetail: wheelChairDetail ?? this.wheelChairDetail,
        sportEquipmentDetail: sportEquipmentDetail ?? this.sportEquipmentDetail,
        insuranceSSRDetail: insuranceSSRDetail ?? this.insuranceSSRDetail,
        checkInStatusInOut: checkInStatusInOut ?? this.checkInStatusInOut,
        checkInMemberID: checkInMemberID ?? this.checkInMemberID,
        checkInPassportNo: checkInPassportNo ?? this.checkInPassportNo,
        passportCountry: passportCountry ?? this.passportCountry,
        passExpdate: passExpdate ?? this.passExpdate,
        passPortdob: passPortdob ?? this.passPortdob,
        haveInfant: haveInfant ?? this.haveInfant,
        paxSelected: paxSelected ?? this.paxSelected,
        infantGivenName: infantGivenName ?? this.infantGivenName,
        infantSurname: infantSurname ?? this.infantSurname,
        infantDob: infantDob ?? this.infantDob,
        infantNationality: infantNationality ?? this.infantNationality,
        infantExpanded: infantExpanded ?? this.infantExpanded,

    );
  }

  PassengersWithSSR({
    this.personOrgID,
    this.passengers,
    this.fareAndBundleDetail,
    this.seatDetail,
    this.mealDetail,
    this.personObject,
    this.checkInStatusInOut,
    this.paxSelected = false,
    this.baggageDetail,
    this.wheelChairDetail,
    this.sportEquipmentDetail,
    this.insuranceSSRDetail,
    this.haveInfant,
    this.checkInPassportNo,
    this.passportCountry,
    this.passExpdate,
    this.passPortdob,
    this.checkInMemberID,
    this.infantExpanded = false,
    this.infantGivenName,
    this.infantSurname,
    this.infantDob,
    this.infantNationality,
    this.newDepartSeatSelected,
    this.originalDepartSeatId,
    this.originalReturnSeatId,
    this.newReturnSeatSelected,
    this.originalDepartSeatPrice,
    this.originalReturnSeatPrice,
    this.newDepartureMeal,
    this.newReturnMeal,
    this.newDepartBaggageSelected,
    this.originalDepartBaggageCode,
    this.originalReturnBaggageCode,
    this.originalDepartBaggagePrice,
    this.originalReturnBaggagePrice,
    this.newReturnBaggageSelected,
    this.newDepartSportsSelected,
    this.newReturnSportsSelected,
    this.originalDepartSportsCode,
    this.originalReturnSportsCode,
    this.originalDepartSportsPrice,
    this.originalReturnSportsPrice,
    this.originalHadWheelChairDepart = false,
    this.originalHadWheelChairReturn = false,
    this.newReturnWheelChair,
    this.newDepartWheelChair,
    this.wheelChairIdDepart,
    this.wheelChairIdReturn,
   this.confirmedDepartSeatSelected,
    this.confirmedReturnSeatSelected,
    this.confirmedDepartMeals,
    this.confirmedReturnMeals,
    this.confirmDepartBaggageSelected,
    this.confirmReturnBaggageSelected,
    this.newInsuranceBundleSelected,
    this.newInsuranceBoundSelected,
    this.confirmedInsuranceBundleSelected,
    this.confirmedInsuranceBoundSelected,
    this.confirmedDepartSportsSelected,
    this.confirmedReturnSportsSelected,
    this.previousDepartureSeats,
    this.previousReturnSeats,
    this.previousDepartureBaggage,
    this.previousReturnBaggage,
    this.previousDepartureSports,
    this.previousReturnSports,
    this.previousDepartureWheelChair,
    this.previousReturnWheelChair,
    this.confirmReturnWheelChair,
    this.confirmDepartWheelChair,

  });

  PassengersWithSSR.fromJson(Map<String, dynamic> json) {
    personOrgID = json['personOrgID'];
    haveInfant = json['haveInfant'];

    if (haveInfant == true) {
      if (json['haveInfant'] != null) {
        infantGivenName = json['infantPassengerDetail']['givenName'];
        infantSurname = json['infantPassengerDetail']['surname'];
        infantDob = json['infantPassengerDetail']['dob'];
        infantNationality = json['infantPassengerDetail']['nationality'];
      }
    }

    passengers = json['passengers'] != null
        ? Passenger.fromJson(json['passengers'])
        : null;
    fareAndBundleDetail = json['fareAndBundleDetail'] != null
        ? FareAndBundleDetail.fromJson(json['fareAndBundleDetail'])
        : null;
    checkInStatusInOut = json['checkInStatusInOut'] != null
        ? CheckInStatusInOut.fromJson(json['checkInStatusInOut'])
        : null;
    seatDetail = json['seatDetail'] != null
        ? SeatDetail.fromJson(json['seatDetail'])
        : null;
    mealDetail = json['mealDetail'] != null
        ? MealDetail.fromJson(json['mealDetail'])
        : null;
    baggageDetail = json['baggageDetail'] != null
        ? BaggageDetail.fromJson(json['baggageDetail'])
        : null;
    wheelChairDetail = json['wheelChairDetail'] != null
        ? CR.WheelChairDetail.fromJson(json['wheelChairDetail'])
        : null;
    sportEquipmentDetail = json['sportEquipmentDetail'] != null
        ? SportsEquipmentDetail.fromJson(json['sportEquipmentDetail'])
        : null;
    insuranceSSRDetail = json['insuranceSSRDetail'] != null
        ? InsuranceDetails.fromJson(json['insuranceSSRDetail'])
        : null;


    PeopleType personType = PeopleType.adult;

    if(passengers?.passengerType == 'INF'){
      personType =  PeopleType.infant;
    }
    else if(passengers?.passengerType == 'CHD') {
      personType =  PeopleType.child;
    }



  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['personOrgID'] = personOrgID;
    if (passengers != null) {
      data['passengers'] = passengers!.toJson();
    }
    if (fareAndBundleDetail != null) {
      data['fareAndBundleDetail'] = fareAndBundleDetail!.toJson();
    }
    if (seatDetail != null) {
      data['seatDetail'] = seatDetail!.toJson();
    }
    if (mealDetail != null) {
      data['mealDetail'] = mealDetail!.toJson();
    }
    if (baggageDetail != null) {
      data['baggageDetail'] = baggageDetail!.toJson();
    }
    if (wheelChairDetail != null) {
     // data['wheelChairDetail'] = wheelChairDetail!.toJson();
    }
    if (sportEquipmentDetail != null) {
      data['sportEquipmentDetail'] = sportEquipmentDetail!.toJson();
    }
    if (insuranceSSRDetail != null) {
      data['insuranceSSRDetail'] = insuranceSSRDetail!.toJson();
    }
    return data;
  }
}

class CheckInStatusInOut {
  CheckInStatus? outboundCheckInStatus;
  CheckInStatus? inboundCheckInStatus;

  CheckInStatusInOut({this.outboundCheckInStatus, this.inboundCheckInStatus});

  CheckInStatusInOut.fromJson(Map<String, dynamic> json) {
    outboundCheckInStatus = json['outboundCheckInStatus'] != null
        ? CheckInStatus.fromJson(json['outboundCheckInStatus'])
        : null;
    inboundCheckInStatus = json['inboundCheckInStatus'] != null
        ? CheckInStatus.fromJson(json['inboundCheckInStatus'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (outboundCheckInStatus != null) {
      data['outboundCheckInStatus'] = outboundCheckInStatus!.toJson();
    }
    if (inboundCheckInStatus != null) {
      data['inboundCheckInStatus'] = inboundCheckInStatus!.toJson();
    }
    return data;
  }


  CheckInStatusInOut copyWith({
    CheckInStatus? outboundCheckInStatus,
    CheckInStatus? inboundCheckInStatus,
  }) {
    return CheckInStatusInOut(
      outboundCheckInStatus: outboundCheckInStatus ?? this.outboundCheckInStatus,
      inboundCheckInStatus: inboundCheckInStatus ?? this.inboundCheckInStatus,
    );
  }

}

class CheckInStatus {
  bool? allowCheckIn;

  String? flightNumber;
  String? departureStationCode;
  String? inkPaxID;
  String? checkInStatus;

  CheckInStatus({this.allowCheckIn,this.flightNumber,this.departureStationCode,this.inkPaxID,this.checkInStatus});

  CheckInStatus.fromJson(Map<String, dynamic> json) {
    allowCheckIn = json['allowCheckIn'];
    flightNumber = json['flightNumber'];
    departureStationCode = json['departureStationCode'];
    inkPaxID = json['inkPaxID'];
    checkInStatus = json['checkInStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['allowCheckIn'] = allowCheckIn;
    data['flightNumber'] = flightNumber;
    data['departureStationCode'] = departureStationCode;
    data['inkPaxID'] = inkPaxID;
    data['checkInStatus'] = checkInStatus;

    return data;
  }

  CheckInStatus copyWith({
    bool? allowCheckIn,
    String? flightNumber,
    String? departureStationCode,
    String? inkPaxID,
    String? checkInStatus,
  }) {
    return CheckInStatus(
      allowCheckIn: allowCheckIn ?? this.allowCheckIn,
      flightNumber: flightNumber ?? this.flightNumber,
      departureStationCode: departureStationCode ?? this.departureStationCode,
      inkPaxID: inkPaxID ?? this.inkPaxID,
      checkInStatus: checkInStatus ?? this.checkInStatus,
    );
  }

}

/*
class CompanyTaxInvoice {
  num? superPNRID;
  String? companyName;
  String? companyAddress;
  String? country;
  String? state;
  String? city;
  String? postCode;
  String? emailAddress;
  bool? isTaxInvoiceSent;
  String? lastGeneratedDate;
  num? createdByID;
  String? createdDate;
  String? createdDateUTC;
  num? modifiedByID;
  String? modifiedDate;
  String? modifiedDateUTC;

  CompanyTaxInvoice(
      {this.superPNRID,
      this.companyName,
      this.companyAddress,
      this.country,
      this.state,
      this.city,
      this.postCode,
      this.emailAddress,
      this.isTaxInvoiceSent,
      this.lastGeneratedDate,
      this.createdByID,
      this.createdDate,
      this.createdDateUTC,
      this.modifiedByID,
      this.modifiedDate,
      this.modifiedDateUTC});

  CompanyTaxInvoice copyWith({
    num? superPNRID,
    String? companyName,
    String? companyAddress,
    String? country,
    String? state,
    String? city,
    String? postCode,
    String? emailAddress,
    bool? isTaxInvoiceSent,
    String? lastGeneratedDate,
    num? createdByID,
    String? createdDate,
    String? createdDateUTC,
    num? modifiedByID,
    String? modifiedDate,
    String? modifiedDateUTC,
  }) {
    return CompanyTaxInvoice(
      superPNRID: superPNRID ?? this.superPNRID,
      companyName: companyName ?? this.companyName,
      companyAddress: companyAddress ?? this.companyAddress,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      postCode: postCode ?? this.postCode,
      emailAddress: emailAddress ?? this.emailAddress,
      isTaxInvoiceSent: isTaxInvoiceSent ?? this.isTaxInvoiceSent,
      lastGeneratedDate: lastGeneratedDate ?? this.lastGeneratedDate,
      createdByID: createdByID ?? this.createdByID,
      createdDate: createdDate ?? this.createdDate,
      createdDateUTC: createdDateUTC ?? this.createdDateUTC,
      modifiedByID: modifiedByID ?? this.modifiedByID,
      modifiedDate: modifiedDate ?? this.modifiedDate,
      modifiedDateUTC: modifiedDateUTC ?? this.modifiedDateUTC,
    );
  }


  CompanyTaxInvoice.fromJson(Map<String, dynamic> json) {
    superPNRID = json['superPNRID'];
    companyName = json['companyName'];
    companyAddress = json['companyAddress'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    postCode = json['postCode'];
    emailAddress = json['emailAddress'];
    isTaxInvoiceSent = json['isTaxInvoiceSent'];
    lastGeneratedDate = json['lastGeneratedDate'];
    createdByID = json['createdByID'];
    createdDate = json['createdDate'];
    createdDateUTC = json['createdDateUTC'];
    modifiedByID = json['modifiedByID'];
    modifiedDate = json['modifiedDate'];
    modifiedDateUTC = json['modifiedDateUTC'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['superPNRID'] = superPNRID;
    data['companyName'] = companyName;
    data['companyAddress'] = companyAddress;
    data['country'] = country;
    data['state'] = state;
    data['city'] = city;
    data['postCode'] = postCode;
    data['emailAddress'] = emailAddress;
    data['isTaxInvoiceSent'] = isTaxInvoiceSent;
    data['lastGeneratedDate'] = lastGeneratedDate;
    data['createdByID'] = createdByID;
    data['createdDate'] = createdDate;
    data['createdDateUTC'] = createdDateUTC;
    data['modifiedByID'] = modifiedByID;
    data['modifiedDate'] = modifiedDate;
    data['modifiedDateUTC'] = modifiedDateUTC;
    return data;
  }
}
*/

