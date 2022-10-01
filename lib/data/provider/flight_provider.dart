import 'package:app/data/requests/search_flight_request.dart';
import 'package:app/data/responses/airports_response.dart';
import 'package:app/data/responses/flight_response.dart';
import 'package:app/models/airports.dart';
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
}
