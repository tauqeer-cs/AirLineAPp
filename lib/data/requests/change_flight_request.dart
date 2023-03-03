class ChangingFlightRequest {
  ChangeFlightRequest? changeFlightRequest;

  ChangingFlightRequest({this.changeFlightRequest});

  ChangingFlightRequest.fromJson(Map<String, dynamic> json) {
    changeFlightRequest = json['ChangeFlightRequest'] != null
        ? ChangeFlightRequest.fromJson(json['ChangeFlightRequest'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (changeFlightRequest != null) {
      data['ChangeFlightRequest'] = changeFlightRequest!.toJson();
    }
    return data;
  }
}

class ChangeFlightRequest {
  String? pNR;
  String? lastName;
  bool? isReturn;
  String? departDate;
  String? returnDate;
  List<OutboundFares>? outboundFares;
  List<OutboundFares>? inboundFares;

  ChangeFlightRequest(
      {this.pNR,
        this.lastName,
        this.isReturn,
        this.departDate,
        this.returnDate,
        this.outboundFares,
        this.inboundFares});

  ChangeFlightRequest.fromJson(Map<String, dynamic> json) {
    pNR = json['PNR'];
    lastName = json['LastName'];
    isReturn = json['IsReturn'];
    departDate = json['DepartDate'];
    returnDate = json['ReturnDate'];
    if (json['OutboundFares'] != null) {
      outboundFares = <OutboundFares>[];
      json['OutboundFares'].forEach((v) {
        outboundFares!.add(OutboundFares.fromJson(v));
      });
    }
    if (json['InboundFares'] != null) {
      inboundFares = <OutboundFares>[];
      json['InboundFares'].forEach((v) {
        inboundFares!.add( OutboundFares.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PNR'] = pNR;
    data['LastName'] = lastName;
    data['IsReturn'] = isReturn;
    data['DepartDate'] = departDate;
    data['ReturnDate'] = returnDate;
    if (outboundFares != null) {
      data['OutboundFares'] =
          outboundFares!.map((v) => v.toJson()).toList();
    }
    if (inboundFares != null) {
      data['InboundFares'] = inboundFares!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OutboundFares {
  int? lFID;
  String? fBCode;

  OutboundFares({this.lFID, this.fBCode});

  OutboundFares.fromJson(Map<String, dynamic> json) {
    lFID = json['LFID'];
    fBCode = json['FBCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['LFID'] = lFID;
    data['FBCode'] = fBCode;
    return data;
  }
}