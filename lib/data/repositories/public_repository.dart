import 'package:app/app/app_flavor.dart';
import 'package:app/data/api.dart';
import 'package:app/data/provider/flight_provider.dart';
import 'package:app/data/provider/public_provider.dart';
import 'package:app/data/requests/search_flight_request.dart';
import 'package:app/data/requests/verify_request.dart';
import 'package:app/data/responses/airports_response.dart';
import 'package:app/data/responses/flight_response.dart';
import 'package:app/data/responses/verify_response.dart';
import 'package:app/models/country.dart';

class PublicRepository {
  static final PublicRepository _instance = PublicRepository._internal();

  static final PublicProvider _provider = PublicProvider(
    Api.client,
    baseUrl: '${AppFlavor.baseUrlApi}/v1/',
  );

  factory PublicRepository() {
    return _instance;
  }

  PublicRepository._internal();

  Future<Countries> getCountries() async {
    return await _provider.getCountries();
  }
}
