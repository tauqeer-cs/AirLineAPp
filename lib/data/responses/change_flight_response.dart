import 'package:app/data/responses/verify_response.dart';

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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (flightVerifyResponse != null) {
      data['flightVerifyResponse'] = flightVerifyResponse!.toJson();
    }
    if (changeFlightRequest != null) {
      data['changeFlightRequest'] = changeFlightRequest!.toJson();
    }
    if (changeFlightResponse != null) {
      data['changeFlightResponse'] = changeFlightResponse!.toJson();
    }
    data['orderID'] = orderID;
    data['token'] = token;
    data['verifyExpiredDateTime'] = verifyExpiredDateTime;
    data['success'] = success;
    data['isInvalidMemberID'] = isInvalidMemberID;
    data['fromCache'] = fromCache;
    return data;
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

  ChangeFlightResponse(
      {this.success,
      this.totalReservationAmount,
      this.changeFee,
      this.currency,
      this.session});

  ChangeFlightResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if(json['totalReservationAmount'] == 0) {
      totalReservationAmount = 0.0;

    }
    else {
      totalReservationAmount = json['totalReservationAmount'];

    }
    changeFee = json['changeFee'];
    currency = json['currency'];
    session = json['session'];
  }

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


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['totalReservationAmount'] = totalReservationAmount;
    data['changeFee'] = changeFee;
    data['currency'] = currency;
    data['session'] = session;
    return data;
  }
}
