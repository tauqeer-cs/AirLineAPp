class CheckInRequest {
  String? pNR;
  int? superPNRID;
  String? superPNRNo;
  String? lastName;
  List<OutboundCheckInPassengerDetails>? outboundCheckInPassengerDetails;
  List<OutboundCheckInPassengerDetails>? inboundCheckInPassengerDetails;

  CheckInRequest(
      {this.pNR,
        this.superPNRID,
        this.superPNRNo,
        this.lastName,
        this.outboundCheckInPassengerDetails,
        this.inboundCheckInPassengerDetails});

  CheckInRequest.fromJson(Map<String, dynamic> json) {
    pNR = json['PNR'];
    superPNRID = json['SuperPNRID'];
    superPNRNo = json['SuperPNRNo'];
    lastName = json['LastName'];
    if (json['OutboundCheckInPassengerDetails'] != null) {
      outboundCheckInPassengerDetails = <OutboundCheckInPassengerDetails>[];
      json['OutboundCheckInPassengerDetails'].forEach((v) {
        outboundCheckInPassengerDetails!
            .add( OutboundCheckInPassengerDetails.fromJson(v));
      });
    }
    if (json['InboundCheckInPassengerDetails'] != null) {
      inboundCheckInPassengerDetails = <OutboundCheckInPassengerDetails>[];
      json['InboundCheckInPassengerDetails'].forEach((v) {
        inboundCheckInPassengerDetails!.add( OutboundCheckInPassengerDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PNR'] = pNR;
    data['SuperPNRID'] = superPNRID;
    data['SuperPNRNo'] = superPNRNo;
    data['LastName'] = lastName;
    if (outboundCheckInPassengerDetails != null) {
      data['OutboundCheckInPassengerDetails'] =
          outboundCheckInPassengerDetails!.map((v) => v.toJson()).toList();
    }
    if (inboundCheckInPassengerDetails != null) {
      data['InboundCheckInPassengerDetails'] =
          inboundCheckInPassengerDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OutboundCheckInPassengerDetails {
  String? flightNumber;
  String? departureStationCode;
  String? inkPaxID;
  String? passportNumber;
  String? passportExpiryDate;
  String? memberID;

  OutboundCheckInPassengerDetails(
      {this.flightNumber,
        this.departureStationCode,
        this.inkPaxID,
        this.passportNumber,
        this.passportExpiryDate,
        this.memberID});

  OutboundCheckInPassengerDetails.fromJson(Map<String, dynamic> json) {
    flightNumber = json['FlightNumber'];
    departureStationCode = json['DepartureStationCode'];
    inkPaxID = json['InkPaxID'];
    passportNumber = json['PassportNumber'];
    passportExpiryDate = json['PassportExpiryDate'];
    memberID = json['MemberID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['FlightNumber'] = flightNumber;
    data['DepartureStationCode'] = departureStationCode;
    data['InkPaxID'] = inkPaxID;
    data['PassportNumber'] = passportNumber;
    data['PassportExpiryDate'] = passportExpiryDate;
    data['MemberID'] = memberID;
    return data;
  }
}