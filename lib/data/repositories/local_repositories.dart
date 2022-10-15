import 'package:app/data/requests/flight_summary_pnr_request.dart';
import 'package:app/models/booking_local.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

const String passengerInfoBox = "passengerInfoBox";
const String bookingBox = "bookingBox";

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

  void saveBooking(BookingLocal bookingLocal) {
    var box = Hive.box<List>(bookingBox);
    final bookings = getBooking();
    bookings.add(bookingLocal);
    print("book saved is ${bookings.first}");
    box.put("data", bookings);
  }

  List<BookingLocal> getBooking(){
    var box = Hive.box<List>(bookingBox);
    final list = box.get("data", defaultValue: []) ?? <BookingLocal>[];
    print("list is $list");
    return list.map((e) => e as BookingLocal).toList();
  }
}