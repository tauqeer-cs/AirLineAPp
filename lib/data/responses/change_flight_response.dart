import 'package:app/data/responses/verify_response.dart';

import 'package:app/models/confirmation_model.dart';

import '../../utils/date_utils.dart';

class ChangeFlightRequestResponse {
  Result? result;
  bool? success;
  String? message;

  ChangeFlightRequestResponse({this.result, this.success, this.message});

  ChangeFlightRequestResponse.fromJson(Map<String, dynamic> json) {
    result = Result.fromJson(json);
    success = json['success'];
    message = json['message'];
  }
}

class Result {
  FlightVerifyResponse? flightVerifyResponse;
  ChangeFlightRequestObject? changeFlightRequest;
  ChangeFlightResponse? changeFlightResponse;
  num? orderID;
  String? token;
  String? verifyExpiredDateTime;
  bool? success;
  bool? isInvalidMemberID;
  bool? fromCache;

  Result(
      {this.flightVerifyResponse,
      this.changeFlightRequest,
      this.changeFlightResponse,
      this.orderID,
      this.token,
      this.verifyExpiredDateTime,
      this.success,
      this.isInvalidMemberID,
      this.fromCache});

  Result.fromJson(Map<String, dynamic> json) {
    flightVerifyResponse = json['flightVerifyResponse'] != null
        ? FlightVerifyResponse.fromJson(json['flightVerifyResponse'])
        : null;
    changeFlightRequest = json['changeFlightRequest'] != null
        ? ChangeFlightRequestObject.fromJson(json['changeFlightRequest'])
        : null;
    changeFlightResponse = json['changeFlightResponse'] != null
        ? ChangeFlightResponse.fromJson(json['changeFlightResponse'])
        : null;
    orderID = json['orderID'];
    token = json['token'];
    verifyExpiredDateTime = json['verifyExpiredDateTime'];
    success = json['success'];
    isInvalidMemberID = json['isInvalidMemberID'];
    fromCache = json['fromCache'];
  }
}

class FareTypes {
  num? fareTypeID;
  String? fareTypeName;
  bool? filterRemove;
  List<FareInfos>? fareInfos;

  FareTypes(
      {this.fareTypeID, this.fareTypeName, this.filterRemove, this.fareInfos});

  FareTypes.fromJson(Map<String, dynamic> json) {
    fareTypeID = json['fareTypeID'];
    fareTypeName = json['fareTypeName'];
    filterRemove = json['filterRemove'];
    if (json['fareInfos'] != null) {
      fareInfos = <FareInfos>[];
      json['fareInfos'].forEach((v) {
        fareInfos!.add(FareInfos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fareTypeID'] = fareTypeID;
    data['fareTypeName'] = fareTypeName;
    data['filterRemove'] = filterRemove;
    if (fareInfos != null) {
      data['fareInfos'] = fareInfos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FareInfos {
//  List<Null>? returnFlightSegmentDetails;
  num? fareID;
  String? fcCode;
  String? fbCode;
  num? baseFareAmtNoTaxes;
  num? baseFareAmt;
  num? fareAmtNoTaxes;
  num? fareAmt;
  num? baseFareAmtInclTax;
  num? fareAmtInclTax;
  bool? pvtFare;
  num? ptcid;
  String? cabin;
  num? seatsAvailable;
  num? infantSeatsAvailable;
  num? fareScheduleID;
  num? promotionID;
  num? roundTrip;
  num? displayFareAmt;
  num? displayTaxSum;
  bool? specialMarketed;
  bool? waitList;
  bool? spaceAvailable;
  bool? positiveSpace;
  num? promotionCatID;
  num? commissionAmount;
  num? promotionAmount;
  List<ApplicableTaxDetails>? applicableTaxDetails;
  String? bundleCode;
  String? originalCurrency;
  num? exchangeRate;
  String? exchangeDate;

  FareInfos(
      {
      //this.returnFlightSegmentDetails,
      this.fareID,
      this.fcCode,
      this.fbCode,
      this.baseFareAmtNoTaxes,
      this.baseFareAmt,
      this.fareAmtNoTaxes,
      this.fareAmt,
      this.baseFareAmtInclTax,
      this.fareAmtInclTax,
      this.pvtFare,
      this.ptcid,
      this.cabin,
      this.seatsAvailable,
      this.infantSeatsAvailable,
      this.fareScheduleID,
      this.promotionID,
      this.roundTrip,
      this.displayFareAmt,
      this.displayTaxSum,
      this.specialMarketed,
      this.waitList,
      this.spaceAvailable,
      this.positiveSpace,
      this.promotionCatID,
      this.commissionAmount,
      this.promotionAmount,
      this.applicableTaxDetails,
      this.bundleCode,
      this.originalCurrency,
      this.exchangeRate,
      this.exchangeDate});

  FareInfos.fromJson(Map<String, dynamic> json) {
    /*if (json['returnFlightSegmentDetails'] != null) {
      returnFlightSegmentDetails = <Null>[];
      json['returnFlightSegmentDetails'].forEach((v) {
        returnFlightSegmentDetails!.add(new Null.fromJson(v));
      });
    }*/

    fareID = json['fareID'];
    fcCode = json['fcCode'];
    fbCode = json['fbCode'];
    baseFareAmtNoTaxes = json['baseFareAmtNoTaxes'];
    baseFareAmt = json['baseFareAmt'];
    fareAmtNoTaxes = json['fareAmtNoTaxes'];
    fareAmt = json['fareAmt'];
    baseFareAmtInclTax = json['baseFareAmtInclTax'];
    fareAmtInclTax = json['fareAmtInclTax'];
    pvtFare = json['pvtFare'];
    ptcid = json['ptcid'];
    cabin = json['cabin'];
    seatsAvailable = json['seatsAvailable'];
    infantSeatsAvailable = json['infantSeatsAvailable'];
    fareScheduleID = json['fareScheduleID'];
    promotionID = json['promotionID'];
    roundTrip = json['roundTrip'];
    displayFareAmt = json['displayFareAmt'];
    displayTaxSum = json['displayTaxSum'];
    specialMarketed = json['specialMarketed'];
    waitList = json['waitList'];
    spaceAvailable = json['spaceAvailable'];
    positiveSpace = json['positiveSpace'];
    promotionCatID = json['promotionCatID'];
    commissionAmount = json['commissionAmount'];
    promotionAmount = json['promotionAmount'];
    if (json['applicableTaxDetails'] != null) {
      applicableTaxDetails = <ApplicableTaxDetails>[];
      json['applicableTaxDetails'].forEach((v) {
        applicableTaxDetails!.add(ApplicableTaxDetails.fromJson(v));
      });
    }
    bundleCode = json['bundleCode'];
    originalCurrency = json['originalCurrency'];
    exchangeRate = json['exchangeRate'];
    exchangeDate = json['exchangeDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    /*if (this.returnFlightSegmentDetails != null) {
      data['returnFlightSegmentDetails'] =
          this.returnFlightSegmentDetails!.map((v) => v.toJson()).toList();
    }*/

    data['fareID'] = fareID;
    data['fcCode'] = fcCode;
    data['fbCode'] = fbCode;
    data['baseFareAmtNoTaxes'] = baseFareAmtNoTaxes;
    data['baseFareAmt'] = baseFareAmt;
    data['fareAmtNoTaxes'] = fareAmtNoTaxes;
    data['fareAmt'] = fareAmt;
    data['baseFareAmtInclTax'] = baseFareAmtInclTax;
    data['fareAmtInclTax'] = fareAmtInclTax;
    data['pvtFare'] = pvtFare;
    data['ptcid'] = ptcid;
    data['cabin'] = cabin;
    data['seatsAvailable'] = seatsAvailable;
    data['infantSeatsAvailable'] = infantSeatsAvailable;
    data['fareScheduleID'] = fareScheduleID;
    data['promotionID'] = promotionID;
    data['roundTrip'] = roundTrip;
    data['displayFareAmt'] = displayFareAmt;
    data['displayTaxSum'] = displayTaxSum;
    data['specialMarketed'] = specialMarketed;
    data['waitList'] = waitList;
    data['spaceAvailable'] = spaceAvailable;
    data['positiveSpace'] = positiveSpace;
    data['promotionCatID'] = promotionCatID;
    data['commissionAmount'] = commissionAmount;
    data['promotionAmount'] = promotionAmount;
    if (applicableTaxDetails != null) {
      data['applicableTaxDetails'] =
          applicableTaxDetails!.map((v) => v.toJson()).toList();
    }
    data['bundleCode'] = bundleCode;
    data['originalCurrency'] = originalCurrency;
    data['exchangeRate'] = exchangeRate;
    data['exchangeDate'] = exchangeDate;
    return data;
  }
}

class ApplicableTaxDetails {
  num? taxID;
  num? amt;
  num? initiatingTaxID;
  num? commissionAmount;

  ApplicableTaxDetails(
      {this.taxID, this.amt, this.initiatingTaxID, this.commissionAmount});

  ApplicableTaxDetails.fromJson(Map<String, dynamic> json) {
    taxID = json['taxID'];
    amt = json['amt'];
    initiatingTaxID = json['initiatingTaxID'];
    commissionAmount = json['commissionAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['taxID'] = taxID;
    data['amt'] = amt;
    data['initiatingTaxID'] = initiatingTaxID;
    data['commissionAmount'] = commissionAmount;
    return data;
  }
}

class FlightLegDetails {
  num? pfid;
  String? departureDate;

  FlightLegDetails({this.pfid, this.departureDate});

  FlightLegDetails.fromJson(Map<String, dynamic> json) {
    pfid = json['pfid'];
    departureDate = json['departureDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pfid'] = pfid;
    data['departureDate'] = departureDate;
    return data;
  }
}

class ChangeFlightRequestObject {
  String? pnr;
  String? lastName;
  bool? isReturn;
  String? departDate;
  String? returnDate;
  List<Fares>? outboundFares;
  List<Fares>? inboundFares;

  ChangeFlightRequestObject(
      {this.pnr,
      this.lastName,
      this.isReturn,
      this.departDate,
      this.returnDate,
      this.outboundFares,
      this.inboundFares});

  ChangeFlightRequestObject.fromJson(Map<String, dynamic> json) {
    pnr = json['pnr'];
    lastName = json['lastName'];
    isReturn = json['isReturn'];
    departDate = json['departDate'];
    returnDate = json['returnDate'];
    if (json['outboundFares'] != null) {
      outboundFares = <Fares>[];
      json['outboundFares'].forEach((v) {
        outboundFares!.add(Fares.fromJson(v));
      });
    }
    if (json['inboundFares'] != null) {
      inboundFares = <Fares>[];
      json['inboundFares'].forEach((v) {
        inboundFares!.add(Fares.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pnr'] = pnr;
    data['lastName'] = lastName;
    data['isReturn'] = isReturn;
    data['departDate'] = departDate;
    data['returnDate'] = returnDate;
    if (outboundFares != null) {
      data['outboundFares'] = outboundFares!.map((v) => v.toJson()).toList();
    }
    if (inboundFares != null) {
      data['inboundFares'] = inboundFares!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Fares {
  num? lfid;
  num? pfid;
  String? fbCode;

  Fares({this.lfid, this.pfid, this.fbCode});

  Fares.fromJson(Map<String, dynamic> json) {
    lfid = json['lfid'];
    pfid = json['pfid'];
    fbCode = json['fbCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lfid'] = lfid;
    data['pfid'] = pfid;
    data['fbCode'] = fbCode;
    return data;
  }
}

class ChangeFlightResponse {
  bool? success;
  num? totalReservationAmount;
  num? changeFee;
  String? currency;
  String? session;
  List<PassengersWithSSRFareBreakDown>? passengersWithSSRFareBreakDown;
  FlightBreakDown? flightBreakDown;
  String? changeFlightMessage;
  bool? isReturn;

  String get totalReservationAmountString {
    if (totalReservationAmount != null) {
      return 'MYR ${totalReservationAmount!.toStringAsFixed(2)}';
    }

    return '';
  }

  String get flightChangAmountString {
    if (totalReservationAmount != null) {
      return 'MYR ${changeFee!.toStringAsFixed(2)}';
    }

    return '';
  }

  ChangeFlightResponse(
      {this.success,
      this.totalReservationAmount,
      this.changeFee,
      this.currency,
      this.session,
      this.passengersWithSSRFareBreakDown,
      this.flightBreakDown,
      this.changeFlightMessage,
      this.isReturn});

  ChangeFlightResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    totalReservationAmount = json['totalReservationAmount'];
    changeFee = json['changeFee'];
    currency = json['currency'];
    session = json['session'];
    if (json['passengersWithSSRFareBreakDown'] != null) {
      passengersWithSSRFareBreakDown = <PassengersWithSSRFareBreakDown>[];
      json['passengersWithSSRFareBreakDown'].forEach((v) {
        passengersWithSSRFareBreakDown!
            .add(PassengersWithSSRFareBreakDown.fromJson(v));
      });
    }
    flightBreakDown = json['flightBreakDown'] != null
        ? FlightBreakDown.fromJson(json['flightBreakDown'])
        : null;
    changeFlightMessage = json['changeFlightMessage'];
    isReturn = json['isReturn'];
  }
}

class PassengersWithSSRFareBreakDown {
  num? personOrgID;
  Passenger? passengers;
  FareAndBundleDetail? fareAndBundleDetail;
  SeatDetail? seatDetail;
  MealDetail? mealDetail;
  BaggageDetail? baggageDetail;
  WheelChairDetail? wheelChairDetail;
  SportsEquipmentDetail? sportEquipmentDetail;
  InsuranceDetails? insuranceSSRDetail;
  SeatDetail? notAvailableSeatDetail;

  List<MealList> get myDepartMeals {
    List<MealList> answer = [];

    if (mealDetail != null) {
      for (Meal currentMeal in mealDetail!.meals ?? []) {
        for (MealList currentItem in currentMeal.mealList ?? []) {
          if (currentItem.departReturn == 'Depart') {
            answer.add(currentItem);
          }
        }
      }
    }

    return answer;
  }

  Baggage? get departureBag {
    try {
      if (baggageDetail != null) {
        if(baggageDetail!.baggages == null){
          return null;
        }
        else if(baggageDetail!.baggages!.isNotEmpty){
          return baggageDetail!.baggages!.firstWhere((e) => e.departReturn == 'Depart');
        }
        else {
          return null;

        }

      }
      return null;
    }
    catch(e){
      return null;
    }

  }



  Baggage? get departureSport {
    try {
      if (sportEquipmentDetail != null) {
        if(sportEquipmentDetail!.sportEquipments == null){
          return null;
        }
        else if(sportEquipmentDetail!.sportEquipments!.isNotEmpty){
          return sportEquipmentDetail!.sportEquipments!.firstWhere((e) => e.departReturn == 'Depart');
        }
        else {
          return null;

        }

      }
      return null;
    }
    catch(e){
      return null;
    }

  }

  Baggage? get insuranceDepart {
    try {
      if (insuranceSSRDetail != null) {
        if(insuranceSSRDetail!.insuranceSSRs == null){
          return null;
        }
        else if(insuranceSSRDetail!.insuranceSSRs!.isNotEmpty){
          return insuranceSSRDetail!.insuranceSSRs!.firstWhere((e) => e.departReturn == 'Depart');
        }
        else {
          return null;

        }

      }
      return null;
    }
    catch(e){
      return null;
    }

  }


  Baggage? get wheelChairDepart {
    try {
      if (wheelChairDetail != null) {
        if(wheelChairDetail!.wheelChairs == null){
          return null;
        }
        else if(wheelChairDetail!.wheelChairs!.isNotEmpty){
          return wheelChairDetail!.wheelChairs!.firstWhere((e) => e.departReturn == 'Depart');
        }
        else {
          return null;

        }

      }
      return null;
    }
    catch(e){
      return null;
    }

  }

  Baggage? get wheelChairReturn {
    try {
      if (wheelChairDetail != null) {
        if(wheelChairDetail!.wheelChairs == null){
          return null;
        }
        else if(wheelChairDetail!.wheelChairs!.isNotEmpty){
          return wheelChairDetail!.wheelChairs!.firstWhere((e) => e.departReturn != 'Depart');
        }
        else {
          return null;

        }

      }
      return null;
    }
    catch(e){
      return null;
    }

  }





  Baggage? get returnSport {
    try {
      if (sportEquipmentDetail != null) {
        if(sportEquipmentDetail!.sportEquipments == null){
          return null;
        }
        else if(sportEquipmentDetail!.sportEquipments!.isNotEmpty){
          return sportEquipmentDetail!.sportEquipments!.firstWhere((e) => e.departReturn != 'Depart');
        }
        else {
          return null;

        }

      }
      return null;
    }
    catch(e){
      return null;
    }

  }



  Baggage? get returnBag {
    try {
      if (baggageDetail != null) {
        if(baggageDetail!.baggages == null){
          return null;
        }
        else if(baggageDetail!.baggages!.isNotEmpty){
          return baggageDetail!.baggages!.firstWhere((e) => e.departReturn != 'Depart');
        }
        else {
          return null;

        }

      }
      return null;
    }

    catch(e){
      return null;
    }
  }

  List<MealList> get myReturnMeals {
    List<MealList> answer = [];

    if (mealDetail != null) {
      for (Meal currentMeal in mealDetail!.meals ?? []) {
        for (MealList currentItem in currentMeal.mealList ?? []) {
          if (currentItem.departReturn == 'Return') {
            answer.add(currentItem);
          }
        }
      }
    }

    return answer;
  }

  PassengersWithSSRFareBreakDown(
      {this.personOrgID,
      this.passengers,
      this.fareAndBundleDetail,
      this.seatDetail,
      this.mealDetail,
      this.baggageDetail,
      this.wheelChairDetail,
      this.sportEquipmentDetail,
      this.insuranceSSRDetail,
      this.notAvailableSeatDetail});

  PassengersWithSSRFareBreakDown.fromJson(Map<String, dynamic> json) {
    personOrgID = json['personOrgID'];
    passengers = json['passengers'] != null
        ? Passenger.fromJson(json['passengers'])
        : null;
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
    notAvailableSeatDetail = json['notAvailableSeatDetail'] != null
        ? SeatDetail.fromJson(json['notAvailableSeatDetail'])
        : null;
  }
}

class FareAndBundleDetail {
  num? fareAndBundleCount;
  num? totalAmount;
  List<FareAndBundles>? fareAndBundles;

  FareAndBundleDetail(
      {this.fareAndBundleCount, this.totalAmount, this.fareAndBundles});

  FareAndBundleDetail.fromJson(Map<String, dynamic> json) {
    fareAndBundleCount = json['fareAndBundleCount'];
    totalAmount = json['totalAmount'];
    if (json['fareAndBundles'] != null) {
      fareAndBundles = <FareAndBundles>[];
      json['fareAndBundles'].forEach((v) {
        fareAndBundles!.add(FareAndBundles.fromJson(v));
      });
    }
  }
}

class FareAndBundles {
  String? surName;
  String? givenName;
  String? title;
  num? fareAmount;
  String? currency;
  num? quantity;

  //List<Null>? bundleItems;

  FareAndBundles({
    this.surName,
    this.givenName,
    this.title,
    this.fareAmount,
    this.currency,
    this.quantity,
  });

  FareAndBundles.fromJson(Map<String, dynamic> json) {
    surName = json['surName'];
    givenName = json['givenName'];
    title = json['title'];
    fareAmount = json['fareAmount'];
    currency = json['currency'];
    quantity = json['quantity'];
  }
}

class SeatDetail {
  num? seatCount;
  num? totalAmount;
  List<Seats>? seats;

  Seats? get departUnavaibleSeat {
    try {
      if (seats != null) {
        Seats? seat = seats!.firstWhere((e) => e.departReturn == "Depart");
        return seat;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  String get departSeatName {
    try {
      if (seats != null) {
        Seats? seat = seats!.firstWhere((e) => e.departReturn == "Depart");
        return 'Seat ${seat.seatPosition ?? ''} Unavailable';
      }
      return '';
    } catch (e) {
      return 'N/A';
    }
  }

  String get returnSeatName {
    try {
      if (seats != null) {
        Seats? seat = seats!.firstWhere((e) => e.departReturn != "Depart");

        return 'Seat ${seat.seatPosition ?? ''} Unavailable';
      }
      return '';
    } catch (e) {
      return 'N/A';
    }
  }

  String get departSeatAmount {
    try {
      if (seats != null) {
        Seats? seat = seats!.firstWhere((e) => e.departReturn == "Depart");
        return (seat.amount ?? 0.0).toStringAsFixed(2);
      }
      return '';
    } catch (e) {
      return 'N/A';
    }
  }

  String get returnSeatAmount {
    try {
      if (seats != null) {
        Seats? seat = seats!.firstWhere((e) => e.departReturn != "Depart");
        return (seat.amount ?? 0.0).toStringAsFixed(2);
      }
      return '';
    } catch (e) {
      return 'N/A';
    }
  }

  Seats? get returnUnavaibleSeat {
    try {
      if (seats != null) {
        Seats? seat = seats!.firstWhere((e) => e.departReturn != "Depart");
        return seat;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  SeatDetail({this.seatCount, this.totalAmount, this.seats});

  SeatDetail.fromJson(Map<String, dynamic> json) {
    seatCount = json['seatCount'];
    totalAmount = json['totalAmount'];
    if (json['seats'] != null) {
      seats = <Seats>[];
      json['seats'].forEach((v) {
        seats!.add(Seats.fromJson(v));
      });
    }
  }
}

class Seats {
  String? surName;
  String? givenName;
  String? title;
  String? seatPosition;
  num? amount;
  num? quantity;
  String? currency;
  String? departReturn;

  Seats(
      {this.surName,
      this.givenName,
      this.title,
      this.seatPosition,
      this.amount,
      this.quantity,
      this.currency,
      this.departReturn});

  Seats.fromJson(Map<String, dynamic> json) {
    surName = json['surName'];
    givenName = json['givenName'];
    title = json['title'];
    seatPosition = json['seatPosition'];
    amount = json['amount'];
    quantity = json['quantity'];
    currency = json['currency'];
    departReturn = json['departReturn'];
  }
}


class WheelChairDetail {
  num? wheelChairCount;
  num? totalAmount;
  List<Baggage>? wheelChairs;

  WheelChairDetail({this.wheelChairCount, this.totalAmount, this.wheelChairs});

  WheelChairDetail.fromJson(Map<String, dynamic> json) {
    wheelChairCount = json['wheelChairCount'];
    totalAmount = json['totalAmount'];
    if (json['wheelChairs'] != null) {
      wheelChairs = <Baggage>[];
      json['wheelChairs'].forEach((v) {
        wheelChairs!.add(Baggage.fromJson(v));
      });
    }
  }
}



class FlightBreakDown {
  FlightDetail? departDetail;
  FlightDetail? returnDetail;

  FlightBreakDown({this.departDetail, this.returnDetail});

  FlightBreakDown.fromJson(Map<String, dynamic> json) {
    departDetail = json['departDetail'] != null
        ? FlightDetail.fromJson(json['departDetail'])
        : null;
    returnDetail = json['returnDetail'] != null
        ? FlightDetail.fromJson(json['returnDetail'])
        : null;
  }
}

class FlightPaxNameList {
  String? titleCode;
  String? givenName;
  String? surname;

   num? changeAmount;
  String? currency;

  //"changeAmount": 0,
 // "currency": "MYR"

  FlightPaxNameList({this.titleCode, this.givenName, this.surname,this.currency});

  FlightPaxNameList.fromJson(Map<String, dynamic> json) {
    titleCode = json['titleCode'];
    givenName = json['givenName'];
    surname = json['surname'];
    changeAmount = json['changeAmount'];
    currency = json['currency'];
  }
}

class FlightDetail {
  String? routeName;
  String? date;
  num? totalChangeAmount;
  String? currency;
  List<FlightPaxNameList>? flightPaxNameList;

  String get routeNameToShow {
    var datet = DateTime.parse(date ?? '');
    AppDateUtils.formatHalfDate(datet);

    return '${routeName ?? ''}\n${AppDateUtils.formatHalfDate(datet)}';
  }

  FlightDetail(
      {this.routeName,
      this.date,
      this.totalChangeAmount,
      this.currency,
      this.flightPaxNameList});

  FlightDetail.fromJson(Map<String, dynamic> json) {
    routeName = json['routeName'];
    date = json['date'];
    totalChangeAmount = json['totalChangeAmount'];
    currency = json['currency'];
    if (json['flightPaxNameList'] != null) {
      flightPaxNameList = <FlightPaxNameList>[];
      json['flightPaxNameList'].forEach((v) {
        flightPaxNameList!.add(FlightPaxNameList.fromJson(v));
      });
    }
  }
}
