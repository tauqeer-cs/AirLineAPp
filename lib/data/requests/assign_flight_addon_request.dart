import 'flight_summary_pnr_request.dart';

class RequestAssignFlightAddOnRequest {
  AssignFlightAddOnRequest? assignFlightAddOnRequest;

  RequestAssignFlightAddOnRequest({this.assignFlightAddOnRequest});

  RequestAssignFlightAddOnRequest.fromJson(Map<String, dynamic> json) {
    assignFlightAddOnRequest = json['AssignFlightAddOnRequest'] != null
        ? new AssignFlightAddOnRequest.fromJson(
        json['AssignFlightAddOnRequest'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.assignFlightAddOnRequest != null) {
      data['AssignFlightAddOnRequest'] =
          this.assignFlightAddOnRequest!.toJson();
    }
    return data;
  }
}

class AssignFlightAddOnRequest {
  String? pNR;
  String? lastName;
  List<PassengerAddOn>? passengerAddOn;

  AssignFlightAddOnRequest({this.pNR, this.lastName, this.passengerAddOn});

  AssignFlightAddOnRequest.fromJson(Map<String, dynamic> json) {
    pNR = json['PNR'];
    lastName = json['LastName'];
    if (json['PassengerAddOn'] != null) {
      passengerAddOn = <PassengerAddOn>[];
      json['PassengerAddOn'].forEach((v) {
        passengerAddOn!.add(new PassengerAddOn.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PNR'] = pNR;
    data['LastName'] = this.lastName;
    if (this.passengerAddOn != null) {
      data['PassengerAddOn'] =
          this.passengerAddOn!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PassengerAddOn {
  String? passengerKey;
  SSR? sSR;
  Seat? seat;

  PassengerAddOn({this.passengerKey, this.sSR, this.seat});

  PassengerAddOn.fromJson(Map<String, dynamic> json) {
    passengerKey = json['PassengerKey'];
    sSR = json['SSR'] != null ?   SSR.fromJson(json['SSR']) : null;
    seat = json['Seat'] != null ? new Seat.fromJson(json['Seat']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PassengerKey'] = this.passengerKey;
    if (this.sSR != null) {
      data['SSR'] = this.sSR!.toJson();
    }
    if (this.seat != null) {
      data['Seat'] = this.seat!.toJson();
    }
    return data;
  }
}

class SSR {
  List<Bound>? outbound;
  List<Bound>? inbound;

  SSR({this.outbound, this.inbound});

  SSR.fromJson(Map<String, dynamic> json) {
    if (json['Outbound'] != null) {
      outbound = <Bound>[];
      json['Outbound'].forEach((v) {
        outbound!.add(new Bound.fromJson(v));
      });
    }
    if (json['Inbound'] != null) {
      inbound = <Bound>[];
      json['Inbound'].forEach((v) {
        inbound!.add(new Bound.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.outbound != null) {
      data['Outbound'] = this.outbound!.map((v) => v.toJson()).toList();
    }
    if (this.inbound != null) {
      data['Inbound'] = this.inbound!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class Seat {
  Outbound? outbound;
  Outbound? inbound;

  Seat({this.outbound, this.inbound});

  Seat.fromJson(Map<String, dynamic> json) {
    outbound = json['Outbound'] != null
        ? new Outbound.fromJson(json['Outbound'])
        : null;
    inbound =
    json['Inbound'] != null ? new Outbound.fromJson(json['Inbound']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.outbound != null) {
      data['Outbound'] = this.outbound!.toJson();
    }
    if (this.inbound != null) {
      data['Inbound'] = this.inbound!.toJson();
    }
    return data;
  }
}

