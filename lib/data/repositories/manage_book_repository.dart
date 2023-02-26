import 'package:app/app/app_flavor.dart';
import 'package:app/data/api.dart';
import 'package:app/data/provider/public_provider.dart';
import 'package:app/models/country.dart';
import 'package:app/models/switch_setting.dart';

import '../../app/app_bloc_helper.dart';
import '../../utils/error_utils.dart';
import '../provider/manage_booking_provider.dart';
import '../requests/manage_booking_request.dart';
import '../requests/search_change_flight_request.dart';
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
        request.pnr ?? '', request.lastname ?? '');
    return profile;
  }

  Future<FlightResponse> getAvailableFlights(
      SearchChangeFlightRequest request) async {

    final profile = await _provider.searchForAvailableFlights(request);
    return profile;
  }


  //

}
