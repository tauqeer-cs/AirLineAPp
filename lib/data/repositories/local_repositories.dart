import 'package:app/app/app_logger.dart';
import 'package:app/data/requests/flight_summary_pnr_request.dart';
import 'package:app/data/responses/airports_response.dart';
import 'package:app/models/booking_local.dart';
import 'package:hive/hive.dart';

const String passengerInfoBox = "passengerInfoBoxV3";
const String airportsBox = "airportsBox";
const String bookingBox = "bookingBox";
const String timerBox = "timerBox";
const String sessionBox = "sessionBox";

class LocalRepository {
  static final LocalRepository _instance = LocalRepository._internal();

  factory LocalRepository() {
    return _instance;
  }

  LocalRepository._internal();

  void setPassengerInfo(FlightSummaryPnrRequest flightSummaryPnrRequest) {
    var box = Hive.box<FlightSummaryPnrRequest>(passengerInfoBox);
    box.put("info", flightSummaryPnrRequest);
  }

  FlightSummaryPnrRequest getPassengerInfo() {
    var box = Hive.box<FlightSummaryPnrRequest>(passengerInfoBox);
    return false
        ? box.get("info") ??
            FlightSummaryPnrRequest(
              emergencyContact: EmergencyContact(),
            )
        : FlightSummaryPnrRequest(
            emergencyContact: EmergencyContact(),
          );
  }

  void saveAirports(AirportsResponse airportsResponse) {
    var box = Hive.box<AirportsResponse>(airportsBox);
    box.put("airports", airportsResponse);
  }

  FlightSummaryPnrRequest getAirports() {
    var box = Hive.box<FlightSummaryPnrRequest>(airportsBox);
    return box.get("airports") ?? FlightSummaryPnrRequest();
  }

  void saveBooking(BookingLocal bookingLocal) {
    var box = Hive.box<List>(bookingBox);
    final bookings = getBooking();
    bookings.add(bookingLocal);
    box.put("data", bookings);
  }

  List<BookingLocal> getBooking() {
    var box = Hive.box<List>(bookingBox);
    final list = box.get("data", defaultValue: []) ?? <BookingLocal>[];
    return list.map((e) => e as BookingLocal).toList();
  }

  Future<void> storeExpiredTime(String? value) async {
    var box = Hive.box<String>(timerBox);
    logger.i("saved time $value");
    await box.clear();
    box.add(value ?? "");
  }

  String? getExpiredTime() {
    var box = Hive.box<String>(timerBox);
    var token = box.isNotEmpty ? box.getAt(0) : "";
    logger.i("loaded time $token");
    return token;
  }

  Future<void> deleteExpiredTime() async {
    var box = Hive.box<String>(timerBox);
    box.clear();
  }

  Future<void> storeSessionExpiredTime(String? value) async {
    var box = Hive.box<String>(sessionBox);
    logger.i("saved Session time $value");
    await box.clear();
    box.add(value ?? "");
  }

  String? getSessionExpiredTime() {
    var box = Hive.box<String>(sessionBox);
    var token = box.isNotEmpty ? box.getAt(0) : "";
    logger.i("loaded session time $token");
    return token;
  }

  Future<void> deleteSessionExpiredTime() async {
    var box = Hive.box<String>(sessionBox);
    box.clear();
  }
}
