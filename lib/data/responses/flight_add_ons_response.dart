import 'package:app/data/responses/verify_response.dart';

class FightAddOns {
  List<PaxAddOnSSR>? paxAddOnSSR;

  FlightSeats? flightSeats;

  FightAddOns({this.paxAddOnSSR, });


  FightAddOns.fromJson(Map<String, dynamic> json) {
    if (json['paxAddOnSSR'] != null) {
      paxAddOnSSR = <PaxAddOnSSR>[];
      json['paxAddOnSSR'].forEach((v) {
        paxAddOnSSR!.add(new PaxAddOnSSR.fromJson(v));
      });
    }

    if (json['flightSeat'] != null) {
      flightSeats = FlightSeats.fromJson(json['flightSeat'] as Map<String, dynamic>);
    }


    print('');


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paxAddOnSSR != null) {
      data['paxAddOnSSR'] = this.paxAddOnSSR!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class PaxAddOnSSR {
  String? passengerKey;
  FlightSSR? flightSSR;

  PaxAddOnSSR({this.passengerKey, this.flightSSR});

  PaxAddOnSSR.fromJson(Map<String, dynamic> json) {
    passengerKey = json['passengerKey'];
    flightSSR = json['flightSSR'] != null
        ? new FlightSSR.fromJson(json['flightSSR'])
        : null;
    print('');

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['passengerKey'] = this.passengerKey;
    if (this.flightSSR != null) {
      data['flightSSR'] = this.flightSSR!.toJson();
    }
    return data;
  }
}

class FlightSSR {
  BundleGroupSeat? mealGroup;
  BaggageGroup? baggageGroup;
  BundleGroupSeat? wheelChairGroup;
  BundleGroupSeat? sportGroup;
  BundleGroupSeat? insuranceGroup;



  FlightSSR(
      {this.mealGroup,
        this.baggageGroup,
        this.wheelChairGroup,
        this.sportGroup,
      this.insuranceGroup});

  FlightSSR.fromJson(Map<String, dynamic> json) {
    mealGroup = json['mealGroup'] != null
        ? new BundleGroupSeat.fromJson(json['mealGroup'])
        : null;
    baggageGroup = json['baggageGroup'] != null
        ? new BaggageGroup.fromJson(json['baggageGroup'])
        : null;
    wheelChairGroup = json['wheelChairGroup'] != null
        ? new BundleGroupSeat.fromJson(json['wheelChairGroup'])
        : null;
    sportGroup = json['sportGroup'] != null
        ? new BundleGroupSeat.fromJson(json['sportGroup'])
        : null;

    insuranceGroup = json['insuranceGroup'] != null
        ? BundleGroupSeat.fromJson(json['insuranceGroup'])
        : null;






  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mealGroup != null) {
      data['mealGroup'] = this.mealGroup!.toJson();
    }
    if (this.baggageGroup != null) {
      data['baggageGroup'] = this.baggageGroup!.toJson();
    }
    if (this.wheelChairGroup != null) {
      data['wheelChairGroup'] = this.wheelChairGroup!.toJson();
    }
    if (this.sportGroup != null) {
      data['sportGroup'] = this.sportGroup!.toJson();
    }

    if (this.insuranceGroup != null) {
      data['insuranceGroup'] = this.insuranceGroup!.toJson();
    }



    return data;
  }
}


