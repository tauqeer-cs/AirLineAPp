import 'package:app/app/app_flavor.dart';
import 'package:app/data/api.dart';

import '../../models/my_bookings.dart';
import '../../models/pay_redirection.dart';
import '../provider/checkin_provider.dart';
import '../provider/manage_booking_provider.dart';
import '../requests/change_flight_request.dart';
import '../requests/check_in_request.dart';
import '../requests/manage_booking_request.dart';
import '../requests/mmb_checkout_request.dart';
import '../requests/search_change_flight_request.dart';
import '../responses/change_flight_response.dart';
import '../responses/check_in_response.dart';

import '../responses/flight_response.dart';
import '../responses/manage_booking_response.dart';

class CheckInRepository {

  static final CheckInRepository _instance =
  CheckInRepository._internal();

  static final CheckInProvider _provider = CheckInProvider(
    Api.client,
    baseUrl: '${AppFlavor.baseUrlApi}/v1/',
  );

  factory CheckInRepository() {
    return _instance;
  }

  CheckInRepository._internal();

  Future<CheckInResponse> checkInPassenger(CheckInRequest request) async {
    final response = await _provider.checkInPassenger(request);
    return response;
  }


}