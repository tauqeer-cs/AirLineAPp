
import 'package:app/app/app_flavor.dart';
import 'package:app/data/api.dart';
import 'package:app/data/provider/flight_provider.dart';
import 'package:app/data/responses/airports_response.dart';

class FlightRepository {
  static final FlightRepository _instance = FlightRepository._internal();

  static final FlightProvider _provider = FlightProvider(
    Api.client,
    baseUrl: '${AppFlavor.baseUrlApi}/v1/',
  );

  factory FlightRepository() {
    return _instance;
  }

  FlightRepository._internal();

  Future<AirportsResponse> getAirports() async {
    return await _provider.getAirports();
  }
}
