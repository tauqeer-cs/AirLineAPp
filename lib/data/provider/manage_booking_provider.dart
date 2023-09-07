import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/my_bookings.dart';
import '../../models/pay_redirection.dart';
import '../requests/assign_flight_addon_request.dart';
import '../requests/change_flight_request.dart';
import '../requests/get_flight_addon_request.dart';
import '../requests/manage_booking_request.dart';
import '../requests/mmb_checkout_request.dart';
import '../requests/search_change_flight_request.dart';
import '../requests/update_booking_contacts.dart';
import '../responses/change_flight_response.dart';
import '../responses/change_ssr_response.dart';
import '../responses/common_response.dart';
import '../responses/flight_add_ons_response.dart';
import '../responses/flight_response.dart';
import '../responses/manage_booking_response.dart';

part 'manage_booking_provider.g.dart';

@RestApi()

abstract class ManageBookingProvider {

  factory ManageBookingProvider(Dio dio, {String baseUrl}) = _ManageBookingProvider;


  @GET('checkout/managebookingdetail')
  Future<ManageBookingResponse> getBookingInfo(@Query("pnr") String pnr,@Query("lastname") String lastname,@Query("action") String action);


  @POST('checkout/searchchangeflight')
  Future<FlightResponse> searchForAvailableFlights(@Body() SearchChangeFlightRequest request);


  @POST('checkout/changeflight')
  Future<ChangeFlightRequestResponse> changeFlight(@Body() ChangingFlightRequest request);


  @POST('checkout/mmbcheckoutbooking')
  Future<PayRedirectionValue> mmbcheckoutbooking(@Body() MmbCheckoutRequest request);


  @POST('checkout/email-itinerary-via-pnr')
  Future<CommonResponse> emailItineraryViaPnr(@Body() ManageBookingRequest request);

  @GET('user/userbookinglist')
  Future<MyBookings> userBookingListing();

  @POST('checkout/modifypnr')
  Future<CommonResponse> updateContacts(@Body() UpdateBookingContact request);


  @POST('checkout/getflightaddon')
  Future<FightAddOns> loadFlightAddonRequest(@Body() GetFlightAddonRequest request);

  @POST('checkout/assignflightaddon')
  Future<ChangeSsrResponse> assignFlightAddon(@Body() RequestAssignFlightAddOnRequest request);

  //https://uat-nav-api.myairline.my/api/v1/checkout/removecheckin

  @POST('checkout/removecheckin')
  Future<CommonResponse> removecheckin(@Body() ManageBookingRequest request);


}