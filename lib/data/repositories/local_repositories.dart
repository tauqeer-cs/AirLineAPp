import 'package:app/data/requests/flight_summary_pnr_request.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

const String passengerInfoBox = "passengerInfoBox";

class LocalRepository {
  static final LocalRepository _instance = LocalRepository._internal();

  factory LocalRepository() {
    return _instance;
  }

  LocalRepository._internal();

  void setPassengerInfo(FlightSummaryPnrRequest flightSummaryPnrRequest) {
    var box = Hive.box<FlightSummaryPnrRequest>(passengerInfoBox);
    print("saved is ${flightSummaryPnrRequest.emergencyContact?.toJson()}");
    box.put("info", flightSummaryPnrRequest);
  }

  FlightSummaryPnrRequest getPassengerInfo() {
    var box = Hive.box<FlightSummaryPnrRequest>(passengerInfoBox);
    return box.get("info") ?? FlightSummaryPnrRequest();
  }
}