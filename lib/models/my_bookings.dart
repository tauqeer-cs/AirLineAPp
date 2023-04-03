import 'package:intl/intl.dart';

class MyBookings {
  List<UpcomingBookings>? upcomingBookings;
  List<UpcomingBookings>? pastBookings;

  MyBookings({this.upcomingBookings, this.pastBookings});

  MyBookings.fromJson(Map<String, dynamic> json) {
    if (json['upcomingBookings'] != null) {
      upcomingBookings = <UpcomingBookings>[];
      json['upcomingBookings'].forEach((v) {
        upcomingBookings!.add(UpcomingBookings.fromJson(v));
      });
    }
    if (json['pastBookings'] != null) {
      pastBookings = <UpcomingBookings>[];
      json['pastBookings'].forEach((v) {
        pastBookings!.add(UpcomingBookings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (upcomingBookings != null) {
      data['upcomingBookings'] =
          upcomingBookings!.map((v) => v.toJson()).toList();
    }
    if (pastBookings != null) {
      data['pastBookings'] = pastBookings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UpcomingBookings {
  String? pnr;
  String? superPNRNo;
  String? lastName;
  bool? allowCheckIn;
  OutboundFlight? outboundFlight;
  OutboundFlight? inboundFlight;

  bool get departureToShow {
    if (DateTime.parse(outboundFlight?.departureDate ?? '')
        .isAfter(DateTime.now())) {
      return true;
    }
    return false;
  }


  String get dateToShow {

    if(departureToShow) {
      var date = (DateTime.parse(outboundFlight?.departureDate ?? ''));
      final formatter = DateFormat('E dd MMM yyyy h:mm a');
      return formatter.format(date);
    }
    var date = (DateTime.parse(inboundFlight?.departureDate ?? ''));
    final formatter = DateFormat('E dd MMM yyyy h:mm a');
    return formatter.format(date);

  }


  String get departureLocation {

    if(departureToShow) {
      return outboundFlight?.departLocation ?? '';
    }

    return inboundFlight?.departLocation ?? '';
  }

  String get returnLocation {
    if(departureToShow) {
      return outboundFlight?.arrivalLocation ?? '';
    }

    return inboundFlight?.arrivalLocation ?? '';
  }

  UpcomingBookings(
      {this.pnr,
      this.superPNRNo,
      this.lastName,
      this.allowCheckIn,
      this.outboundFlight,
      this.inboundFlight});

  UpcomingBookings.fromJson(Map<String, dynamic> json) {
    pnr = json['pnr'];
    superPNRNo = json['superPNRNo'];
    lastName = json['lastName'];
    allowCheckIn = json['allowCheckIn'];
    outboundFlight = json['outboundFlight'] != null
        ? OutboundFlight.fromJson(json['outboundFlight'])
        : null;
    inboundFlight = json['inboundFlight'] != null
        ? OutboundFlight.fromJson(json['inboundFlight'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pnr'] = pnr;
    data['superPNRNo'] = superPNRNo;
    data['lastName'] = lastName;
    data['allowCheckIn'] = allowCheckIn;
    if (outboundFlight != null) {
      data['outboundFlight'] = outboundFlight!.toJson();
    }
    if (inboundFlight != null) {
      data['inboundFlight'] = inboundFlight!.toJson();
    }
    return data;
  }
}

class OutboundFlight {
  String? departureDate;
  String? arrivalDate;
  String? pnr;
  String? departLocation;
  String? arrivalLocation;

  OutboundFlight(
      {this.departureDate,
      this.arrivalDate,
      this.pnr,
      this.departLocation,
      this.arrivalLocation});

  OutboundFlight.fromJson(Map<String, dynamic> json) {
    departureDate = json['departureDate'];
    arrivalDate = json['arrivalDate'];
    pnr = json['pnr'];
    departLocation = json['departLocation'];
    arrivalLocation = json['arrivalLocation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['departureDate'] = departureDate;
    data['arrivalDate'] = arrivalDate;
    data['pnr'] = pnr;
    data['departLocation'] = departLocation;
    data['arrivalLocation'] = arrivalLocation;
    return data;
  }
}
