import 'package:app/app/app_flavor.dart';
import 'package:app/data/api.dart';
import 'package:app/data/responses/common_response.dart';

import '../../models/my_bookings.dart';
import '../../models/pay_redirection.dart';
import '../provider/manage_booking_provider.dart';
import '../requests/change_flight_request.dart';
import '../requests/manage_booking_request.dart';
import '../requests/mmb_checkout_request.dart';
import '../requests/search_change_flight_request.dart';
import '../requests/update_booking_contacts.dart';
import '../responses/change_flight_response.dart';

import '../responses/flight_response.dart';
import '../responses/manage_booking_response.dart';

class ManageBookingRepository {
  static final ManageBookingRepository _instance =
      ManageBookingRepository._internal();

  static final ManageBookingProvider _provider = ManageBookingProvider(
    Api.client,
    baseUrl: '${AppFlavor.baseUrlApi}/v1/',
  );

  factory ManageBookingRepository() {
    return _instance;
  }


  ManageBookingRepository._internal();

  Future<ManageBookingResponse> getBookingInfo(
      ManageBookingRequest request) async {

    final profile = await _provider.getBookingInfo(
        request.pnr ?? '', request.lastname ?? '','');
    return profile;
  }

  Future<ManageBookingResponse> getBookingInfoForCheckIn(
      ManageBookingRequest request,) async {

    final profile = await _provider.getBookingInfo(
        request.pnr ?? '', request.lastname ?? '','checkin');
    return profile;
  }


  Future<FlightResponse> getAvailableFlights(
      SearchChangeFlightRequest request) async {

    final profile = await _provider.searchForAvailableFlights(request);
    return profile;
  }


  Future<ChangeFlightRequestResponse> changeFlight(
      ChangingFlightRequest request) async {

    final profile = await _provider.changeFlight(request);
    return profile;
  }

  Future<PayRedirectionValue> checkOutFlight(
      MmbCheckoutRequest request) async {

    final profile = await _provider.mmbcheckoutbooking(request);
     return profile;
  }

  Future<MyBookings> bookingListing() async {
    final profile = await _provider.userBookingListing();
    return profile;
  }


  Future<CommonResponse> changeContactsInfo(UpdateBookingContact contactInfo) async {
    final profile = await _provider.updateContacts(contactInfo);
    return profile;
  }




}
