import 'package:easy_localization/easy_localization.dart';

import '../../models/confirmation_model.dart';
import '../../utils/date_utils.dart';

class ManageBookingResponse {
  Result? result;
  bool? success;
  String? message;

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

  ManageBookingResponse({this.result, this.success, this.message});

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

  Passenger? infanctWith(String givenName, String lastLame, String dob) {
   var response = passengersWithSSR?.firstWhere((element) =>
        element.passengers?.givenName == givenName ||
        element.passengers?.surname == lastLame || element.passengers?.passengerType == 'INF');

    return response?.passengers;
  }

  PassengersWithSSR? infanct(String givenName, String lastLame, String dob) {
    var response = passengersWithSSR?.firstWhere((element) =>
    element.passengers?.givenName == givenName ||
        element.passengers?.surname == lastLame || element.passengers?.passengerType == 'INF');

    return response;
  }

  SuperPNR? superPNR;
  SuperPNROrder? superPNROrder;
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

  List<PaymentOrder>? paymentOrders;
  FareAndBundleDetail? fareAndBundleDetail;
  SeatDetail? seatDetail;
  MealDetail? mealDetail;
  BaggageDetail? baggageDetail;
  WheelChairDetail? wheelChairDetail;
  SportsEquipmentDetail? sportEquipmentDetail;
  InsuranceDetails? insuranceSSRDetail;
  List<FlightSegment>? flightSegments;
  CompanyTaxInvoice? companyTaxInvoice;
  bool? isReturn;
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

  String  departureAirportTime(String? locale) {
    if (flightSegments?.first.outbound?.first.departureDateTime != null) {
      if(locale != null) {
        return AppDateUtils.formatHalfDate(
            flightSegments?.first.outbound?.first.departureDateTime,locale: locale);
      }
      return AppDateUtils.formatHalfDate(
          flightSegments?.first.outbound?.first.departureDateTime);
    }
    return '';

  }

  String returnAirportTime(String? locale) {
    if (flightSegments?.first.outbound?.first.departureDateTime != null) {
      return AppDateUtils.formatHalfDate(
          flightSegments?.first.inbound?.first.departureDateTime,locale: locale);
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

  String  departureDateWithTime(String? locale) {
    return AppDateUtils.formatFullDateTwoLines(
        flightSegments?.first.outbound?.first.departureDateTime,locale: locale);
  }

  String get departureDate {
    return AppDateUtils.formatHalfDateHalfMonth(
        flightSegments?.first.outbound?.first.departureDateTime);
  }

  String get returnDate {
    return AppDateUtils.formatHalfDateHalfMonth(
        flightSegments?.first.inbound?.first.departureDateTime);
  }

  String  arrivalDateWithTime(String? locale) {
    return AppDateUtils.formatFullDateTwoLines(
        flightSegments?.first.outbound?.first.arrivalDateTime,locale: locale);
  }

  String  returnArrivalDateWithTime(String? locale) {
    return AppDateUtils.formatFullDateTwoLines(
        flightSegments?.first.inbound?.first.arrivalDateTime,locale: locale);
  }

  String  returnDepartureDateWithTime(String? locale) {
    return AppDateUtils.formatFullDateTwoLines(
        flightSegments?.first.inbound?.first.departureDateTime,locale: locale);
  }

  String  departureDateToShow(String? locale) {
    if(locale != null) {
      return AppDateUtils.formatHalfDateHalfMonth(
          flightSegments?.first.outbound?.first.departureDateTime,locale: locale);
    }
    return AppDateUtils.formatHalfDateHalfMonth(
        flightSegments?.first.outbound?.first.departureDateTime);
  }

  String get returnDepartureDateToShow {
    return AppDateUtils.formatFullDate(
        flightSegments?.first.inbound?.first.departureDateTime);
  }

  String get departureToDestinationCode {
    return '${flightSegments?.first.outbound?.first.departureAirportLocationCode ?? ''} to ${flightSegments?.first.outbound?.first.arrivalAirportLocationCode ?? ''}';
  }

  String get returnToDestinationCode {
    return '${flightSegments?.first.inbound?.first.departureAirportLocationCode ?? ''} to ${flightSegments?.first.inbound?.first.arrivalAirportLocationCode ?? ''}';
  }

  String get fromToDestinationName {
    return '${flightSegments?.first.inbound?.first.departureAirportLocationName ?? ''} to ${flightSegments?.first.outbound?.first.arrivalAirportLocationName ?? ''}';
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
      this.success});

  Result.fromJson(Map<String, dynamic> json) {
    superPNR =
        json['superPNR'] != null ? SuperPNR.fromJson(json['superPNR']) : null;
    superPNROrder = json['superPNROrder'] != null
        ? SuperPNROrder.fromJson(json['superPNROrder'])
        : null;

    bookingContact = json['bookingContact'] != null
        ? BookingContact.fromJson(json['bookingContact'])
        : null;
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
        ? WheelChairDetail.fromJson(json['wheelChairDetail'])
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
        ? CompanyTaxInvoice.fromJson(json['companyTaxInvoice'])
        : null;
    isReturn = json['isReturn'];
    isRequiredPassport = json['isRequiredPassport'];

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
      data['wheelChairDetail'] = wheelChairDetail!.toJson();
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
  //toBeautify

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

  num? personOrgID;
  Passenger? passengers;
  FareAndBundleDetail? fareAndBundleDetail;
  SeatDetail? seatDetail;
  MealDetail? mealDetail;
  BaggageDetail? baggageDetail;
  WheelChairDetail? wheelChairDetail;
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
  bool? infantExpanded;

  PassengersWithSSR({
    this.personOrgID,
    this.passengers,
    this.fareAndBundleDetail,
    this.seatDetail,
    this.mealDetail,
    this.checkInStatusInOut,
    this.paxSelected = false,
    this.baggageDetail,
    this.wheelChairDetail,
    this.sportEquipmentDetail,
    this.insuranceSSRDetail,
    this.haveInfant,
    this.checkInMemberID,
    this.infantExpanded
  });

  PassengersWithSSR.fromJson(Map<String, dynamic> json) {
    personOrgID = json['personOrgID'];
    haveInfant = json['haveInfant'];


    //checkInMemberID = json['checkInMemberID'];

    if (haveInfant == true) {
      if (json['haveInfant'] != null) {
        infantGivenName = json['infantPassengerDetail']['givenName'];
        infantSurname = json['infantPassengerDetail']['surname'];
        infantDob = json['infantPassengerDetail']['dob'];
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
        ? WheelChairDetail.fromJson(json['wheelChairDetail'])
        : null;
    sportEquipmentDetail = json['sportEquipmentDetail'] != null
        ? SportsEquipmentDetail.fromJson(json['sportEquipmentDetail'])
        : null;
    insuranceSSRDetail = json['insuranceSSRDetail'] != null
        ? InsuranceDetails.fromJson(json['insuranceSSRDetail'])
        : null;
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
      data['wheelChairDetail'] = wheelChairDetail!.toJson();
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
}

class CheckInStatus {
  bool? allowCheckIn;

  String? flightNumber;
  String? departureStationCode;
  String? inkPaxID;
  String? checkInStatus;

  CheckInStatus({this.allowCheckIn});

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
}

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

class WheelChairDetail {
  num? wheelChairCount;
  num? totalAmount;

  //List<Null>? wheelChairs;

  WheelChairDetail({this.wheelChairCount, this.totalAmount});

//, this.wheelChairs
  WheelChairDetail.fromJson(Map<String, dynamic> json) {
    wheelChairCount = json['wheelChairCount'];
    totalAmount = json['totalAmount'];
    // if (json['wheelChairs'] != null) {
    // wheelChairs = <Null>[];
    // json['wheelChairs'].forEach((v) {
    //   wheelChairs!.add(new Null.fromJson(v));
    // });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wheelChairCount'] = wheelChairCount;
    data['totalAmount'] = totalAmount;
    // if (this.wheelChairs != null) {
    //   data['wheelChairs'] = this.wheelChairs!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
