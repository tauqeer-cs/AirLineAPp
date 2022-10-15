import 'package:app/data/requests/book_request.dart';
import 'package:app/data/requests/search_flight_request.dart';
import 'package:app/data/requests/summary_request.dart';
import 'package:app/data/requests/verify_request.dart';
import 'package:app/data/responses/airports_response.dart';
import 'package:app/data/responses/flight_response.dart';
import 'package:app/data/responses/summary_response.dart';
import 'package:app/data/responses/verify_response.dart';
import 'package:app/models/airports.dart';
import 'package:app/models/confirmation_model.dart';
import 'package:app/models/pay_redirection.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'flight_provider.g.dart';

@RestApi()
abstract class FlightProvider {
  factory FlightProvider(Dio dio, {String baseUrl}) = _FlightProvider;
  @GET('flight/getairport')
  Future<AirportsResponse> getAirports();

  @POST('flight/searchflight')
  Future<FlightResponse> searchFlight(@Body() SearchFlight searchFlight);

  @POST('checkout/verifyflight')
  Future<VerifyResponse> verifyFlight(@Body() VerifyRequest verifyRequest);

  @POST('checkout/summaryflight')
  Future<SummaryResponse> summaryFlight(@Body() SummaryRequest summaryRequest);

  @POST('checkout/bookflight')
  Future<PayRedirection> bookFlight(@Body() BookRequest bookRequest);

  @GET('checkout/flightbookingdetail')
  Future<ConfirmationModel> bookingDetail(@Query("superPNRNo") String key);
}
