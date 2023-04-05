import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/my_bookings.dart';
import '../../models/pay_redirection.dart';
import '../requests/change_flight_request.dart';
import '../requests/check_in_request.dart';
import '../requests/manage_booking_request.dart';
import '../requests/mmb_checkout_request.dart';
import '../requests/search_change_flight_request.dart';
import '../responses/change_flight_response.dart';
import '../responses/check_in_response.dart';
import '../responses/common_response.dart';
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






//https://mya-api.alphareds.com/api/v1/
// CheckInRequest


}